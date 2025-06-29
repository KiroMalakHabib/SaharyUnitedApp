import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/models/project.dart';
import 'package:sahary_united_company_for_powers/models/project_location.dart';
import 'package:sahary_united_company_for_powers/models/project_status.dart';
import 'package:sahary_united_company_for_powers/models/project_type.dart';
import 'package:sahary_united_company_for_powers/providers/filter_bottom_sheet_provider.dart';
import 'package:sahary_united_company_for_powers/providers/projects_provider.dart';
import 'package:sahary_united_company_for_powers/screens/bottomNavigation/screens/our_projects/our_projects_filters.dart';
import 'package:sahary_united_company_for_powers/widgets/partition_card.dart';
import 'package:sahary_united_company_for_powers/widgets/scrollable_grid_view.dart';

class OurProjects extends ConsumerStatefulWidget {
  const OurProjects({super.key});

  @override
  ConsumerState<OurProjects> createState() => _OurProjectsState();
}

class _OurProjectsState extends ConsumerState<OurProjects> {
  late final ProviderSubscription<bool> _filterListener;
  List<ProjectLocation> _filteredLocations = [];
  List<ProjectStatus> _filteredStatuses = [];
  List<ProjectType> _filteredTypes = [];

  @override
  void initState() {
    super.initState();
    _filterListener = ref.listenManual<bool>(showFilterBottomSheetProvider, (
      prev,
      next,
    ) {
      if (next == true) {
        _showFilterBottomSheet();
        ref.read(showFilterBottomSheetProvider.notifier).state = false;
      }
    });
  }

  @override
  void dispose() {
    _filterListener.close();
    super.dispose();
  }

  Future<void> _showFilterBottomSheet() async {
    final filtersAsync = ref.read(projectFiltersProvider);

    if (!filtersAsync.hasValue) return;

    final filters = filtersAsync.value!;

    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (_) => OurProjectsFilters(
            availableTypes: filters.types,
            availableLocations: filters.locations,
            availableStatuses: filters.statuses,
            initialTypes: _filteredTypes.toSet(),
            initialLocations: _filteredLocations.toSet(),
            initialStatuses: _filteredStatuses.toSet(),
          ),
    );

    if (result != null) {
      setState(() {
        _filteredLocations =
            (result['locations'] ?? <ProjectLocation>{}).toList();
        _filteredStatuses = (result['statuses'] ?? <ProjectStatus>{}).toList();
        _filteredTypes = (result['types'] ?? <ProjectType>{}).toList();
      });
    }
  }

  List<Project> _filterProjects(List<Project> projects) {
    return projects.where((project) {
      final locationMatch =
          _filteredLocations.isEmpty ||
          _filteredLocations.any((loc) => loc.name == project.location);

      final statusMatch =
          _filteredStatuses.isEmpty ||
          _filteredStatuses.any((status) => status.name == project.status);

      final typeMatch =
          _filteredTypes.isEmpty ||
          _filteredTypes.any((type) => type.name == project.type);

      return locationMatch && statusMatch && typeMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final projectsAsync = ref.watch(projectsProvider);
    final filtersAsync = ref.watch(projectFiltersProvider);

    return Container(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: projectsAsync.when(
        data: (projects) {
          // Check if filters are still loading
          if (filtersAsync.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final filteredProjects = _filterProjects(projects);

          if (filteredProjects.isEmpty) {
            return Center(
              child: Text(
                Texts.noProjects,
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          final List<Widget> projectsWidgets =
              filteredProjects
                  .map(
                    (project) => PartitionCard(
                      imageUrl: project.imageUrl,
                      text: project.projectName,
                      showInternalShadow: true,
                    ),
                  )
                  .toList();

          return ScrollableGridView(children: projectsWidgets);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    Texts.ourProjectsError,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(projectsProvider.notifier).refresh();
                      ref.read(projectFiltersProvider.notifier).refresh();
                    },
                    child: Text(Texts.retry),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
