import 'package:flutter/material.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/constants/app_text_styles.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/widgets/form_label.dart';
import 'package:sahary_united_company_for_powers/theme/app_color_theme_extention.dart';
import 'package:sahary_united_company_for_powers/theme/app_text_theme_extention.dart';

class FileUploadField extends StatelessWidget {
  final String label;
  final String? fileName;
  final VoidCallback onTap;
  final bool isRequired;
  final bool hasError;
  final String? placeholder;
  final bool isDisabled;

  const FileUploadField({
    super.key,
    required this.label,
    required this.fileName,
    required this.onTap,
    this.isRequired = false,
    this.hasError = false,
    this.placeholder,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabel(
          label: label,
          hasError: hasError,
          isDisabled: isDisabled,
          isRequired: isRequired,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: isDisabled ? null : onTap,
          child: Container(
            padding: const EdgeInsets.fromLTRB(6, 9, 16, 9),
            decoration: BoxDecoration(
              color:
                  isDisabled
                      ? Theme.of(
                        context,
                      ).colorScheme.background200.withAlpha(127)
                      : AppColors.background0,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: hasError ? Colors.red.shade300 : colorScheme.text300,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    fileName ?? placeholder ?? '',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: textTheme.paragraphLargeMedium.copyWith(
                      color:
                          isDisabled
                              ? colorScheme.text400
                              : fileName != null
                              ? colorScheme.text900
                              : colorScheme.text400,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: isDisabled ? colorScheme.text300 : AppColors.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    Texts.insertFile,
                    style: AppTextStyles.paragraphLargeMedium_3.copyWith(
                      color:
                          isDisabled
                              ? colorScheme.text400
                              : AppColors.background0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
