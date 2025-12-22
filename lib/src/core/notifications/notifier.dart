
// path: lib/src/core/notifications/notifier.dart
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import '../../routing/keys.dart';
import '../error/app_failure.dart';

class Notifier {
  GlobalKey<NavigatorState>? _navKey;

  void attach(GlobalKey<NavigatorState> navKey) {
    _navKey = navKey;
  }

  BuildContext? get _context => _navKey?.currentContext ?? rootNavigatorKey.currentContext;

  Future<void> showInfo(String message) async {
    final ctx = _context;
    if (ctx == null) return;
    await Flushbar(
      message: message,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(12),
    ).show(ctx);
  }

  Future<void> showSuccess(String message) async {
    final ctx = _context;
    if (ctx == null) return;
    await Flushbar(
      message: message,
      icon: const Icon(Icons.check_circle, color: Colors.white),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(12),
    ).show(ctx);
  }

  Future<void> showError(String message) async {
    final ctx = _context;
    if (ctx == null) return;
    await Flushbar(
      message: message,
      icon: const Icon(Icons.error, color: Colors.white),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(12),
    ).show(ctx);
  }

  Future<void> showFailure(AppFailure failure) => showError(failure.toFriendlyMessage());
}
