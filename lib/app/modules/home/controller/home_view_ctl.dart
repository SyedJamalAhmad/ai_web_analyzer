import 'package:ai_web_analyzer/app/models/url_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ai_web_analyzer/app/modules/webview/web_view.dart';
import 'package:ai_web_analyzer/app/routes/app_pages.dart';

class HomeViewCTL extends GetxController {
  final TextEditingController searchController = TextEditingController();

  void goToUrl(BuildContext context) {
    final url = searchController.text.trim();
    // if (url.isNotEmpty) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => WebViewScreen(initialUrl: url),
    //     ),
    //   );
    // }
    UrlHandler.url = url;
    Get.toNamed(Routes.URLVIEW);
    // Get.toNamed(Routes.URLVIEW,arguments: [url]);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}

// class CustomTextSelectionControls extends MaterialTextSelectionControls {
//   @override
//   Color getHandleColor(BuildContext context) {
//     return Colors.white; // Change handle color to white
//   }
// }
