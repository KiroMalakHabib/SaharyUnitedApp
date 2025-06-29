import 'package:flutter/material.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/constants/app_text_styles.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/models/brand.dart';
import 'package:sahary_united_company_for_powers/widgets/app_filled_btn.dart';

class BrandsFilter extends StatefulWidget {
  final Set<Brand> initialBrands;
  final List<Brand> availableBrands;

  const BrandsFilter({
    super.key,
    required this.availableBrands,
    this.initialBrands = const {},
  });

  @override
  State<BrandsFilter> createState() => _BrandsFilterState();
}

class _BrandsFilterState extends State<BrandsFilter> {
  late Set<Brand> _selectedBrands;

  @override
  void initState() {
    super.initState();
    _selectedBrands = Set.from(widget.initialBrands);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.background0,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              _buildFilterSection<Brand>(
                title: Texts.brandsAndModels,
                values: widget.availableBrands,
                selectedValues: _selectedBrands,
                labelBuilder: (brand) => brand.name,
              ),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection<T>({
    required String title,
    required List<T> values,
    required Set<T> selectedValues,
    required String Function(T) labelBuilder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.paragraphLargeMedium.copyWith(
            color: AppColors.secondary,
          ),
        ),
        const SizedBox(height: 26),
        Wrap(
          spacing: 8,
          runSpacing: 11,
          children: values.map((value) {
            final selected = selectedValues.contains(value);
            return ChoiceChip(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              label: Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  labelBuilder(value),
                  style: AppTextStyles.paragraphLargeMedium_2.copyWith(
                    color: selected
                        ? AppColors.background0
                        : AppColors.secondary,
                  ),
                ),
              ),
              selected: selected,
              selectedColor: AppColors.primary,
              backgroundColor: Colors.transparent,
              checkmarkColor: AppColors.background0,
              side: const BorderSide(color: AppColors.secondary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              onSelected: (_) {
                setState(() {
                  if (selected) {
                    selectedValues.remove(value);
                  } else {
                    selectedValues.add(value);
                  }
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        AppFilledBtn(
          btnText: Texts.clearAll,
          isFullWidth: true,
          backgroundColor: AppColors.neutral,
          foregroundColor: AppColors.secondary,
          borderColor: AppColors.secondary,
          borderWidth: 1,
          onPressed: () {
            setState(() {
              _selectedBrands.clear();
            });
          },
        ),
        const SizedBox(height: 12),
        AppFilledBtn(
          btnText: Texts.showResults,
          onPressed: () {
            Navigator.of(context).pop({'brands': _selectedBrands});
          },
          isFullWidth: true,
        ),
      ],
    );
  }
}