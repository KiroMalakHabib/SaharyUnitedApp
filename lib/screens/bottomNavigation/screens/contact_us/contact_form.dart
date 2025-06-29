import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/providers/contact_provider.dart';
import 'package:sahary_united_company_for_powers/services/toast_service.dart';
import 'package:sahary_united_company_for_powers/widgets/app_filled_btn.dart';
import 'package:sahary_united_company_for_powers/widgets/text_area_input.dart';
import 'package:sahary_united_company_for_powers/widgets/text_input.dart';

class ContactForm extends ConsumerStatefulWidget {
  const ContactForm({super.key});

  @override
  ConsumerState<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends ConsumerState<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _handleSendMessage() async {
    // Validation
    if (_nameController.text.trim().isEmpty) {
      ToastService().showServerErrorToast(Texts.pleaseEnterName);
      return;
    }

    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      ToastService().showServerErrorToast(Texts.pleaseEnterPhoneNumber);
      return;
    }
    if (!RegExp(r'^\d+$').hasMatch(phone)) {
      ToastService().showServerErrorToast(Texts.phoneHints);
      return;
    }

    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ToastService().showServerErrorToast(Texts.pleaseEnterEmailAddress);
      return;
    }
    if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)) {
      ToastService().showServerErrorToast(Texts.emailHints);
      return;
    }

    if (_messageController.text.trim().isEmpty) {
      ToastService().showServerErrorToast(Texts.pleaseEnterMessage);
      return;
    }

    // Set loading state
    ref.read(isSubmittingContactProvider.notifier).state = true;

    try {
      final success = await ref
          .read(contactProvider.notifier)
          .submitContactMessage(
            name: _nameController.text.trim(),
            email: email,
            phone: phone,
            message: _messageController.text.trim(),
          );

      if (success) {
        _clearForm();
        Navigator.of(context, rootNavigator: true).pop();
        ToastService().showSuccessToast(Texts.messageSentSuccessfully);
      } else {
        ToastService().showServerErrorToast(Texts.inputError);
      }
    } catch (error) {
      ToastService().showServerErrorToast(Texts.inputError);
    } finally {
      ref.read(isSubmittingContactProvider.notifier).state = false;
    }
  }

  void _clearForm() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isSubmitting = ref.watch(isSubmittingContactProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 80,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextInputField(
                          controller: _nameController,
                          label: Texts.name,
                          isDisabled: isSubmitting,
                          isRequired: true,
                        ),
                        const SizedBox(height: 30),
                        TextInputField(
                          controller: _phoneController,
                          label: Texts.phoneNumber,
                          isNumeric: true,
                          isDisabled: isSubmitting,
                          isRequired: true,
                        ),
                        const SizedBox(height: 30),
                        TextInputField(
                          controller: _emailController,
                          label: Texts.emailAddress,
                          isEmail: true,
                          isDisabled: isSubmitting,
                          isRequired: true,
                        ),
                        const SizedBox(height: 30),
                        TextAreaInputField(
                          controller: _messageController,
                          label: Texts.message,
                          isDisabled: isSubmitting,
                          isRequired: true,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 10 : 0,
              ),
              child: AppFilledBtn(
                btnText: isSubmitting ? Texts.sending : Texts.sendMessage,
                isFullWidth: true,
                onPressed: isSubmitting ? null : _handleSendMessage,
              ),
            ),
          ],
        );
      },
    );
  }
}
