import 'package:flutter/material.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/theme/app_color_theme_extention.dart';
import 'package:sahary_united_company_for_powers/theme/app_text_theme_extention.dart';
import 'package:sahary_united_company_for_powers/widgets/form_label.dart';

class TextAreaInputField extends StatefulWidget {
  final String? label;
  final TextEditingController controller;
  final String? placeholder;
  final bool isRequired;
  final String? validationMessage;
  final bool isDisabled;
  final int maxLines;
  final int? maxLength;
  final String? customErrorMessage;
  final Function(String text)? onChanged;

  const TextAreaInputField({
    super.key,
    this.label,
    required this.controller,
    this.placeholder,
    this.isRequired = false,
    this.validationMessage,
    this.isDisabled = false,
    this.maxLines = 5,
    this.maxLength,
    this.customErrorMessage,
    this.onChanged,
  });

  @override
  State<TextAreaInputField> createState() => _TextAreaInputFieldState();
}

class _TextAreaInputFieldState extends State<TextAreaInputField> {
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          FormLabel(
            label: widget.label!,
            hasError: _hasError || widget.customErrorMessage != null,
            isDisabled: widget.isDisabled,
            isRequired: widget.isRequired,
          ),
        const SizedBox(height: 8),
        Focus(
          child: TextFormField(
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: Theme.of(context).textTheme.paragraphLargeMedium
                  .copyWith(color: Theme.of(context).colorScheme.text400),
              errorText: _hasError ? widget.customErrorMessage : null,
              filled: true,
              fillColor:
                  widget.isDisabled
                      ? Theme.of(
                        context,
                      ).colorScheme.background200.withAlpha(127)
                      : Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.text300,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color:
                      _hasError
                          ? AppColors.error
                          : Theme.of(context).colorScheme.text300,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color:
                      _hasError
                          ? AppColors.error
                          : Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.error, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.error, width: 2),
              ),
            ),
            buildCounter: (
              BuildContext context, {
              required int currentLength,
              required bool isFocused,
              required int? maxLength,
            }) {
              if (maxLength == null) {
                return null;
              }
              return Text(
                '$currentLength/$maxLength',
                style: Theme.of(context).textTheme.paragraphLargeMedium
                    .copyWith(color: Theme.of(context).colorScheme.text600),
              );
            },
            validator: (value) {
              String? trimmedValue = value?.trim();
              if (!widget.isRequired &&
                  (trimmedValue == null || trimmedValue.isEmpty)) {
                setState(() {
                  _hasError = false;
                });
                return null;
              }
              if (widget.isRequired &&
                  (trimmedValue == null || trimmedValue.isEmpty)) {
                setState(() {
                  _hasError = true;
                });
                return widget.validationMessage ??
                    (widget.label != null
                        ? '${Texts.pleaseEnter} ${widget.label}'
                        : Texts.pleaseEnterRequirement);
              }
              setState(() {
                _hasError = false;
              });
              return null;
            },
            enabled: !widget.isDisabled,
            style:
                widget.isDisabled
                    ? TextStyle(color: Theme.of(context).colorScheme.text300)
                    : Theme.of(context).textTheme.paragraphLargeMedium.copyWith(
                      color: Theme.of(context).colorScheme.text900,
                    ),
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }
}
