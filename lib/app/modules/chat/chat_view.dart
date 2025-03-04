import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ai_web_analyzer/app/modules/chat/chat_view_ctl.dart';
import 'package:ai_web_analyzer/app/modules/home/controller/home_view_ctl.dart';
import 'package:ai_web_analyzer/app/utills/size_config.dart';


class ChatWrapper extends StatelessWidget {
  const ChatWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatViewCTL>(
      init: ChatViewCTL(), // Manually initializing controller
      builder: (_) => const ChatView(),
    );
  }
}


class ChatView extends GetView<ChatViewCTL> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Text('chatview') );
  
  }

}
