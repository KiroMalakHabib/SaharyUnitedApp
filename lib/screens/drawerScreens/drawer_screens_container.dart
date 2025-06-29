import 'package:flutter/material.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/screens/drawerScreens/secondary_app_bar.dart';

class DrawerScreensContainer extends StatefulWidget {
  final String title;
  final Widget child;
  const DrawerScreensContainer({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  State<DrawerScreensContainer> createState() => _DrawerScreensContainerState();
}

class _DrawerScreensContainerState extends State<DrawerScreensContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(title: widget.title),
      body: Container(
        color: AppColors.primary,
        padding: EdgeInsets.only(top: 2),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.neutral,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.secondary.withAlpha(100),
                blurRadius: 5,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
