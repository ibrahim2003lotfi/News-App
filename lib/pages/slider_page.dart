import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SliderPage extends StatefulWidget {
  final String blogUrl;

  const SliderPage({super.key, required this.blogUrl});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
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
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              ' News',
              style: TextStyle(
                fontFamily: 'Libertinus Serif',
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),
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