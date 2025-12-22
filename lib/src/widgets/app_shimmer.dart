
// path: lib/src/widgets/app_shimmer.dart
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/token.dart';

class AppShimmer extends StatelessWidget {
  const AppShimmer.box({
    super.key,
    this.height = 16,
    this.width = double.infinity,
    this.borderRadius,
  });

  final double height;
  final double width;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppToken.colors.gray200,
      highlightColor: AppToken.colors.gray100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppToken.colors.gray200,
          borderRadius: borderRadius ?? AppToken.radius.small,
        ),
      ),
    );
  }
}
