import 'package:flutter/material.dart';
import '../theme/nalar_colors.dart';
import '../theme/nalar_radius.dart';
import '../theme/nalar_text_styles.dart';

enum NalarButtonType { primary, secondary, outlined, text }

class NalarButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final NalarButtonType type;
  final bool fullWidth;
  final bool isLoading;

  const NalarButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.type = NalarButtonType.primary,
    this.fullWidth = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: NalarColors.white,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: _getTextStyle(),
              ),
            ],
          );

    Widget button;

    switch (type) {
      case NalarButtonType.primary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: NalarColors.primaryCoral,
            foregroundColor: NalarColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: NalarRadius.borderMd),
            elevation: 0,
          ),
          child: child,
        );
        break;
      case NalarButtonType.secondary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: NalarColors.softCoral,
            foregroundColor: NalarColors.primaryCoral,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: NalarRadius.borderMd),
            elevation: 0,
          ),
          child: child,
        );
        break;
      case NalarButtonType.outlined:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: NalarColors.primaryCoral,
            side: const BorderSide(color: NalarColors.primaryCoral, width: 1.5),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: NalarRadius.borderMd),
          ),
          child: child,
        );
        break;
      case NalarButtonType.text:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: NalarColors.primaryCoral,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          child: child,
        );
        break;
    }

    if (fullWidth) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }
    return button;
  }

  TextStyle _getTextStyle() {
    switch (type) {
      case NalarButtonType.primary:
        return NalarTextStyles.buttonLabel.copyWith(color: NalarColors.white);
      case NalarButtonType.secondary:
      case NalarButtonType.outlined:
      case NalarButtonType.text:
        return NalarTextStyles.buttonLabel.copyWith(color: NalarColors.primaryCoral);
    }
  }
}
