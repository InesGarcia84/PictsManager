import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:picts_manager/flutter_flow/flutter_flow_theme.dart';
import 'package:picts_manager/flutter_flow/flutter_flow_util.dart';
import 'package:picts_manager/utils/navigation_controls.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'dart:io';

class MyWebView extends StatefulWidget {
  const MyWebView(
      {Key? key,
      this.cookieManager,
      required this.url,
      required this.title,
      required this.showControls})
      : super(key: key);

  final CookieManager? cookieManager;
  final String url;
  final String title;
  final bool showControls;

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  double loadingProgress = 0.0;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        leading: IconButton(
          splashRadius: 1,
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          widget.showControls == true
              ? NavigationControls(_controller.future)
              : Container(),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          if (loadingProgress < 1)
            LinearProgressIndicator(
              value: loadingProgress,
              minHeight: 2,
              backgroundColor: Colors.white,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          Expanded(
            child: WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onProgress: (int progress) {
                print('WebView is loading (progress : $progress%)');
                setState(() {
                  loadingProgress = progress / 100;
                });
              },
              javascriptChannels: <JavascriptChannel>{
                _toasterJavascriptChannel(context),
              },
              navigationDelegate: (NavigationRequest request) {
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                print('Page started loading: $url');
              },
              onPageFinished: (String url) {},
              gestureNavigationEnabled: true,
              backgroundColor: const Color(0x00000000),
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        showSnackbar(context, message.message);
      },
    );
  }
}
