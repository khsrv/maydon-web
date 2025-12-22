import 'dart:async';
import 'package:flutter/foundation.dart';

/// Простой агрегатор для refreshListenable: слушает несколько Stream’ов и
/// дёргает notifyListeners() на любое событие.
class GoRouterMultiRefresh extends ChangeNotifier {
  final List<StreamSubscription<dynamic>> _subs = [];

  GoRouterMultiRefresh(Iterable<Stream<dynamic>> streams) {
    for (final s in streams) {
      _subs.add(s.listen((_) => notifyListeners())); // без asBroadcastStream
    }
  }

  @override
  void dispose() {
    for (final s in _subs) {
      s.cancel();
    }
    super.dispose();
  }
}
