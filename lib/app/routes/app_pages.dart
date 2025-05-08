import 'package:get/get.dart';

import '../modules/chat/chat_view.dart';
import '../modules/chat/chat_view_binding.dart';
import '../modules/home/binding/home_view_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/pdf/pdf_view.dart';
import '../modules/pdf/pdf_view_binding.dart';
import '../modules/pdf_compress/bindings/pdf_compress_binding.dart';
import '../modules/pdf_compress/views/pdf_compress_view.dart';
import '../modules/pdf_info/bindings/pdf_info_binding.dart';
import '../modules/pdf_info/views/pdf_info_view.dart';
import '../modules/pdf_merge/bindings/pdf_merge_binding.dart';
import '../modules/pdf_merge/views/pdf_merge_view.dart';
import '../modules/pdf_operations/bindings/pdf_operations_binding.dart';
import '../modules/pdf_operations/views/pdf_operations_view.dart';
import '../modules/url/url_view.dart';
import '../modules/url/url_view_binding.dart';
import '../modules/webview/web_view.dart';
import '../modules/webview/web_view_binding.dart';

// import '../modules/compress_pdf/bindings/compress_pdf_binding.dart';
// import '../modules/compress_pdf/views/compress_pdf_view.dart';
// import '../modules/info_pdf/bindings/info_pdf_binding.dart';
// import '../modules/info_pdf/views/info_pdf_view.dart';
// import '../modules/merge_pdf/bindings/merge_pdf_binding.dart';
// import '../modules/merge_pdf/views/merge_pdf_view.dart';

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
    // GetPage(
    //   name: _Paths.MERGE_PDF,
    //   page: () => const MergePdfView(),
    //   binding: MergePdfBinding(),
    // ),
    // GetPage(
    //   name: _Paths.COMPRESS_PDF,
    //   page: () => const CompressPdfView(),
    //   binding: CompressPdfBinding(),
    // ),
    // GetPage(
    //   name: _Paths.INFO_PDF,
    //   page: () => const InfoPdfView(),
    //   binding: InfoPdfBinding(),
    // ),
    GetPage(
      name: _Paths.PDF_INFO,
      page: () => PdfInfoView(),
      binding: PdfInfoBinding(),
    ),
    GetPage(
      name: _Paths.PDF_MERGE,
      page: () => const PdfMergeView(),
      binding: PdfMergeBinding(),
    ),
    GetPage(
      name: _Paths.PDF_COMPRESS,
      page: () => const PdfCompressView(),
      binding: PdfCompressBinding(),
    ),
    GetPage(
      name: _Paths.PDF_OPERATIONS,
      page: () => const PdfOperationsView(),
      binding: PdfOperationsBinding(),
    ),
  ];
}
