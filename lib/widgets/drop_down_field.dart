import 'package:flutter/material.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/widgets/form_label.dart';
import 'package:sahary_united_company_for_powers/theme/app_color_theme_extention.dart';
import 'package:sahary_united_company_for_powers/theme/app_text_theme_extention.dart';

class DropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final void Function(String?) onChanged;
  final bool isRequired;
  final bool hasError;
  final String? hintText;
  final bool isDisabled;

  const DropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.isRequired = false,
    this.hasError = false,
    this.hintText,
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
        Container(
          decoration: BoxDecoration(
            color:
                isDisabled
                    ? Theme.of(context).colorScheme.background200.withAlpha(127)
                    : AppColors.neutral,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: hasError ? Colors.red.shade300 : colorScheme.text300,
              width: 1,
            ),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              fillColor:
                  isDisabled
                      ? Theme.of(
                        context,
                      ).colorScheme.background200.withAlpha(127)
                      : AppColors.background0,
              filled: true,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              hintText: hintText,
              hintStyle: textTheme.paragraphLargeMedium.copyWith(
                color: colorScheme.text400,
              ),
            ),
            style: textTheme.paragraphLargeMedium.copyWith(
              color: isDisabled ? colorScheme.text400 : colorScheme.text900,
            ),
            icon: Icon(Icons.keyboard_arrow_down, color: colorScheme.text400),
            items:
                items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                    ),
                  );
                }).toList(),
            onChanged: isDisabled ? null : onChanged,
          ),
        ),
      ],
    );
  }
}
