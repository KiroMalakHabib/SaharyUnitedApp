import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/enums/project_city.dart';
import 'package:sahary_united_company_for_powers/providers/request_prices_provider.dart';
import 'package:sahary_united_company_for_powers/screens/bottomNavigation/bottom_navigator.dart';
import 'package:sahary_united_company_for_powers/services/toast_service.dart';
import 'package:sahary_united_company_for_powers/widgets/app_filled_btn.dart';
import 'package:sahary_united_company_for_powers/widgets/drop_down_field.dart';
import 'package:sahary_united_company_for_powers/widgets/file_upload_field.dart';
import 'package:sahary_united_company_for_powers/widgets/text_area_input.dart';
import 'package:sahary_united_company_for_powers/widgets/text_input.dart';

class RequestPrices extends ConsumerStatefulWidget {
  const RequestPrices({super.key});

  @override
  ConsumerState<RequestPrices> createState() => _RequestPricesState();
}

class _RequestPricesState extends ConsumerState<RequestPrices> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _inquiriesController = TextEditingController();

  ProjectCity? _selectedCity;
  String? _selectedSection;
  String? _fileName;
  File? _selectedFile;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productInfo = ref.read(productInfoProvider);
      final divisionsAsync = ref.read(requestPricesProvider);
      if (productInfo != null) {
        // Use productName in inquiries
        if (productInfo.productName.isNotEmpty) {
          _inquiriesController.text =
              '${Texts.inquireAbout} ${productInfo.productName}';
        }
        if (!productInfo.departmentId.isNaN) {
          divisionsAsync.whenData((divisions) {
            final matching = divisions.firstWhere(
              (d) => d.id == productInfo.departmentId,
            );
            setState(() {
              _selectedSection = matching.name;
            });
          });
        }
        // Clear the provider after use to avoid stale data
        ref.read(productInfoProvider.notifier).state = null;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _companyController.dispose();
    _addressController.dispose();
    _inquiriesController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      ToastService().showServerErrorToast(Texts.permissionDenied);
      return;
    }

    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      setState(() {
        _fileName = result.files.single.name;
        _selectedFile = File(result.files.single.path!);
      });
      ToastService().showSuccessToast(Texts.fileSelectedSuccessfully);
    }
  }

  Future<void> _handleSubmit() async {
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

    if (_companyController.text.trim().isEmpty) {
      ToastService().showServerErrorToast(Texts.pleaseEnterCompanyName);
      return;
    }
    if (_selectedCity == null) {
      ToastService().showServerErrorToast(Texts.pleaseSelectCity);
      return;
    }
    if (_addressController.text.trim().isEmpty) {
      ToastService().showServerErrorToast(Texts.pleaseEnterAddress);
      return;
    }
    if (_selectedSection == null) {
      ToastService().showServerErrorToast(Texts.pleaseSelectSection);
      return;
    }

    // Set loading state
    ref.read(isSubmittingProvider.notifier).state = true;

    try {
      final success = await ref
          .read(requestPricesProvider.notifier)
          .submitQuoteRequest(
            name: _nameController.text.trim(),
            email: email,
            phone: phone,
            companyName: _companyController.text.trim(),
            city: _selectedCity!.toJson(),
            division: _selectedSection!,
            location: _addressController.text.trim(),
            message:
                _inquiriesController.text.trim().isNotEmpty
                    ? _inquiriesController.text.trim()
                    : null,
            file: _selectedFile,
          );

      if (success) {
        _clearForm();
        ToastService().showSuccessToast(Texts.requestSentSuccessfully);
      } else {
        ToastService().showServerErrorToast(Texts.inputError);
      }
    } catch (error) {
      ToastService().showServerErrorToast(Texts.inputError);
    } finally {
      ref.read(isSubmittingProvider.notifier).state = false;
    }
  }

  void _clearForm() {
    _nameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _companyController.clear();
    _addressController.clear();
    _inquiriesController.clear();
    setState(() {
      _selectedCity = null;
      _selectedSection = null;
      _fileName = null;
      _selectedFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSubmitting = ref.watch(isSubmittingProvider);
    final divisionsAsync = ref.watch(requestPricesProvider);

    return Container(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: LayoutBuilder(
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
                        spacing: 30,
                        children: [
                          TextInputField(
                            controller: _nameController,
                            label: Texts.name,
                            isDisabled: isSubmitting,
                            isRequired: true,
                          ),
                          TextInputField(
                            controller: _phoneController,
                            label: Texts.phoneNumber,
                            isNumeric: true,
                            isDisabled: isSubmitting,
                            isRequired: true,
                          ),
                          TextInputField(
                            controller: _emailController,
                            label: Texts.emailAddress,
                            isEmail: true,
                            isDisabled: isSubmitting,
                            isRequired: true,
                          ),
                          TextInputField(
                            controller: _companyController,
                            label: Texts.companyName,
                            isDisabled: isSubmitting,
                            isRequired: true,
                          ),
                          DropdownField(
                            label: Texts.city,
                            value: _selectedCity?.toJson(),
                            isRequired: true,
                            items:
                                ProjectCity.values
                                    .map((city) => city.toJson())
                                    .toList(),
                            isDisabled: isSubmitting,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _selectedCity = ProjectCityExtension.fromJson(
                                    value,
                                  );
                                });
                              }
                            },
                          ),
                          TextInputField(
                            controller: _addressController,
                            label: Texts.address,
                            isDisabled: isSubmitting,
                            isRequired: true,
                          ),

                          divisionsAsync.when(
                            data:
                                (divisions) => DropdownField(
                                  label: Texts.section,
                                  value: _selectedSection,
                                  items:
                                      divisions
                                          .map((division) => division.name)
                                          .toList(),
                                  isDisabled: isSubmitting,
                                  isRequired: true,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedSection = value;
                                    });
                                  },
                                ),
                            loading:
                                () => DropdownField(
                                  label: Texts.section,
                                  value: null,
                                  items: const [],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedSection = value;
                                    });
                                  },
                                ),
                            error:
                                (error, stack) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Texts.section,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.red),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              Texts.requestPricesError,
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              ref
                                                  .read(
                                                    requestPricesProvider
                                                        .notifier,
                                                  )
                                                  .refresh();
                                            },
                                            child: Text(Texts.retry),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                          ),
                          FileUploadField(
                            label: Texts.uploadFile,
                            fileName: _fileName,
                            isDisabled: isSubmitting,
                            onTap: _pickFile,
                          ),
                          TextAreaInputField(
                            controller: _inquiriesController,
                            label: Texts.inquiries,
                            isDisabled: isSubmitting,
                          ),
                          AppFilledBtn(
                            btnText:
                                isSubmitting
                                    ? Texts.sending
                                    : Texts.sendPriceRequest,
                            isFullWidth: true,
                            onPressed: isSubmitting ? null : _handleSubmit,
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
