import 'package:flutter/material.dart';

class HideOnScrollController extends ChangeNotifier {
  HideOnScrollController({
    this.hideAfterPx = 64.0,
    this.showAfterPx = 32.0,
    bool initiallyVisible = true,
    this.alwaysShowAtTop = true,
  }) : _visible = initiallyVisible;

  final double hideAfterPx;
  final double showAfterPx;
  final bool alwaysShowAtTop;

  bool _visible;
  bool get visible => _visible;

  double _accumDown = 0, _accumUp = 0;

  void onDragDelta(double dy) {
    if (dy > 0) { // вниз
      _accumDown += dy; _accumUp = 0;
      if (_visible && _accumDown >= hideAfterPx) { _accumDown = 0; _visible = false; notifyListeners(); }
    } else if (dy < 0) { // вверх
      _accumUp += (-dy); _accumDown = 0;
      if (!_visible && _accumUp >= showAfterPx) { _accumUp = 0; _visible = true; notifyListeners(); }
    }
  }

  void forceShow() { if (!_visible) { _visible = true; notifyListeners(); } }
  void forceHide() { if (_visible)  { _visible = false; notifyListeners(); } }
}
