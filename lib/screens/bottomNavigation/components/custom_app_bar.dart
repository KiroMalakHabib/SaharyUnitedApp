import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/constants/app_icons_path.dart';
import 'package:sahary_united_company_for_powers/constants/app_text_styles.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/providers/filter_bottom_sheet_provider.dart';
import 'package:sahary_united_company_for_powers/routes.dart';

class CustomAppBar extends ConsumerStatefulWidget {
  final PersistentTabController controller;
  final TextEditingController searchController;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomAppBar({
    super.key,
    required this.controller,
    required this.searchController,
    required this.scaffoldKey,
  });

  @override
  ConsumerState<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends ConsumerState<CustomAppBar> {
  String _getTabTitle(int index) {
    switch (index) {
      case 0:
        return Texts.homeWelcome;
      case 1:
        return Texts.departments;
      case 2:
        return Texts.requestPrices;
      case 3:
        return Texts.ourProjects;
      case 4:
        return Texts.contactUs;
      default:
        return Texts.home;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: Column(
        children: [
          // App bar with title and menu icon
          AnimatedBuilder(
            animation: widget.controller,
            builder: (context, child) {
              return Stack(
                children: [
                  // Side drawer icon
                  Positioned(
                    top: 5,
                    child: GestureDetector(
                      onTap: () {
                        widget.scaffoldKey.currentState?.openDrawer();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset(
                          AppIconsPath.sideDrawer,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                  // Centered title
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 50,
                      right: 50,
                    ),
                    child: Center(
                      child: Text(
                        _getTabTitle(widget.controller.index),
                        style: AppTextStyles.titleH1Light.copyWith(
                          color: AppColors.neutral,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  // Filter icon when index == 3
                  if (widget.controller.index == 3)
                    Positioned(
                      top: 5,
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          ref
                              .read(showFilterBottomSheetProvider.notifier)
                              .state = true;
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: SvgPicture.asset(
                            AppIconsPath.filter,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          // Search box
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: AppColors.neutral.withAlpha(26),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: AppColors.neutral.withAlpha(77),
                width: 1,
              ),
            ),
            child: TextField(
              controller: widget.searchController,

              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: AppColors.background0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: AppColors.icon),
                ),
                hintText: Texts.searchProducts,
                hintStyle: AppTextStyles.paragraphMediumLight.copyWith(
                  color: AppColors.searchIcon,
                ),
                prefixIcon: SizedBox(
                  width: 13,
                  height: 13,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(AppIconsPath.search),
                  ),
                ),
                suffixIcon: SizedBox(
                  width: 13,
                  height: 13,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(AppIconsPath.filterSearchBar),
                  ),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              style: AppTextStyles.paragraphMediumLight.copyWith(
                color: AppColors.secondary,
              ),
              onSubmitted: (value) {
                Navigator.of(context, rootNavigator: true).pushNamed(
                  AppRoutes.departmentScreen,
                  arguments: {
                    'id': 0,
                    'title': 'Search Results for "$value"',
                    'divisionName': value,
                    'isSearchMode': true,
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
