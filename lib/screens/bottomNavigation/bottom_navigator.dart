import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/constants/bottom_navigation_tabs.dart';
import 'package:sahary_united_company_for_powers/providers/tab_controller_provider.dart';
import 'package:sahary_united_company_for_powers/screens/bottomNavigation/components/nav_bar_utils.dart';

import 'components/custom_app_bar.dart';
import 'components/custom_bottom_nav_bar.dart';
import 'components/side_menu_drawer.dart';

class BottomNavigator extends ConsumerStatefulWidget {
  final int? tabIndex;
  final String? productName;
  final int? departmentId;
  const BottomNavigator({
    super.key,
    this.tabIndex,
    this.productName,
    this.departmentId,
  });

  @override
  ConsumerState<BottomNavigator> createState() => _BottomNavigator();
}

class _BottomNavigator extends ConsumerState<BottomNavigator> {
  late PersistentTabController _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();

  void setTabIndex(int index) {
    _controller.jumpToTab(index);
  }

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(
      initialIndex: widget.tabIndex ?? BottomNavigationTab.home.tabIndex,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(tabControllerProvider.notifier).state = _controller;

      if (widget.productName != null &&
          widget.departmentId != null &&
          widget.tabIndex == 2) {
        ref.read(productInfoProvider.notifier).state = ProductInfo(
          productName: widget.productName!,
          departmentId: widget.departmentId!,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop && _controller.index == 0) {
          // On Home Tab, exit the app
          SystemNavigator.pop();
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Scaffold(
          key: _scaffoldKey,
          drawer: SideMenuDrawer(),
          body: SafeArea(
            child: Column(
              children: [
                CustomAppBar(
                  controller: _controller,
                  searchController: _searchController,
                  scaffoldKey: _scaffoldKey,
                ),
                Expanded(
                  child: PersistentTabView(
                    navBarBuilder:
                        (navBarConfig) => CustomBottomNavBar(
                          navBarConfig: navBarConfig,
                          controller: _controller,
                        ),
                    controller: _controller,
                    tabs: NavBarUtils.buildNavBarItems(),
                    backgroundColor: AppColors.background0,
                    handleAndroidBackButtonPress: true,
                    resizeToAvoidBottomInset: true,
                    stateManagement: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductInfo {
  final String productName;
  final int departmentId;

  ProductInfo({required this.productName, required this.departmentId});
}

final productInfoProvider = StateProvider<ProductInfo?>((ref) => null);
