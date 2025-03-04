import 'package:http/http.dart' as http;

class WebContentManager {
  static String _currentContent = '';

  static String get currentContent => _currentContent;

  static Future<void> updateContent(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        _currentContent = response.body;
        print('Content updated for: $url');
      } else {
        _currentContent =
            'Error: Failed to fetch content (Status Code: ${response.statusCode})';
      }
    } catch (e) {
      _currentContent = 'Error: $e';
    }

    print('URICONTENT $_currentContent');
    print('URICONTENTLength ${_currentContent.length}');
  }
}
