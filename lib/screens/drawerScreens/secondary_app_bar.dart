import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/constants/app_icons_path.dart';
import 'package:sahary_united_company_for_powers/constants/app_text_styles.dart';

class SecondaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final bool showFilterIcon;
  final bool filtered;
  final VoidCallback? filterAction;

  const SecondaryAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.showFilterIcon = false,
    this.filtered = false,
    this.filterAction,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Stack(
        children: [
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: onBackPressed ?? () => Navigator.of(context).pop(),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.neutral,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AppIconsPath.rightArrow,
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(
              child: Text(
                title,
                style: AppTextStyles.titleH1Light.copyWith(
                  color: AppColors.neutral,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          if (showFilterIcon)
            Positioned(
              left: 0,
              child: GestureDetector(
                onTap: () {
                  filterAction!();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    filtered ? AppIconsPath.filterRed : AppIconsPath.filter,
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
