import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ai_web_analyzer/app/modules/chat/chat_view.dart';
import 'package:ai_web_analyzer/app/modules/home/controller/home_view_ctl.dart';
import 'package:ai_web_analyzer/app/modules/url/url_view_ctl.dart';
import 'package:ai_web_analyzer/app/modules/webview/web_view.dart';
import 'package:ai_web_analyzer/app/utills/size_config.dart';

class URLView extends GetView<URLViewCTL> {
  const URLView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: const Center(
      //     child: Text(
      //       'Chat with WebPage',
      //       style: TextStyle(
      //         fontSize: 24,
      //         fontWeight: FontWeight.bold,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ),
      //   automaticallyImplyLeading: false,
      //   backgroundColor: const Color(0xFF1A73E8),
      //   elevation: 0,
      // ),
      body: DefaultTabController(
        length: 2, // Two Tabs
        child: Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Chat with WebPage',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            automaticallyImplyLeading: false,
            elevation: 0,
            centerTitle: true,
            backgroundColor: const Color(0xFF1A73E8), // Your Color
            bottom: const TabBar(
              indicatorColor: Colors.white, // White Indicator
              indicatorWeight: 3.0, // Modern Look
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              tabs: [
                Tab(icon: Icon(Icons.language), text: "Browsing"),
                Tab(icon: Icon(Icons.chat), text: "Ai Chat"),
//               Tab(
//   child: Row(
//     mainAxisSize: MainAxisSize.min, // Prevents taking full width
//     children: [
//       Icon(Icons.language),
//       SizedBox(width: 8), // Space between icon and text
//       Text("Browsing"),
//     ],
//   ),
// ),
// Tab(
//   child: Row(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       Icon(Icons.chat),
//       SizedBox(width: 8),
//       Text("Ai Chat"),
//     ],
//   ),
// ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              WebWrapper(), // First View
              ChatWrapper(), // Second View
            ],
          ),
        ),
      ),
    );
  }
}
