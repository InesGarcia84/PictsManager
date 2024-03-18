// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:picts_manager/flutter_flow/flutter_flow_util.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture, {Key? key})
      : assert(_webViewControllerFuture != null),
        super(key: key);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController? controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              splashRadius: 1,
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller!.canGoBack()) {
                        await controller.goBack();
                      } else {
                        showSnackbar(context, 'Aucun historique');
                        return;
                      }
                    },
            ),
            IconButton(
              splashRadius: 1,
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller!.canGoForward()) {
                        await controller.goForward();
                      } else {
                        showSnackbar(context, 'Aucune page suivante');
                        return;
                      }
                    },
            ),
            IconButton(
              splashRadius: 1,
              icon: const Icon(Icons.replay, color: Colors.black),
              onPressed: !webViewReady
                  ? null
                  : () {
                      controller!.reload();
                    },
            ),
          ],
        );
      },
    );
  }
}
