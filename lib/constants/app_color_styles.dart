import 'package:flutter/material.dart';

class _ColorPalette {
  // Primary
  static const Color primary = Color(0xFFFFC000);
  static const Color secondary = Color(0xFF334451);
  static const Color primary300 = Color(0xFFE36F73);

  // Texts
  static const Color texts100 = Color(0xFF262E33);

  // Gold
  static const Color gold100 = Color(0xFFF7F3E6);

  //Neutral
  static const Color neutral = Color(0xFFFFFFFF);
  static const Color neutral50 = Color(0xFFF8F8FF);
  static const Color neutral100 = Color(0xFFF2F1FA);
  static const Color neutral200 = Color(0xFFE1E0F1);
  static const Color neutral300 = Color(0xFFC7C5DE);
  // static const Color neutral400 = Color(0xFFAEACCA);
  static const Color neutral500 = Color(0xFF5A6973);
  // static const Color neutral600 = Color(0xFF64618A);

  //Black
  static const Color black50 = Color(0xFFF5F7FA);
  // static const Color black100 = Color(0xFFF2F5F8);
  // static const Color black200 = Color(0xFFE1E4EA);
  static const Color black300 = Color(0XFFBBBEC3);
  static const Color black400 = Color(0xFF99A0AE);
  // static const Color black500 = Color(0xFF717784);
  static const Color black600 = Color(0xFF525866);
  static const Color searchBarColors = Color(0xFFB8B8D2);
  // static const Color black700 = Color(0xFF2B303B);
  // static const Color black800 = Color(0xFF222530);
  static const Color black900 = Color(0xFF121212);

  //Information
  static const Color information = Color(0xFF1F5FB3);
  static const Color information100 = Color(0xFFE5EFFF);
  // static const Color information800 = Color(0xFF0F2E57);

  //Error
  static const Color error = Color(0xFFD00505);
  static const Color error100 = Color(0xFFFFF0F0);
  // static const Color error800 = Color(0xFF6B0B0B);

  //Warning
  static const Color warning = Color(0xFFE29832);
  static const Color warning100 = Color(0xFFFFFBEC);
  // static const Color warning800 = Color(0xFF82410C);

  //Success
  static const Color success = Color(0xFF77B238);
  static const Color success100 = Color(0xFFEEFBE9);
  // static const Color success800 = Color(0xFF21481E);

  //Colors With Opacity
  static const Color whiteWithOpacity20 = Color(0x33FFFFFF);
  // static const Color whiteWithOPacity50 = Color(0xB2FFFFFF);
  static const Color darkWithOpacity70 = Color(0xB2000000);
  static const Color darkWithOpacity50 = Color(0x80000000);
  static const Color darkWithOpacity20 = Color(0x33000000);
  static const Color divider = Color(0xFFEDEDED);
}

class AppColors {
  //Fixed Color
  static const Color fixedBlack = _ColorPalette.black900;
  static const Color fixedWhite = _ColorPalette.neutral;

  //Text
  static const Color text900 = _ColorPalette.black900;
  static const Color text600 = _ColorPalette.black600;
  static const Color text400 = _ColorPalette.black400;
  static const Color text300 = _ColorPalette.black300;
  static const Color text0 = _ColorPalette.neutral;
  static const Color text500 = _ColorPalette.neutral500;
  static const Color formTitle = _ColorPalette.texts100;
  static const Color darkTexts = _ColorPalette.secondary;
  static const Color brightTexts = _ColorPalette.neutral;

  //Background
  static const Color background0 = _ColorPalette.neutral;
  static const Color background50 = _ColorPalette.neutral50;
  static const Color background100 = _ColorPalette.neutral100;
  static const Color background200 = _ColorPalette.neutral200;
  static const Color background900 = _ColorPalette.black900;
  static const Color cardBg = _ColorPalette.black50;

  //Border
  static const Color border100 = _ColorPalette.neutral100;
  static const Color border200 = _ColorPalette.neutral200;
  static const Color border300 = _ColorPalette.neutral300;
  static const Color border500 = _ColorPalette.neutral500;
  static const Color divider = _ColorPalette.divider;


  //Brands
  static const Color primary = _ColorPalette.primary;
  static const Color primary300 = _ColorPalette.primary300;
  static const Color secondary = _ColorPalette.secondary;
  static const Color gold100 = _ColorPalette.gold100;

  //icon
  static const Color icon = _ColorPalette.black600;
  static const Color icon600 = _ColorPalette.black600;
  static const Color searchIcon = _ColorPalette.searchBarColors;

  //Opacity
  static const Color light20 = _ColorPalette.whiteWithOpacity20;
  static const Color dark70 = _ColorPalette.darkWithOpacity70;
  static const Color white50 = _ColorPalette.darkWithOpacity50;
  static const Color dark20 = _ColorPalette.darkWithOpacity20;

  //Information
  static const Color information = _ColorPalette.information;
  static const Color information100 = _ColorPalette.information100;

  //success
  static const Color success = _ColorPalette.success;
  static const Color success100 = _ColorPalette.success100;

  //error
  static const Color error = _ColorPalette.error;
  static const Color error100 = _ColorPalette.error100;

  //warning
  static const Color warning = _ColorPalette.warning;
  static const Color warning100 = _ColorPalette.warning100;

  //Neutral
  static const Color neutral = _ColorPalette.neutral;
  static const Color neutral100 = _ColorPalette.neutral100;
  static const Color neutral200 = _ColorPalette.neutral200;
  static const Color neutral300 = _ColorPalette.neutral300;
  static const Color neutral500 = _ColorPalette.neutral500;
}
