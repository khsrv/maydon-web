import 'package:flutter/material.dart';
import 'package:postj/src/theme/app_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class ScorersPage extends StatefulWidget {
  const ScorersPage({super.key});

  @override
  State<ScorersPage> createState() => _ScorersPageState();
}

class _ScorersPageState extends State<ScorersPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    const hideScript = '''
      (function(){
        var h = document.querySelector('header');
        if (h) h.style.display = 'none';
        var f = document.querySelector('footer');
        if (f) f.style.display = 'none';
      })();
    ''';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(kWebViewBgLight)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (mounted) {
              setState(() => _isLoading = true);
            }
          },
          onPageFinished: (_) {
            _controller.runJavaScript(hideScript).catchError((_) {});
            if (mounted) {
              setState(() => _isLoading = false);
            }
          },
        ),
      );

    final platform = _controller.platform;
    if (platform is WebKitWebViewController) {
      platform.setAllowsBackForwardNavigationGestures(true);
    }

    _controller.loadRequest(
      Uri.parse('https://maydon.join.football/tournament/1060010/stats'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWebViewBgLight,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: kBlue))
          : WebViewWidget(controller: _controller),
    );
  }
}
