import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:postj/src/theme/app_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

// Для веб-платформы используем iframe
import 'dart:html' as html if (dart.library.html) 'dart:html';
import 'dart:ui_web' as ui_web;

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  WebViewController? _controller;
  bool _isLoading = true;
  String? _iframeViewId;
  final String _url = 'https://maydon.join.football/tournament/1060010/calendar?type=tours';

  @override
  void initState() {
    super.initState();
    
    // Для веб-платформы используем iframe
    if (kIsWeb) {
      _iframeViewId = 'calendar-${DateTime.now().millisecondsSinceEpoch}';
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
          // ignore: undefined_prefixed_name
          final iframe = html.IFrameElement()
            ..src = _url
            ..style.border = 'none'
            ..style.width = '100%'
            ..style.height = '100%';
          
          // Пытаемся скрыть footer после загрузки iframe
          iframe.onLoad.listen((_) {
            try {
              // ignore: undefined_prefixed_name
              final iframeDoc = iframe.contentDocument ?? iframe.contentWindow?.document;
              if (iframeDoc != null) {
                // Скрываем header и footer
                final header = iframeDoc.querySelector('header');
                if (header != null) {
                  // ignore: undefined_prefixed_name
                  (header as html.Element).style.display = 'none';
                }
                final footer = iframeDoc.querySelector('footer');
                if (footer != null) {
                  // ignore: undefined_prefixed_name
                  (footer as html.Element).style.display = 'none';
                }
              }
            } catch (e) {
              // CORS может блокировать доступ к содержимому iframe
              // В этом случае используем CSS для скрытия через стили родительского элемента
            }
          });
          
          return iframe;
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
            onNavigationRequest: (NavigationRequest request) {
              final url = request.url;
              final uri = Uri.parse(url);

              // Проверяем, содержит ли URL round_id и не содержит type=tours
              if (uri.queryParameters.containsKey('round_id') &&
                  !uri.queryParameters.containsKey('type')) {
                // Добавляем type=tours к URL
                final modifiedUri = uri.replace(
                  queryParameters: {...uri.queryParameters, 'type': 'tours'},
                );

                // Загружаем модифицированный URL
                _controller!.loadRequest(modifiedUri);
                return NavigationDecision.prevent;
              }

              return NavigationDecision.navigate;
            },
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
