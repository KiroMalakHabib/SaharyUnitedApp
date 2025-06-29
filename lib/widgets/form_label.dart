import 'package:flutter/material.dart';
import 'package:sahary_united_company_for_powers/theme/app_color_theme_extention.dart';
import 'package:sahary_united_company_for_powers/theme/app_text_theme_extention.dart';

class FormLabel extends StatelessWidget {
  final String label;
  final bool hasError;
  final bool isDisabled;
  final bool isRequired;

  const FormLabel({
    super.key,
    required this.label,
    this.hasError = false,
    this.isDisabled = false,
    required this.isRequired,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: label,
        style: Theme.of(context).textTheme.paragraphMediumMedium.copyWith(
              color: hasError
                  ? Theme.of(context).colorScheme.error
                  : isDisabled
                      ? Theme.of(context).colorScheme.text300
                      : Theme.of(context).colorScheme.text600,
            ),
        children: [
          if (isRequired)
            WidgetSpan(
              alignment: PlaceholderAlignment.bottom,
              child: Text(
                ' *',
                style: Theme.of(context).textTheme.paragraphLargeMedium.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
