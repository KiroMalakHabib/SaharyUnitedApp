import 'package:flutter/material.dart';
import 'package:sahary_united_company_for_powers/constants/api_constants.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/constants/app_icons_path.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/screens/drawerScreens/drawer_screens_container.dart';
import 'package:sahary_united_company_for_powers/widgets/app_filled_btn.dart';
import 'package:sahary_united_company_for_powers/widgets/info_card.dart';
import 'package:url_launcher/url_launcher.dart';

class WhoWeAre extends StatefulWidget {
  const WhoWeAre({super.key});

  @override
  State<WhoWeAre> createState() => _WhoWeAreState();
}

class _WhoWeAreState extends State<WhoWeAre> {
  @override
  Widget build(BuildContext context) {
    return DrawerScreensContainer(
      title: Texts.whoWeAre,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            InfoCard(
              title: Texts.vision,
              content: Texts.visionContent,
              iconPath: AppIconsPath.vision,
            ),
            InfoCard(
              title: Texts.goals,
              content: Texts.goalsContent,
              iconPath: AppIconsPath.goals,
            ),
            InfoCard(
              title: Texts.message,
              content: Texts.messageContent,
              iconPath: AppIconsPath.message,
            ),
            InfoCard(
              title: Texts.values,
              content: Texts.valuesContent,
              iconPath: AppIconsPath.values,
            ),
            InfoCard(
              title: Texts.competitivePrices,
              content: Texts.competitivePricesContent,
              iconPath: AppIconsPath.competitivePrices,
            ),
            InfoCard(
              title: Texts.quality,
              content: Texts.qualityContent,
              iconPath: AppIconsPath.quality,
            ),
            AppFilledBtn(
              btnText: Texts.downloadCommercialPapers,
              isFullWidth: true,
              backgroundColor: AppColors.neutral,
              foregroundColor: AppColors.secondary,
              borderColor: AppColors.secondary,
              borderWidth: 1,
              onPressed: () {
                final Uri url = Uri.parse(ApiConstants.tradeRegistry);
                launchUrl(url);
              },
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
