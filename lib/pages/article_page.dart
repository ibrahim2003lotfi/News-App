import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticlePage extends StatefulWidget {
  final String blogUrl;

  const ArticlePage({super.key, required this.blogUrl});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  late final WebViewController controller;
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.blogUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'LD',
              style: TextStyle(
                fontFamily: 'Libertinus Serif',
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              ' News',
              style: TextStyle(
                fontFamily: 'Libertinus Serif',
                fontWeight: FontWeight.w900,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100,
              backgroundColor: Colors.transparent,
              minHeight: 3,
              color: Colors.blue,
            ),
        ],
      ),
    );
  }
}
