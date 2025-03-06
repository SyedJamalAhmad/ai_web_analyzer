// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:ai_web_analyzer/app/modules/chat/chat_view_ctl.dart';
// // import 'package:ai_web_analyzer/app/modules/home/controller/home_view_ctl.dart';
// // import 'package:ai_web_analyzer/app/utills/size_config.dart';

// // class ChatWrapper extends StatelessWidget {
// //   const ChatWrapper({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return GetBuilder<ChatViewCTL>(
// //       init: ChatViewCTL(), // Manually initializing controller
// //       builder: (_) => const ChatView(),
// //     );
// //   }
// // }

// // class ChatView extends GetView<ChatViewCTL> {
// //   const ChatView({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     SizeConfig().init(context);

// //     return Scaffold(
// //       body: Text('chatview') );

// //   }

// // }

// import 'dart:io';

// // import 'package:calories_detector/app/modules/aichat/controllers/aichat_controller.dart';
// // import 'package:calories_detector/app/modules/utills/Themes/current_theme.dart';
// // import 'package:calories_detector/app/modules/utills/app_colors.dart';
// // import 'package:calories_detector/app/modules/utills/app_images.dart';
// // import 'package:calories_detector/app/modules/utills/remoteConfigVariables.dart';
// // import 'package:calories_detector/app/premium/premium.dart';
// // import 'package:calories_detector/app/routes/app_pages.dart';
// // import 'package:calories_detector/app/services/remoteconfig_services.dart';
// // import 'package:calories_detector/sizeConfig.dart';
// import 'package:ai_web_analyzer/app/modules/chat/chat_view_ctl.dart';
// import 'package:ai_web_analyzer/app/utills/size_config.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
// // import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:get/get.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// // import 'package:google_generative_ai/google_generative_ai.dart';
// // import 'package:image_picker/image_picker.dart';

// // final String _apiKey = RCVariables.GemeniAPIKey.value;

// // void main() {
// //   runApp(const GenerativeAISample());
// // }

// // class AichatView extends StatelessWidget {
// //   const AichatView({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       // theme: ThemeData(
// //       //   colorScheme: ColorScheme.fromSeed(
// //       //     brightness: Brightness.dark,
// //       //     seedColor: const Color.fromARGB(255, 171, 222, 244),
// //       //   ),
// //       //   useMaterial3: true,
// //       // ),
// //       home: Scaffold(
// //         appBar:AppBar()
// //         //  PreferredSize(
// //         //   preferredSize: Size.fromHeight(80),
// //         //   child: appThemeAppBarforaichat(context, 'Ai Chat'),
// //         // ),
// //         // body: ChatWidget(apiKey: RCVariables.GemeniAPIKey.value),
// //       ),
// //     );
// //   }
// // }

// // class ChatScreen extends StatefulWidget {
// //   const ChatScreen({super.key, required this.title});

// //   final String title;

// //   @override
// //   State<ChatScreen> createState() => _ChatScreenState();
// // }

// // class _ChatScreenState extends State<ChatScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(widget.title),
// //       ),
// //       body: const ChatWidget(apiKey: _apiKey),
// //     );
// //   }
// // }

// // class ChatWidget extends GetView<AichatController> {

// class ChatView extends StatefulWidget {
//   const ChatView({
//     // required this.apiKey,
//     super.key,
//   });

//   // final String apiKey;

//   @override
//   State<ChatView> createState() => _ChatWidgetState();
// }

// class _ChatWidgetState extends State<ChatView>
//     with AutomaticKeepAliveClientMixin {
//   final ChatViewCTL aichatcontroller                                      = Get.put(ChatViewCTL());
//   late final GenerativeModel _model;
//   late final ChatSession _chat;
//   final ScrollController _scrollController = ScrollController();
//   final TextEditingController _textController = TextEditingController();
//   final FocusNode _textFieldFocus = FocusNode();

//   // ChatViewCTL aichatcontroller = Get.find();
//   // Get.put

//   bool _loading = false;
//   bool isImageSelected = false;
//   File? imageFile;

//   @override
//   bool get wantKeepAlive => true; // ✅ Keeps WebView in memory

//   @override
//   void initState() {
//     super.initState();
//     _model = GenerativeModel(
//       model: 'gemini-1.5-flash-latest',
//       apiKey: aichatcontroller.apiKey,
//       generationConfig: GenerationConfig(
//         temperature: 1,
//         topK: 40,
//         topP: 0.95,
//         maxOutputTokens: 1000,
//         responseMimeType: 'text/plain',
//       ),
//       systemInstruction: Content.system(
//           'You are an expert dietician. Generate your response as short as posible and to the point. no need to explain every thing only the necessary elements that are being asked'),
//     );
//     _chat = _model.startChat();
//   }

