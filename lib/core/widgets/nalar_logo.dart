import 'package:flutter/material.dart';
import '../theme/nalar_colors.dart';

class NalarLogo extends StatelessWidget {
  final double size;
  final bool showTagline;
  final Color? textColor;

  const NalarLogo({
    super.key,
    this.size = 22,
    this.showTagline = false,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(size * 0.25),
              decoration: BoxDecoration(
                color: NalarColors.primaryCoral,
                borderRadius: BorderRadius.circular(size * 0.35),
              ),
              child: Icon(
                Icons.hub_rounded,
                color: NalarColors.white,
                size: size * 0.9,
              ),
            ),
            SizedBox(width: size * 0.35),
            Text(
              'NALAR',
              style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                color: textColor ?? NalarColors.primaryCoral,
              ),
            ),
          ],
        ),
        if (showTagline) ...[
          const SizedBox(height: 2),
          Text(
            'Explore Technology. Connect Your Future.',
            style: TextStyle(
              fontSize: size * 0.45,
              fontWeight: FontWeight.w500,
              color: NalarColors.secondaryText,
            ),
          ),
        ],
      ],
    );
  }
}
