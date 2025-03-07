import 'dart:io';
import 'package:ai_web_analyzer/app/modules/pdf/pdf_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:developer' as developer;

class PdfHandler {
  static String pdfpath = '';
  static String pdfText = '';
  static RxBool isLoading = false.obs;
  Future<void> extractTextFromPDF() async {
    try {
         isLoading.value = true;
      // Pick a PDF file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
        File pdfFile = File(result.files.single.path!);
        pdfpath = result.files.single.path!;
        print("PDF Selected: ${pdfFile.path}");

        // Load the PDF document
        List<int> bytes = await pdfFile.readAsBytes();
        PdfDocument document = PdfDocument(inputBytes: bytes);

        // Extract text from all pages
        String extractedText = PdfTextExtractor(document).extractText();
        pdfText = extractedText;

        // Close the document
        document.dispose();
        developer.log(pdfText);
        // Print extracted text (or display it in UI)
        Get.to(const PDFView());
        print("Extracted Text:\n$extractedText");
      } else {
        print("No file selected");
      }
    } catch (e) {
      print("Error extracting text: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
