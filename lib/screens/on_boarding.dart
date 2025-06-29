import 'package:flutter/material.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/constants/app_images_path.dart';
import 'package:sahary_united_company_for_powers/constants/app_text_styles.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/routes.dart';
import 'package:sahary_united_company_for_powers/widgets/app_filled_btn.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(
              AppImagesPath.onBoardingImage,
              fit: BoxFit.cover,
              scale: 4,
            ),

            const SizedBox(height: 40),

            // Content section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 20.0,
                ),
                child: Column(
                  children: [
                    // Title
                    Text(
                      Texts.onBoardingTitle,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titleH1Light.copyWith(
                        color: AppColors.background0,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Description paragraph
                    Text(
                      Texts.onBoardingDescription,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.paragraphLargeMedium.copyWith(
                        color: AppColors.background0,
                      ),
                    ),

                    const Spacer(),

                    // Button
                    AppFilledBtn(
                      btnText: Texts.startNow,
                      onPressed:
                          () => Navigator.of(
                            context,
                            rootNavigator: true,
                          ).pushNamedAndRemoveUntil(
                            AppRoutes.bottomNavigator,
                            (route) => false,
                          ),
                      isFullWidth: true,
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
