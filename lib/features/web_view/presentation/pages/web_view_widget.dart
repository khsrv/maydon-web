import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:go_router/go_router.dart';
import 'package:postj/src/theme/app_theme.dart';
import 'package:postj/src/widgets/overlay_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

// Для веб-платформы используем iframe
import 'dart:html' as html if (dart.library.html) 'dart:html';
import 'dart:ui_web' as ui_web;

class WebViewPage extends StatefulWidget {
  const WebViewPage({
    super.key,
    required this.url,
    this.title,
    this.backgroundColor,
    this.javascriptMode = JavaScriptMode.unrestricted,
    this.userAgent,
  });

  final String url;
  final String? title;
  final Color? backgroundColor;
  final JavaScriptMode javascriptMode;
  final String? userAgent;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController? _controller;
  bool _isLoading = true;
  String? _iframeViewId;

  late Uri _currentUri; // текущий URL
  
  @override
  void initState() {
    super.initState();
    _currentUri = _wrap(widget.url);
    
    // Для веб-платформы используем iframe
    if (kIsWeb) {
      _iframeViewId = 'webview-${DateTime.now().millisecondsSinceEpoch}';
      _setupWebView();
    } else {
      _setupMobileView();
    }
  }
  
  void _setupWebView() {
    // Регистрируем iframe для веб-платформы
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
            ..src = _currentUri.toString()
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

      // Оптимизированный JavaScript для быстрого выполнения
      const hideScript = '''
        (function(){
          var h = document.querySelector('header');
          if (h && !h.querySelector('.timetable')) h.style.display = 'none';
          var f = document.querySelector('footer');
          if (f && !f.querySelector('.timetable')) f.style.display = 'none';
          var s = document.createElement('style');
          s.innerHTML = 'body { padding-top: 110px !important; }';
          document.head.appendChild(s);
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

              // Для календаря: если URL содержит round_id и не содержит type=tours, добавляем его
              if (uri.path.contains('/calendar') &&
                  uri.queryParameters.containsKey('round_id') &&
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
              // Выполняем JavaScript асинхронно, не блокируя UI
              _controller!.runJavaScript(hideScript).catchError((_) {});
              if (mounted) {
                setState(() => _isLoading = false);
              }
            },
            onWebResourceError: (err) {
              if (mounted) {
                setState(() => _isLoading = false);
              }

              // iOS отменённые загрузки — не ошибка
              if (err.errorCode == -999 || err.errorCode == 102) return;
              debugPrint(
                'WebView error: code=${err.errorCode} ${err.description}',
              );
            },
          ),
        );

      // iOS свайпы back/forward
      final platform = _controller!.platform;
      if (platform is WebKitWebViewController) {
        platform.setAllowsBackForwardNavigationGestures(true);
      }

      // Загружаем URL сразу после инициализации
      _controller!.loadRequest(_currentUri);
  }

  Uri _wrap(String raw) {
    // Всегда открываем оригинальный URL без перевода
    return Uri.parse(_normalize(raw));
  }

  String _normalize(String s) {
    var v = s.trim();
    if (v.isEmpty) return 'about:blank';
    if (!v.contains('://')) v = 'https://$v';
    return v;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        // Всегда возвращаемся на главный экран
        if (mounted) {
          context.go('/');
        }
      },
      child: Scaffold(
        backgroundColor: kWebViewBgLight,
        body: Stack(
          fit: StackFit.expand,
          children: [
            // WebView с отступом сверху для AppBar
            if (kIsWeb)
              // Для веб используем iframe
              _isLoading
                  ? const Center(child: CupertinoActivityIndicator(color: kBlue))
                  : HtmlElementView(viewType: _iframeViewId!)
            else
              // Для мобильных используем WebView
              _isLoading
                  ? const Center(child: CupertinoActivityIndicator(color: kBlue))
                  : _controller != null
                      ? WebViewWidget(controller: _controller!)
                      : const Center(
                          child: Text('Ошибка загрузки WebView'),
                        ),
            // AppBar всегда видимый поверх WebView
            Align(
              alignment: Alignment.topCenter,
              child: OverlayAppBar(
                title: Text(widget.title ?? 'Maydon'),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: kWhite),
                  onPressed: () {
                    // Всегда возвращаемся на главный экран
                    context.go('/');
                  },
                ),
                actions: [
                  // NotificationBellButton(
                  //   onTap: () => context.pushNamed('notifications'),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
