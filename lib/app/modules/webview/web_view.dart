import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_web_analyzer/app/models/current_content.dart';
import 'package:ai_web_analyzer/app/models/url_handler.dart';
import 'package:ai_web_analyzer/app/modules/webview/web_view_ctl.dart';
import 'package:ai_web_analyzer/app/utills/size_config.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebWrapper extends StatelessWidget {
  const WebWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebViewCTL>(
      init: WebViewCTL(), // Manually initializing controller
      builder: (_) => const WebView(),
    );
  }
}

class WebView extends GetView<WebViewCTL> {
  const WebView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WebViewScreen(initialUrl: UrlHandler.url,);
  }
}




class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _urlController = TextEditingController(text: 'https://openrouter.ai/');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Website URL')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              
              controller: _urlController,
              decoration: InputDecoration(
                
                hintText: 'https://example.com',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final url = _urlController.text.trim();
                if (url.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewScreen(initialUrl: url),
                    ),
                  );
                }
              },
              child: Text('Open WebView'),
            ),
          ],
        ),
      ),
    );
  }
}

class WebViewScreen extends StatefulWidget {
  final String initialUrl;

  WebViewScreen({required this.initialUrl});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            // Allow navigation and update content for the new URL
            if (request.url.startsWith('http')) {
              WebContentManager.updateContent(request.url);
            }
            return NavigationDecision.navigate;
          },
          onPageStarted: (url) {
            // Update content when a new page starts loading
            WebContentManager.updateContent(url);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.initialUrl));

    // Initialize content for the initial URL
    WebContentManager.updateContent(widget.initialUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Web Browser')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Print the current content to the console
          print('Current Content: ${WebContentManager.currentContent}');
        },
        child: Icon(Icons.chat),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