//   void _scrollDown() {
//     WidgetsBinding.instance.addPostFrameCallback(
//       (_) => _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(
//           milliseconds: 750,
//         ),
//         curve: Curves.easeOutCirc,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final textFieldDecoration = InputDecoration(
//       contentPadding: const EdgeInsets.all(15),
//       hintText: 'Enter a prompt...',
//       border: OutlineInputBorder(
//         borderRadius: const BorderRadius.all(
//           Radius.circular(14),
//         ),
//         borderSide: BorderSide(
//           color: Theme.of(context).colorScheme.secondary,
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: const BorderRadius.all(
//           Radius.circular(14),
//         ),
//         borderSide: BorderSide(
//           color: Theme.of(context).colorScheme.secondary,
//         ),
//       ),
//     );

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: aichatcontroller.apiKey.isNotEmpty
//                 ? (aichatcontroller.generatedContent.isNotEmpty
//                     ? ListView.builder(
//                         controller: _scrollController,
//                         itemBuilder: (context, idx) {
//                           // content = aichatcontroller.;
//                           final content =
//                               aichatcontroller.generatedContent[idx];
//                           return MessageWidget(
//                             text: content.text,
//                             image: content.image,
//                             isFromUser: content.fromUser,
//                             isFeedBack: content.isFeedBack,
//                             isGood: content.isGood,
//                             index: idx,
//                           );
//                         },
//                         itemCount: aichatcontroller.generatedContent.length,
//                       )
//                     : _buildDefaultPrompts())
//                 : ListView(
//                     children: const [
//                       Text(
//                         'No API key found. Please provide an API Key using '
//                         "'--dart-define' to set the 'API_KEY' declaration.",
//                       ),
//                     ],
//                   ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               vertical: 12,
//               horizontal: 15,
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     autofocus: true,
//                     focusNode: _textFieldFocus,
//                     decoration: textFieldDecoration,
//                     controller: _textController,
//                     onSubmitted: _sendChatMessage,
//                   ),
//                 ),
//                 const SizedBox.square(dimension: 5),
//                 // InkWell(
//                 //   onTap: !_loading
//                 //       ? () async {
//                 //           // _sendImagePrompt(_textController.text);
//                 //           if (!isImageSelected) {
//                 //             pickImageFromGallery();
//                 //           } else {
//                 //             setState(() {
//                 //               isImageSelected = false;
//                 //             });
//                 //           }
//                 //         }
//                 //       : null,
//                 //   child: isImageSelected
//                 //       ? Container(
//                 //           width: 30,
//                 //           height: 30,
//                 //           decoration: BoxDecoration(
//                 //             border: Border.all(color: Colors.black, width: 1),
//                 //             borderRadius: BorderRadius.circular(8),
//                 //           ),
//                 //           child: ClipRRect(
//                 //             borderRadius: BorderRadius.circular(
//                 //                 8), // Match the container's borderRadius
//                 //             child: Image.file(
//                 //               imageFile!,
//                 //               fit: BoxFit.cover,
//                 //             ),
//                 //           ),
//                 //         )
//                 //       : Icon(
//                 //           Icons.image,
//                 //           size: 30,
//                 //           color: _loading
//                 //               ? Theme.of(context).colorScheme.secondary
//                 //               : Theme.of(context).colorScheme.primary,
//                 //         ),
//                 // ),

//                 if (!_loading)
//                   InkWell(
//                     onTap: () {
//                       _sendChatMessage(_textController.text);
//                     },
//                     child: Stack(
//                       children: [
//                         Icon(
//                           Icons.send,
//                           size: 30,
//                           color: Theme.of(context).colorScheme.primary,
//                         ),
//                         Positioned(
//                             right: 3,
//                             bottom: 0,
//                             child: Container(
//                               height: 15,
//                               width: 15,
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.circle, color: Colors.red),
//                               child: Center(
//                                 child: Text(
//                                   isImageSelected ? '5' : '1',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 10,
//                                       height: 1),
//                                 ),
//                               ),
//                             ))
//                       ],
//                     ),
//                   )
//                 // IconButton(
//                 //   onPressed: () async {
//                 //     _sendChatMessage(_textController.text);
//                 //   },
//                 //   icon: Icon(
//                 //     Icons.send,
//                 //     size: 30,
//                 //     color: Theme.of(context).colorScheme.primary,
//                 //   ),
//                 // )
//                 else
//                   const CircularProgressIndicator(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDefaultPrompts() {
//     List<String> randomPrompts = aichatcontroller.randomPrompts;
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.fromLTRB(48, 12, 48, 24),
//           child: Container(
//             height: 42,
//             decoration: BoxDecoration(
//                 color: Colors.amber[100],
//                 border: Border.all(color: Colors.amber),
//                 borderRadius: BorderRadius.circular(12)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 SizedBox(),
//                 Icon(
//                   Icons.info_outline,
//                   color: Colors.black.withOpacity(0.3),
//                 ),
//                 Text(
//                   'This is a temporary chat',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.black.withOpacity(0.6),
//                   ),
//                 ),
//                 SizedBox(),
//                 SizedBox(),
//                 SizedBox(),
//               ],
//             ),
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//                 onPressed: () {
//                   aichatcontroller.newDefaultPrompts();

