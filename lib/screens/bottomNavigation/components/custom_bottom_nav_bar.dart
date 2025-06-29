// components/custom_bottom_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/constants/app_icons_path.dart';
import 'package:sahary_united_company_for_powers/constants/app_text_styles.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';

class CustomBottomNavBar extends StatelessWidget {
  final NavBarConfig navBarConfig;
  final PersistentTabController controller;

  const CustomBottomNavBar({
    super.key,
    required this.navBarConfig,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      decoration: BoxDecoration(
        color: AppColors.background0,
        border: Border(top: BorderSide(color: AppColors.neutral, width: 7)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 25,
            color: AppColors.secondary.withAlpha(100),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Regular navigation items
          Row(
            children: [
              // Home
              _buildNavItem(
                index: 0,
                iconActive: AppIconsPath.homeActive,
                iconInactive: AppIconsPath.homeInActive,
                title: Texts.home,
                isActive: controller.index == 0,
              ),
              // Departments
              _buildNavItem(
                index: 1,
                iconActive: AppIconsPath.departmentsActive,
                iconInactive: AppIconsPath.departmentsInActive,
                title: Texts.departments,
                isActive: controller.index == 1,
              ),
              // Spacer for middle button
              const Expanded(child: SizedBox()),
              // Our Projects
              _buildNavItem(
                index: 3,
                iconActive: AppIconsPath.ourProjectsActive,
                iconInactive: AppIconsPath.ourProjectsInActive,
                title: Texts.ourProjects,
                isActive: controller.index == 3,
              ),
              // Contact Us
              _buildNavItem(
                index: 4,
                iconActive: AppIconsPath.contactUsActive,
                iconInactive: AppIconsPath.contactUsInActive,
                title: Texts.contactUs,
                isActive: controller.index == 4,
              ),
            ],
          ),
          // Elevated Middle Button
          _buildElevatedMiddleButton(context),
          // Middle button label positioned at bottom level
          _buildMiddleButtonLabel(context),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String iconActive,
    required String iconInactive,
    required String title,
    required bool isActive,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.jumpToTab(index),
        behavior: HitTestBehavior.opaque,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Main content
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    isActive ? iconActive : iconInactive,
                    width: 24,
                    height: 24,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        title,
                        style: AppTextStyles.captionLargeMedium.copyWith(
                          color: AppColors.secondary,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Top border
            if (isActive)
              Positioned(
                top: -7,
                left: 20,
                right: 20,
                child: Container(height: 3, color: AppColors.primary),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildElevatedMiddleButton(BuildContext context) {
    return Positioned(
      top: -25,
      left: MediaQuery.of(context).size.width / 2 - 35,
      child: GestureDetector(
        onTap: () => controller.jumpToTab(2),
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color:
                controller.index == 2 ? AppColors.primary : AppColors.secondary,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.neutral, width: 6),
            boxShadow: [
              BoxShadow(
                color: AppColors.secondary.withAlpha(38),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppIconsPath.requestPrices,
                width: 24,
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiddleButtonLabel(BuildContext context) {
    return Positioned(
      bottom: 8,
      left: MediaQuery.of(context).size.width / 2 - 50,
      width: 100,
      child: GestureDetector(
        onTap: () => controller.jumpToTab(2),
        behavior: HitTestBehavior.opaque,
        child: Text(
          Texts.requestPrices,
          style: AppTextStyles.captionLargeMedium.copyWith(
            color: AppColors.secondary,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
