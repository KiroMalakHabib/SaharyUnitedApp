import 'package:flutter/material.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/theme/app_color_theme_extention.dart';
import 'package:sahary_united_company_for_powers/theme/app_text_theme_extention.dart';
import 'package:sahary_united_company_for_powers/widgets/form_label.dart';

class TextInputField extends StatefulWidget {
  final String? label;
  final TextEditingController controller;
  final String? placeholder;
  final bool isRequired;
  final bool isNumeric;
  final String? validationMessage;
  final bool isDisabled;
  final Widget? suffixIcon;
  final String? customErrorMessage;
  final Function(String text)? onChanged;
  final int? maxLength;
  final bool isPhone;
  final bool isEmail;
  final bool isDirtyEnabled;
  final Function()? isDirtyAction;
  final String? fieldName;

  const TextInputField({
    super.key,
    this.label,
    required this.controller,
    this.placeholder,
    this.isRequired = false,
    this.isNumeric = false,
    this.validationMessage,
    this.isDisabled = false,
    this.suffixIcon,
    this.onChanged,
    this.customErrorMessage,
    this.maxLength,
    this.isPhone = false,
    this.isEmail = false,
    this.isDirtyEnabled = false,
    this.isDirtyAction,
    this.fieldName,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool _hasError = false;
  // bool _isFocused = false;

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
          onFocusChange: (hasFocus) {
            // setState(() {
            //   _isFocused = hasFocus;
            // });
          },
          child: TextFormField(
            maxLength: widget.maxLength,
            textDirection:
                widget.isPhone ? TextDirection.ltr : TextDirection.rtl,
            textAlign: widget.isPhone ? TextAlign.left : TextAlign.right,
            keyboardType:
                widget.isNumeric ? TextInputType.number : TextInputType.text,
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
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.text300,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color:
                      _hasError
                          ? Colors.red.shade300
                          : Theme.of(context).colorScheme.text300,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color:
                      _hasError
                          ? Colors.red.shade400
                          : Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.red.shade400, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.red.shade400, width: 2),
              ),
              suffixIcon:
                  widget.isPhone
                      ? Container(
                        margin: const EdgeInsets.only(
                          right: 8,
                          top: 8,
                          bottom: 8,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background200,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.text300,
                            width: 0.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '(2+)',
                            style: Theme.of(
                              context,
                            ).textTheme.paragraphLargeMedium.copyWith(
                              color: Theme.of(context).colorScheme.text400,
                            ),
                          ),
                        ),
                      )
                      : widget.suffixIcon,
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
              if (widget.isPhone &&
                  (trimmedValue == null ||
                      trimmedValue.isEmpty ||
                      trimmedValue.length != 11 ||
                      !trimmedValue.startsWith('01'))) {
                setState(() {
                  _hasError = true;
                });
                return Texts.enterCorrectNumber;
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
            onChanged: (value) {
              if (widget.isDirtyEnabled && widget.isDirtyAction != null) {
                widget.isDirtyAction!();
              }
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
          ),
        ),
      ],
    );
  }
}
