import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:postj/src/theme/app_theme.dart';

class OverlayAppBar extends StatelessWidget {
  const OverlayAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
  });
  final Widget title;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme.titleMedium;

    return Container(
      height: 50,
      color: kWebViewHeaderBlue,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          children: [
            leading ?? const SizedBox(width: 16, height: 48),
            const SizedBox(width: 4),
            Expanded(
              child: DefaultTextStyle(
                style: (text ?? const TextStyle()).copyWith(
                  fontWeight: FontWeight.w600,
                  color: kWhite,
                ),
                child: Align(alignment: Alignment.centerLeft, child: title),
              ),
            ),
            ...(actions ?? const []),
          ],
        ),
      ),
    );
  }
}
