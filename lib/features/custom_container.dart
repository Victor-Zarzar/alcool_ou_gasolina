import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double minWidth;
  final double maxWidth;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BoxDecoration? decoration;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.minWidth = 150,
    this.maxWidth = 350,
    this.margin,
    this.padding,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          margin ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 8),
      decoration: decoration,
      constraints: BoxConstraints(minWidth: minWidth, maxWidth: maxWidth),
      child: child,
    );
  }
}
