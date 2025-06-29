import 'package:flutter/material.dart';
import 'package:sahary_united_company_for_powers/constants/app_text_styles.dart';
import 'package:sahary_united_company_for_powers/theme/app_light_theme.dart';
import 'package:sahary_united_company_for_powers/theme/app_text_theme.dart';
import 'package:sahary_united_company_for_powers/theme/input_theme.dart';

ThemeData appTheme({bool isDarkTheme = false}) {
  final colorScheme = lightColorScheme;
  return ThemeData(
    colorScheme: lightColorScheme,
    fontFamily: AppTextStyles.fontFamily,
    textTheme: appTextTheme,
    appBarTheme: lightAppBarTheme,
    inputDecorationTheme: inputTheme(colorScheme),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: colorScheme.secondary,
    ),
  );
}
