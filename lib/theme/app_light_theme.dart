import 'package:flutter/material.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';

const ColorScheme lightColorScheme = ColorScheme.light(
  // will set the rest of coloring when start working on it
  primary: AppColors.primary, // Primary color
  secondary: AppColors.secondary, // Secondary color
  onPrimary: AppColors.text900, // Text and icons on primary color
  onSecondary: AppColors.text900, // Text and icons on secondary color
  error: AppColors.error,
);

AppBarTheme lightAppBarTheme = const AppBarTheme(
  backgroundColor: AppColors.fixedWhite,
  foregroundColor: AppColors.fixedWhite,
  surfaceTintColor: AppColors.fixedWhite,
  elevation: 0,
);
