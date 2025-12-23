import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:postj/src/theme/app_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

// Для веб-платформы используем iframe
import 'dart:html' as html if (dart.library.html) 'dart:html';
import 'dart:ui_web' as ui_web;

class ScorersPage extends StatefulWidget {
  const ScorersPage({super.key});

  @override
  State<ScorersPage> createState() => _ScorersPageState();
}

class _ScorersPageState extends State<ScorersPage> {
  WebViewController? _controller;
  bool _isLoading = true;
  String? _iframeViewId;
  final String _url = 'https://maydon.join.football/tournament/1060010/stats';

  @override
  void initState() {
    super.initState();
    
    // Для веб-платформы используем iframe
    if (kIsWeb) {
      _iframeViewId = 'scorers-${DateTime.now().millisecondsSinceEpoch}';
      _setupWebView();
    } else {
      _setupMobileView();
    }
  }
  
  void _setupWebView() {
    if (kIsWeb) {
      // ignore: undefined_prefixed_name
      ui_web.platformViewRegistry.registerViewFactory(
        _iframeViewId!,
        (int viewId) {
          // Создаем контейнер для iframe с обрезкой нижней части
          // ignore: undefined_prefixed_name
          final container = html.DivElement()
            ..style.width = '100%'
            ..style.height = '100%'
            ..style.overflow = 'hidden'
            ..style.position = 'relative';
          
          // ignore: undefined_prefixed_name
          final iframe = html.IFrameElement()
            ..src = _url
            ..style.border = 'none'
            ..style.width = '100%'
            ..style.height = 'calc(100% + 100px)' // Увеличиваем высоту, чтобы обрезать footer
            ..style.position = 'absolute'
            ..style.top = '0'
            ..style.left = '0'
            ..style.transform = 'translateY(-100px)'; // Сдвигаем вверх, чтобы скрыть footer
          
          container.append(iframe);
          
          return container;
        },
      );
      setState(() => _isLoading = false);
    }
  }
  
  void _setupMobileView() {
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
              _controller!.runJavaScript(hideScript).catchError((_) {});
              if (mounted) {
                setState(() => _isLoading = false);
              }
            },
          ),
        );

      final platform = _controller!.platform;
      if (platform is WebKitWebViewController) {
        platform.setAllowsBackForwardNavigationGestures(true);
      }

      _controller!.loadRequest(Uri.parse(_url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWebViewBgLight,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: kBlue))
          : kIsWeb
              ? HtmlElementView(viewType: _iframeViewId!)
              : _controller != null
                  ? WebViewWidget(controller: _controller!)
                  : const Center(child: Text('Ошибка загрузки')),
    );
  }
}
