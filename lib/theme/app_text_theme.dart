import 'package:flutter/material.dart';
import 'package:sahary_united_company_for_powers/constants/app_text_styles.dart';

//override default text theme properties with our font and styles
const TextTheme appTextTheme = TextTheme(
  headlineLarge: AppTextStyles.titleH1Light,
  headlineMedium: AppTextStyles.titleH2Medium,
  headlineSmall: AppTextStyles.titleH3Medium,
  titleLarge: AppTextStyles.titleH4Medium,
  titleMedium: AppTextStyles.titleH5Medium,
  titleSmall: AppTextStyles.titleH6Medium,
  labelLarge: AppTextStyles.inputLargeMedium,
  labelMedium: AppTextStyles.inputSmallMedium,
  labelSmall: AppTextStyles.paragraphSmallMedium,
  bodyLarge: AppTextStyles.paragraphLargeMedium,
  bodyMedium: AppTextStyles.paragraphMediumMedium,
  bodySmall: AppTextStyles.paragraphSmallMedium,
);
