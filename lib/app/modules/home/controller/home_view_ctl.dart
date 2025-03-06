import 'package:ai_web_analyzer/app/models/pdf_handler.dart';
import 'package:ai_web_analyzer/app/models/url_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ai_web_analyzer/app/modules/webview/web_view.dart';
import 'package:ai_web_analyzer/app/routes/app_pages.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

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

  Future<void> goToPdf() async {
    try {
      // Open file picker to select a PDF
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        File pdfFile = File(result.files.single.path!);
        print("PDF Selected: ${pdfFile.path}");
        PdfHandler.pdfpath = pdfFile.path;
        Get.toNamed(Routes.PDFVIEW);

        // Here, you can upload the file to your server or process it
        // Example: Upload function -> uploadPDF(pdfFile);
      } else {
        print("No file selected");
      }
    } catch (e) {
      print("Error picking file: $e");
    }
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
