import 'package:flutter/material.dart';
import 'package:sahary_united_company_for_powers/theme/app_color_theme_extention.dart';

InputDecorationTheme inputTheme(ColorScheme colorScheme) {
  return InputDecorationTheme(
      hintStyle: TextStyle(
        color: colorScheme.text400,
      ),
      filled: true,
      fillColor: colorScheme.background50,
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: colorScheme.border300, width: 1.0),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorScheme.border500),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorScheme.border300, width: 1.0),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorScheme.error, width: 1.0),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorScheme.error, width: 1.0),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorScheme.border100, width: 1.0),
      ),
      errorStyle: TextStyle(
        color: colorScheme.error,
      ));
}