//                   setState(() {});
//                 },
//                 child: Row(
//                   children: [
//                     Text('Refresh'),
//                     Icon(Icons.refresh),
//                   ],
//                 ))
//             // GestureDetector(onTap: () {}, child: Icon(Icons.refresh)),
//           ],
//         ),
//         Expanded(
//           child: ListView.builder(
//             itemCount: randomPrompts.length,
//             itemBuilder: (context, idx) {
//               return ListTile(
//                 title: Padding(
//                   padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
//                   // padding: EdgeInsets.all(0),
//                   child: Container(
//                     // height: 50,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         // color: Colors.amber[100],
//                         // border: Border.all(color: Colors.amber),
//                         border: Border.all(color: Colors.black12),
//                         borderRadius: BorderRadius.circular(12)),
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
//                       child: Text(
//                         randomPrompts[idx],
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.black.withOpacity(0.6),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 onTap: () {
//                   setState(() {
//                     _textController.text = randomPrompts[idx];
//                     _textFieldFocus.requestFocus();
//                   });
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   // Future<void> pickImageFromGallery() async {
//   //   // final ImagePicker picker = ImagePicker();
//   //   try {
//   //     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//   //     if (image != null) {
//   //       setState(() {
//   //         imageFile = File(image.path);
//   //         isImageSelected = true;
//   //       });

//   //       print('Image Path: ${image.path}');
//   //       print('Image seted');
//   //       // sendImageToGoogleAI(imageFile);
//   //     }
//   //   } catch (e) {
//   //     print('Failed to pick image: $e');
//   //   }
//   // }

//   // Future<void> _sendImagePrompt(String message) async {
//   //   setState(() {
//   //     _loading = true;
//   //   });
//   //   try {
//   //     Uint8List imgBytes = await imageFile!.readAsBytes();
//   //     // ByteData catBytes = await imageFile!.readAsBytes();
//   //     // ByteData catBytes = await imageFile.readAsBytes();
//   //     // ByteData catBytes = await rootBundle.load('assets/images/cat.jpg');
//   //     // ByteData sconeBytes = await rootBundle.load('assets/images/scones.jpg');
//   //     // ByteData catBytes = await rootBundle.load('assets/images/cat.jpg');
//   //     final content = [
//   //       Content.multi([
//   //         TextPart(message),
//   //         // The only accepted mime types are image/*.
//   //         DataPart('image/jpeg', imgBytes.buffer.asUint8List()),
//   //       ])
//   //     ];
//   //     aichatcontroller.generatedContent.add((
//   //       // image: Image.asset("assets/cat.jpg"),
//   //       image: Image.file(imageFile!),
//   //       text: message,
//   //       fromUser: true,
//   //       isFeedBack: false.obs,
//   //       isGood: false.obs
//   //     ));
//   //     // _generatedContent.add((
//   //     //   image: Image.asset("assets/scones.jpg"),
//   //     //   text: null,
//   //     //   fromUser: true
//   //     // ));

//   //     var response = await _model.generateContent(content);
//   //     var text = response.text;
//   //     aichatcontroller.generatedContent.add((
//   //       image: null,
//   //       text: text,
//   //       fromUser: false,
//   //       isFeedBack: false.obs,
//   //       isGood: false.obs
//   //     ));

//   //     if (text == null) {
//   //       _showError('No response from API.');
//   //       return;
//   //     } else {
//   //       setState(() {
//   //         _loading = false;
//   //         isImageSelected = false;
//   //         _scrollDown();
//   //       });
//   //     }
//   //     Premium.instance.reduce1(5);
//   //     print('reduced by 5');
//   //   } catch (e) {
//   //     _showError(e.toString());
//   //     setState(() {
//   //       _loading = false;
//   //     });
//   //   } finally {
//   //     _textController.clear();
//   //     setState(() {
//   //       _loading = false;
//   //     });
//   //     _textFieldFocus.requestFocus();
//   //   }
//   // }

//   Future<void> _sendChatMessage(String message) async {
//     setState(() {
//       _loading = true;
//     });
//     // if (isImageSelected) {
//     //   if (Premium.instance.apple!.value >= 5) {
//     //     _sendImagePrompt(message);
//     //   } else {
//     //     setState(() {
//     //       _loading = false;
//     //       isImageSelected = false;
//     //     });
//     //     Get.toNamed(Routes.PAYWALL);
//     //   }
//     // }
//     //  else if (Premium.instance.apple!.value >= 1) {
//     try {
//       aichatcontroller.generatedContent.add((
//         image: null,
//         text: message,
//         fromUser: true,
//         isFeedBack: false.obs,
//         isGood: false.obs
//       ));
//       final response = await _chat.sendMessage(
//         Content.text(message),
//       );
//       final text = response.text;
//       aichatcontroller.generatedContent.add((
//         image: null,
//         text: text,
//         fromUser: false,
//         isFeedBack: false.obs,
//         isGood: false.obs
//       ));

//       if (text == null) {
//         _showError('No response from API.');
//         return;
//       } else {
//         setState(() {
//           _loading = false;
//           _scrollDown();
//         });
//       }
//       // Premium.instance.reduce1(1);
//       print('reduced by 1');
//     } catch (e) {
//       _showError(e.toString());
//       setState(() {
//         _loading = false;
//       });
//     } finally {
//       _textController.clear();
//       setState(() {
//         _loading = false;
//       });
//       _textFieldFocus.requestFocus();
//     }

//     // } else {
//     //   setState(() {
//     //     _loading = false;
//     //   });
//     //   // Get.toNamed(Routes.PAYWALL);
//     // }
//   }

//   void _showError(String message) {
//     showDialog<void>(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Something went wrong'),
//           content: SingleChildScrollView(
//             child: SelectableText(message),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('OK'),
//             )
//           ],
//         );
//       },
//     );
//   }
// }

// class MessageWidget extends GetView<ChatViewCTL> {
//   MessageWidget({
//     super.key,
//     this.image,
//     this.text,
//     required this.isFromUser,
//     required this.isFeedBack,
//     required this.isGood,
//     required this.index,
//   });

//   final Image? image;
//   final String? text;
//   final bool isFromUser;
//   final RxBool isFeedBack;
//   final RxBool isGood;
//   final int index;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment:
//               isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
//           children: [
//             Flexible(
//                 child: Container(
//                     constraints:
//                         BoxConstraints(maxWidth: SizeConfig.screenWidth * 0.75),
//                     decoration: BoxDecoration(
//                       color: isFromUser
//                           // ? AppThemeColors.onPrimary2
//                           // : AppThemeColors.onPrimary1,
//                           ? Theme.of(context).colorScheme.primaryContainer
//                           : Theme.of(context)
//                               .colorScheme
//                               .surfaceContainerHighest,
//                       borderRadius: BorderRadius.circular(18),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 15,
//                       horizontal: 20,
//                     ),
//                     margin: const EdgeInsets.only(bottom: 8),
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (image case final image?)
//                             Padding(
//                                 padding: EdgeInsets.only(bottom: 10),
//                                 child: image),
//                           if (text case final text?)
//                             MarkdownBody(
//                               data: text,
//                               //   styleSheet: isFromUser
//                               //       ? MarkdownStyleSheet()
//                               //       : MarkdownStyleSheet(
//                               //           p: const TextStyle(
//                               //               color: Colors.white), // Paragraph text color
//                               //           h1: const TextStyle(
//                               //               color: Colors.white), // Header 1 color
//                               //           h2: const TextStyle(
//                               //               color: Colors.white), // Header 2 color
//                               //           strong: const TextStyle(
//                               //               color: Colors.white), // Bold text color
//                               //           em: const TextStyle(color: Colors.white),
//                               //         ),
//                             ),
//                         ]))),
//           ],
//         ),
//         Container(
//           // width: SizeConfig.screenWidth,
//           // color: Colors.red,
//           margin: EdgeInsets.symmetric(
//               // vertical: SizeConfig.blockSizeVertical * 1,
//               horizontal: SizeConfig.blockSizeHorizontal * 5),
//           child: Row(
//             mainAxisAlignment:
//                 isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               // IconButton(
//               //     padding: EdgeInsets.zero,
//               //     color: Colors.white,
//               //     tooltip: "Share",
//               //     onPressed: () {
//               //       controller.ShareMessage(
//               //           controller.chatList[index].message);
//               //     },
//               //     icon: Icon(Icons.share)),

//               // horizontalSpace(SizeConfig.blockSizeHorizontal*2),

//               // IconButton(
//               //     padding: EdgeInsets.zero,
//               //     color: Colors.white,
//               //     tooltip: "Copy",
//               //     onPressed: () {
//               //       controller.CopyMessage(
//               //           controller.chatList[index].message);
//               //     },
//               //     icon: Icon(
//               //       Icons.copy_rounded,
//               //       size: iconSize,
//               //     )),

//               // !isSender && !(isFeedback && !isGood)
//               Obx(
//                 () => !(isFeedBack.value && !isGood.value) && !isFromUser
//                     // 0 == 0
//                     ? IconButton(
//                         padding: EdgeInsets.zero,
//                         color: Colors.black45,
//                         tooltip: "Good",
//                         onPressed: () {
//                           if (0 == 0)
//                           //  (!isFeedback)
//                           {
//                             controller.GoodResponse(
//                                 // controller.chatList[index].message,
//                                 // index
//                                 text!,
//                                 index);
//                           }
//                         },
//                         icon: Icon(
//                           isFeedBack.value && isGood.value
//                               ? Icons.thumb_up
//                               : Icons.thumb_up_alt_outlined,
//                           size: 30,
//                           // size: iconSize,
//                         ))
//                     : Container(),
//               ),
// //
// //-----------------------------------------------------------------------------------------------------------------------------------------
// //

//               // !isSender && !(isFeedback && isGood)
//               // 0 == 0
//               Obx(
//                 () => !(isFeedBack.value && isGood.value) && !isFromUser
//                     ? IconButton(
//                         padding: EdgeInsets.zero,
//                         color: Colors.black45,
//                         tooltip: "Bad Response",
//                         onPressed: () {
//                           if
//                               // (0 == 0)
//                               (!isFeedBack.value) {
//                             controller.reportMessage(
//                                 Get.context!,
//                                 text!
//                                 // controller.chatList[index].message,
//                                 ,
//                                 index);
//                           }
//                         },
//                         icon: Icon(
//                           isFeedBack.value && !isGood.value
//                               ? Icons.thumb_down
//                               : Icons.thumb_down_alt_outlined,
//                           size: 30,
//                           // size: iconSize,
//                         ))
//                     : Container(),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

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
    GenerativeModel aiModel = GenerativeModel(
        model: 'gemini-2.0-flash-lite',
        apiKey: 'AIzaSyCj-pkjlMrppk-ZNsPlkFq5U9t9jeUahr8',
        // generationConfig: GenerationConfig(maxOutputTokens: 200),
        systemInstruction: Content.system(
            'Act as a web data analyzer and professional content analyzer and gather some information about this webpage: ${UrlHandler.url} and the content of this webpage is ${WebContentManager.currentContent} and than answer the queries of user. try your best to answer it accordingly from this webpage and if there is not enough information than return a made of answer but very much accurate as you can. Try your best to make accurate precise and short possible answer.'));

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
      appBar: AppBar(title: const Text('Chat with AI')),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    return ChatBubble(message: message);
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.textController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: controller.sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: message.type == MessageType.user
          ? MainAxisAlignment.end
          : message.type == MessageType.ai
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start, // Align to top
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: SizeConfig.screenWidth * 0.75),
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: message.type == MessageType.user
                ? Colors.yellow.shade700
                : message.type == MessageType.ai
                    ? Colors.blueGrey.shade600
                    : Colors.amberAccent.shade400,
            borderRadius: BorderRadius.circular(10),
          ),
          child: message.type == MessageType.ai
              ? MarkdownBody(
                  data: message.text,
                  styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                      .copyWith(p: const TextStyle(color: Colors.white)),
                )
              : Text(message.text, style: const TextStyle(color: Colors.white)),
        ),
        if (message.type == MessageType.ai) // Don't show copy button for notes
          CopyToClipboardButton(text: message.text),
      ],
    );
  }
}
