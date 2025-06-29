// contact_us.dart
import 'package:flutter/material.dart';
import 'package:sahary_united_company_for_powers/constants/app_icons_path.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/widgets/app_filled_btn.dart';
import 'package:sahary_united_company_for_powers/widgets/info_card.dart';
import 'contact_us/contact_bottom_sheet.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  void _showContactBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const ContactBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            InfoCard(
              title: Texts.websiteTitle,
              content: Texts.websiteContent,
              iconPath: AppIconsPath.website,
            ),
            InfoCard(
              title: Texts.phoneTitle,
              content: Texts.phoneContent,
              iconPath: AppIconsPath.phone,
            ),
            InfoCard(
              title: Texts.emailTitle,
              content: Texts.emailContent,
              iconPath: AppIconsPath.email,
            ),
            InfoCard(
              title: Texts.addressTitle,
              content: Texts.addressContent,
              iconPath: AppIconsPath.address,
            ),
            AppFilledBtn(
              btnText: Texts.sendUsMessage,
              isFullWidth: true,
              onPressed: () => _showContactBottomSheet(context),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
