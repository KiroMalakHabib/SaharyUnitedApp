import 'package:flutter/material.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/widgets/app_btn_label.dart';

class AppFilledBtn extends StatelessWidget {
  final String btnText;
  final IconData? iconData;
  final bool iconLeft;
  final Size? fixedSize;
  final VoidCallback? onPressed;
  final Color? iconColor;
  final bool isDisabled;
  final String? iconPath;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final bool isMedium;
  final bool isFullWidth;
  final bool isLoading;
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;

  const AppFilledBtn({
    super.key,
    required this.btnText,
    this.iconData,
    this.iconLeft = false,
    this.fixedSize,
    required this.onPressed,
    this.iconColor,
    this.isDisabled = false,
    this.iconPath,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.isMedium = false,
    this.isFullWidth = false,
    this.isLoading = false,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    bool hasIcon = iconData != null || iconPath != null;
    Color computedForegroundColor =
        isDisabled ? AppColors.text400 : foregroundColor ?? AppColors.text0;

    Color computedBackgroundColor =
        isDisabled
            ? AppColors.background200
            : backgroundColor ?? AppColors.primary;

    ButtonStyle buttonStyle = FilledButton.styleFrom(
      padding: EdgeInsets.symmetric(
        horizontal: isMedium ? 22 : 32,
        vertical: isMedium ? (hasIcon ? 12 : 14) : (hasIcon ? 16 : 18),
      ),
      backgroundColor: computedBackgroundColor,
      disabledBackgroundColor:
          disabledBackgroundColor ?? AppColors.background200,
      fixedSize: fixedSize,
      minimumSize: isFullWidth ? Size.fromHeight(isMedium ? 48 : 56) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        side:
            borderColor != null
                ? BorderSide(color: borderColor!, width: borderWidth ?? 1.0)
                : BorderSide.none,
      ),
    );

    // Display the loading indicator when isLoading is true
    Widget buttonContent =
        isLoading
            ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.background0,
                ),
              ),
            )
            : AppBtnLabel(
              btnText: btnText,
              foregroundColor: computedForegroundColor,
              iconLeft: iconLeft,
              iconPath: iconPath,
            );

    return iconData != null
        ? FilledButton.icon(
          style: buttonStyle,
          onPressed: isDisabled ? null : onPressed,
          icon: Icon(iconData, color: computedForegroundColor, size: 24),
          iconAlignment: iconLeft ? IconAlignment.end : IconAlignment.start,
          label: buttonContent,
        )
        : FilledButton(
          style: buttonStyle,
          onPressed: isDisabled ? null : onPressed,
          child: buttonContent,
        );
  }
}
