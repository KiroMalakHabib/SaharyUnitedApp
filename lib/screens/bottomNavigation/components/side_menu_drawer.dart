import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahary_united_company_for_powers/constants/api_constants.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/constants/app_icons_path.dart';
import 'package:sahary_united_company_for_powers/constants/app_text_styles.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/providers/language_provider.dart';
import 'package:sahary_united_company_for_powers/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class SideMenuDrawer extends ConsumerWidget {
  const SideMenuDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageNotifier = ref.read(languageProvider.notifier);
    final currentLanguage = ref.watch(languageProvider);

    return Drawer(
      backgroundColor: AppColors.background0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      AppIconsPath.rightArrow,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
              // Menu items
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    _buildMenuItem(
                      icon: AppIconsPath.whoWeAre,
                      title: Texts.whoWeAre,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pushNamed(AppRoutes.whoWeAre);
                      },
                    ),
                    _buildMenuItem(
                      icon: AppIconsPath.partners,
                      title: Texts.partners,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pushNamed(AppRoutes.partners);
                      },
                    ),
                    _buildMenuItem(
                      icon: AppIconsPath.clients,
                      title: Texts.clients,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pushNamed(AppRoutes.clients);
                      },
                    ),
                    _buildMenuItem(
                      icon: AppIconsPath.termsAndConditions,
                      title: Texts.termsAndConditions,
                      onTap: () {
                        Navigator.pop(context);
                        final Uri url = Uri.parse(
                          ApiConstants.termsAndConditions,
                        );
                        launchUrl(url);
                      },
                    ),
                    _buildMenuItem(
                      icon: AppIconsPath.commonQuestions,
                      title: Texts.commonQuestions,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pushNamed(AppRoutes.commonQuestions);
                      },
                    ),
                    _buildMenuItem(
                      icon: AppIconsPath.questionnaire,
                      title: Texts.questionnaire,
                      onTap: () {
                        Navigator.pop(context);
                        final Uri url = Uri.parse(ApiConstants.survey);
                        launchUrl(url);
                      },
                    ),
                    // Language selection menu item
                    _buildLanguageMenuItem(
                      context: context,
                      currentLanguage: currentLanguage,
                      onLanguageChanged: (String languageCode) {
                        languageNotifier.changeLanguage(languageCode);
                        Navigator.pop(context); // Close drawer after selection
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: SvgPicture.asset(icon, width: 24, height: 24),
      title: Text(
        title,
        style: AppTextStyles.titleH5Bold.copyWith(color: AppColors.secondary),
      ),
      onTap: onTap,
      hoverColor: AppColors.secondary.withAlpha(26),
    );
  }

  Widget _buildLanguageMenuItem({
    required BuildContext context,
    required Locale currentLanguage,
    required Function(String) onLanguageChanged,
  }) {
    return ExpansionTile(
      leading: const Icon(Icons.language, size: 24, color: AppColors.secondary),
      title: Text(
        Texts.language,
        style: AppTextStyles.titleH5Bold.copyWith(color: AppColors.secondary),
      ),
      children: [
        ListTile(
          title: Row(
            children: [
              const SizedBox(width: 48), // Align with parent title
              Text(
                'العربية',
                style: AppTextStyles.titleH5Bold.copyWith(
                  color:
                      currentLanguage.languageCode == 'ar'
                          ? AppColors.primary
                          : AppColors.secondary,
                ),
              ),
              if (currentLanguage.languageCode == 'ar') ...[
                const SizedBox(width: 8),
                Icon(Icons.check, color: AppColors.primary, size: 20),
              ],
            ],
          ),
          onTap: () => onLanguageChanged('ar'),
          hoverColor: AppColors.secondary.withAlpha(26),
        ),
        ListTile(
          title: Row(
            children: [
              const SizedBox(width: 48), // Align with parent title
              Text(
                'English',
                style: AppTextStyles.titleH5Bold.copyWith(
                  color:
                      currentLanguage.languageCode == 'en'
                          ? AppColors.primary
                          : AppColors.secondary,
                ),
              ),
              if (currentLanguage.languageCode == 'en') ...[
                const SizedBox(width: 8),
                Icon(Icons.check, color: AppColors.primary, size: 20),
              ],
            ],
          ),
          onTap: () => onLanguageChanged('en'),
          hoverColor: AppColors.secondary.withAlpha(26),
        ),
      ],
    );
  }
}
