import 'package:flutter/material.dart';
import '../theme/nalar_colors.dart';
import '../theme/nalar_radius.dart';

class NalarCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const NalarCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.backgroundColor = NalarColors.white,
    this.borderColor = NalarColors.border,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    Widget cardWidget = Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: NalarRadius.borderLg,
        border: Border.all(color: borderColor, width: 1),
        boxShadow: const [
          BoxShadow(
            color: NalarColors.cardShadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        borderRadius: NalarRadius.borderLg,
        child: InkWell(
          onTap: onTap,
          borderRadius: NalarRadius.borderLg,
          child: cardWidget,
        ),
      );
    }

    return cardWidget;
  }
}
