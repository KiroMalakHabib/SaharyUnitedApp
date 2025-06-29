import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/constants/app_icons_path.dart';
import 'package:sahary_united_company_for_powers/constants/app_text_styles.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/screens/bottomNavigation/screens/contacts_us.dart';
import 'package:sahary_united_company_for_powers/screens/bottomNavigation/screens/divisions.dart';
import 'package:sahary_united_company_for_powers/screens/bottomNavigation/screens/home.dart';
import 'package:sahary_united_company_for_powers/screens/bottomNavigation/screens/our_projects.dart';
import 'package:sahary_united_company_for_powers/screens/bottomNavigation/screens/request_prices.dart';

class NavBarUtils {
  static List<PersistentTabConfig> buildNavBarItems() {
    return [
      _buildNavBarItem(
        iconInactive: AppIconsPath.homeInActive,
        iconActive: AppIconsPath.homeActive,
        title: Texts.home,
        screen: const Home(),
      ),
      _buildNavBarItem(
        iconInactive: AppIconsPath.departmentsInActive,
        iconActive: AppIconsPath.departmentsActive,
        title: Texts.departments,
        screen: const Divisions(),
      ),
      _buildNavBarItem(
        iconInactive: AppIconsPath.requestPrices,
        iconActive: AppIconsPath.requestPrices,
        title: Texts.requestPrices,
        screen: const RequestPrices(),
        isMiddleTab: true,
      ),
      _buildNavBarItem(
        iconInactive: AppIconsPath.ourProjectsInActive,
        iconActive: AppIconsPath.ourProjectsActive,
        title: Texts.ourProjects,
        screen: const OurProjects(),
      ),
      _buildNavBarItem(
        iconInactive: AppIconsPath.contactUsInActive,
        iconActive: AppIconsPath.contactUsActive,
        title: Texts.contactUs,
        screen: const ContactUs(),
      ),
    ];
  }

  static PersistentTabConfig _buildNavBarItem({
    required String iconInactive,
    required String iconActive,
    required String title,
    required Widget screen,
    bool isMiddleTab = false,
  }) {
    return PersistentTabConfig(
      screen: screen,
      item: ItemConfig(
        inactiveIcon: isMiddleTab ? null : _buildColoredIcon(iconInactive),
        icon:
            isMiddleTab
                ? const SizedBox.shrink()
                : _buildColoredIcon(iconActive),
        title: title,
        activeForegroundColor: AppColors.secondary,
        inactiveForegroundColor: AppColors.icon,
        textStyle: AppTextStyles.captionLargeMedium,
      ),
    );
  }

  static Widget _buildColoredIcon(String iconPath) {
    return SvgPicture.asset(iconPath, width: 24, height: 24);
  }
}
