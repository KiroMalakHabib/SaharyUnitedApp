import 'package:flutter/material.dart';
import 'package:sahary_united_company_for_powers/constants/app_text_styles.dart';
import 'package:sahary_united_company_for_powers/widgets/app_image_icon.dart';

class AppBtnLabel extends StatelessWidget {
  const AppBtnLabel({
    super.key,
    required this.btnText,
    required this.foregroundColor,
    this.iconPath,
    required this.iconLeft,
  });

  final String btnText;
  final Color foregroundColor;
  final String? iconPath;
  final bool iconLeft;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (iconPath != null && !iconLeft) ...[
          AppImageIcon(
            imagePath: iconPath!,
            foregroundColor: foregroundColor,
          ),
          const SizedBox(
            width: 12,
          ),
        ],
        Text(
          btnText,
          textAlign: TextAlign.center,
          style: AppTextStyles.inputLargeMedium.copyWith(
            color: foregroundColor,
          ),
        ),
        if (iconPath != null && iconLeft) ...[
          const SizedBox(
            width: 12,
          ),
          AppImageIcon(
            imagePath: iconPath!,
            foregroundColor: foregroundColor,
          ),
        ],
      ],
    );
  }
}
