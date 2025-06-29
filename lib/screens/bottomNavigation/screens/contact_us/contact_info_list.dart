// contact_info_list.dart (Optional - for better organization)
import 'package:flutter/material.dart';
import 'package:sahary_united_company_for_powers/constants/app_icons_path.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/widgets/info_card.dart';

class ContactInfoList extends StatelessWidget {
  const ContactInfoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}