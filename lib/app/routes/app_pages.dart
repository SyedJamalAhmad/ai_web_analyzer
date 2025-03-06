import 'package:ai_web_analyzer/app/modules/pdf/pdf_view.dart';
import 'package:ai_web_analyzer/app/modules/pdf/pdf_view_binding.dart';
import 'package:get/get.dart';
import 'package:ai_web_analyzer/app/modules/chat/chat_view.dart';
import 'package:ai_web_analyzer/app/modules/chat/chat_view_binding.dart';
import 'package:ai_web_analyzer/app/modules/home/binding/home_view_binding.dart';
import 'package:ai_web_analyzer/app/modules/home/views/home_view.dart';
import 'package:ai_web_analyzer/app/modules/url/url_view.dart';
import 'package:ai_web_analyzer/app/modules/url/url_view_binding.dart';
import 'package:ai_web_analyzer/app/modules/webview/web_view.dart';
import 'package:ai_web_analyzer/app/modules/webview/web_view_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOMEVIEW;

  static final routes = [
   
    GetPage(
      name: _Paths.HOMEVIEW,
      page: () => HomeView(),
      binding: HomeViewBinding(),
    ),
    GetPage(
      name: _Paths.WEBVIEW,
      page: () => WebView(),
      binding: WebViewBinding(),
    ),
    GetPage(
      name: _Paths.URLVIEW,
      page: () => URLView(),
      binding: URLViewBinding(),
    ),
    GetPage(
      name: _Paths.CHATVIEW,
      page: () => ChatView(),
      binding: ChatViewBinding(),
    ),
    GetPage(
      name: _Paths.PDFVIEW,
      page: () => PDFView(),
      binding: PDFViewBinding(),
    ),
  ];
}
