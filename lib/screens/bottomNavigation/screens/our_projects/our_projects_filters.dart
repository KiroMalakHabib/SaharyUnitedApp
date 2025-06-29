import 'package:flutter/material.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/constants/app_text_styles.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/models/project_location.dart';
import 'package:sahary_united_company_for_powers/models/project_status.dart';
import 'package:sahary_united_company_for_powers/models/project_type.dart';
import 'package:sahary_united_company_for_powers/widgets/app_filled_btn.dart';

class OurProjectsFilters extends StatefulWidget {
  final List<ProjectType> availableTypes;
  final List<ProjectLocation> availableLocations;
  final List<ProjectStatus> availableStatuses;
  final Set<ProjectType> initialTypes;
  final Set<ProjectLocation> initialLocations;
  final Set<ProjectStatus> initialStatuses;

  const OurProjectsFilters({
    super.key,
    required this.availableTypes,
    required this.availableLocations,
    required this.availableStatuses,
    this.initialTypes = const {},
    this.initialLocations = const {},
    this.initialStatuses = const {},
  });

  @override
  State<OurProjectsFilters> createState() => _OurProjectsFiltersState();
}

class _OurProjectsFiltersState extends State<OurProjectsFilters> {
  late Set<ProjectType> _selectedTypes;
  late Set<ProjectLocation> _selectedLocations;
  late Set<ProjectStatus> _selectedStatuses;

  @override
  void initState() {
    super.initState();
    // Initialize with the passed values
    _selectedTypes = Set.from(widget.initialTypes);
    _selectedLocations = Set.from(widget.initialLocations);
    _selectedStatuses = Set.from(widget.initialStatuses);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.background0,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              _buildFilterSection<ProjectType>(
                title: Texts.projectType,
                values: widget.availableTypes,
                selectedValues: _selectedTypes,
                labelBuilder: (type) => type.name,
              ),
              _buildFilterSection<ProjectLocation>(
                title: Texts.geographicLocation,
                values: widget.availableLocations,
                selectedValues: _selectedLocations,
                labelBuilder: (location) => location.name,
              ),
              _buildFilterSection<ProjectStatus>(
                title: Texts.projectState,
                values: widget.availableStatuses,
                selectedValues: _selectedStatuses,
                labelBuilder: (status) => status.name,
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
              _selectedLocations.clear();
              _selectedStatuses.clear();
              _selectedTypes.clear();
            });
          },
        ),
        const SizedBox(height: 12),
        AppFilledBtn(
          btnText: Texts.showResults,
          onPressed: () {
            Navigator.of(context).pop({
              'locations': _selectedLocations,
              'statuses': _selectedStatuses,
              'types': _selectedTypes,
            });
          },
          isFullWidth: true,
        ),
      ],
    );
  }
}