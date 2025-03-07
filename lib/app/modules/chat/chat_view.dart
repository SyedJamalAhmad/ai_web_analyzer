import 'package:ai_web_analyzer/app/models/ai_handler.dart';
import 'package:ai_web_analyzer/app/models/current_content.dart';
import 'package:ai_web_analyzer/app/models/url_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:developer' as developer;
import 'package:flutter/services.dart'; // For Clipboard
import 'package:flutter_markdown/flutter_markdown.dart'; // For Markdown
import 'package:ai_web_analyzer/app/utills/size_config.dart'; // Assuming you still need this

class Message {
  final String text;
  final MessageType type;

  Message({required this.text, required this.type});
}

enum MessageType { user, ai, note }

class ChatController extends GetxController {
  final RxList<Message> messages = <Message>[].obs;
  final TextEditingController textController = TextEditingController();

  // Initialize the conversation history.  Make it Rx so the UI rebuilds when the history changes.
  final RxList<Content> history = <Content>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load saved chat history from local storage here if needed
  }

  @override
  void onClose() {
    // Save chat history to local storage here
    textController.dispose();
    super.onClose();
  }

  Future<void> sendMessage() async {
    GenerativeModel aiModel = AiHandler.getAiModel();
    if (textController.text.trim().isEmpty) return;

    String userMessage = textController.text.trim();
    textController.clear();

    // Add user message immediately to the UI
    messages.add(Message(text: userMessage, type: MessageType.user));
    update(); // Notify UI to update

    EasyLoading.show(status: 'Thinking...');

    try {
      // Prepare the content for the AI model.
      final content = Content('user', [TextPart(userMessage)]);
      
      // Add the user's message to the history.
      history.add(content);

      // Limit the history to the last 10 messages (5 user + 5 model).
      while (history.length > 20) {
        history.removeAt(0); // Remove the oldest message.
      }
      developer.log('${history.length}');
      // Use the `history` argument in `generateContent`.
      final response = await aiModel
          .generateContent(history.toList()); // Convert RxList to List

      if (response != null && response.text != null) {
        // Process the response
        String aiResponse = response.text!;

        // Add AI response to history and messages
        history.add(Content('model', [TextPart(aiResponse)]));

        // Limit the history *again* after adding the AI's response, for safety.
        while (history.length > 10) {
          history.removeAt(0);
        }

        messages.add(Message(text: aiResponse, type: MessageType.ai));
        update(); //update UI
      } else {
        // Handle no response or null text
        messages.add(Message(
            text: 'AI returned an empty response.', type: MessageType.note));
        update();
        developer.log('AI returned null response');
      }
    } catch (e) {
      // Handle errors during API call
      messages.add(Message(
          text: 'Something went wrong, Please try again',
          type: MessageType.note));
      // messages.add(Message(text: 'Error: $e', type: MessageType.note));
      developer.log('Error during AI response: $e');
    } finally {
      EasyLoading.dismiss();
      update(); // Ensure UI is updated after processing
    }
  }
}

// New Widget for Copying to Clipboard
class CopyToClipboardButton extends StatelessWidget {
  final String text;

  const CopyToClipboardButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.copy, size: 16),
      onPressed: () {
        Clipboard.setData(ClipboardData(text: text));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Text copied to clipboard')),
        );
      },
    );
  }
}

class ChatView extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Chat', style: TextStyle(fontWeight: FontWeight.bold)),),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade50, Colors.grey.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    return ChatBubble(message: message);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: controller.textController,
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade600, Colors.blue.shade400],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send_rounded, color: Colors.white),
                      onPressed: controller.sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: message.type == MessageType.user
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message.type == MessageType.ai)
            CircleAvatar(
              radius: SizeConfig.blockSizeHorizontal * 4,
              backgroundColor: Colors.blueGrey.shade300,
              child: Icon(
                Icons.memory,
                color: Colors.amber,
                size: SizeConfig.blockSizeHorizontal * 5,
              ),
            ),
          const SizedBox(width: 8),
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.65),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: message.type == MessageType.user
                  ? Colors.blue.shade600
                  : Colors.blueGrey.shade50,
              borderRadius: BorderRadius.only(
                topLeft: message.type == MessageType.user
                    ? Radius.circular(12)
                    : Radius.circular(4),
                topRight: message.type == MessageType.user
                    ? Radius.circular(4)
                    : Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: message.type == MessageType.ai
                ? MarkdownBody(
                    data: message.text,
                    styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                        .copyWith(p: TextStyle(color: Colors.grey.shade800)),
                  )
                : Text(message.text,
                    style: const TextStyle(color: Colors.white)),
          ),
          //  const SizedBox(width: 8),
          // if (message.type == MessageType.user)
          //    CircleAvatar(
          //     radius: SizeConfig.blockSizeHorizontal * 4,
          //     backgroundColor: Colors.blue,
          //     child: Icon(Icons.person, color: Colors.white,
          //     size: SizeConfig.blockSizeHorizontal * 4,
          //     ),
          //   ),

          if (message.type == MessageType.ai)
            IconButton(
              icon:
                  const Icon(Icons.content_copy, size: 16, color: Colors.grey),
              onPressed: () =>
                  Clipboard.setData(ClipboardData(text: message.text)),
            ),
        ],
      ),
    );
  }
}
