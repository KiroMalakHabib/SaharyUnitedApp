// providers/projects_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahary_united_company_for_powers/models/project.dart';
import 'package:sahary_united_company_for_powers/models/project_filters.dart';
import 'package:sahary_united_company_for_powers/repositories/projects_repo.dart';

// Project Filters Notifier
class ProjectFiltersNotifier extends StateNotifier<AsyncValue<ProjectFilters>> {
  final ProjectsRepository repository;

  ProjectFiltersNotifier(this.repository) : super(const AsyncValue.loading()) {
    fetchProjectFilters();
  }

  Future<void> fetchProjectFilters() async {
    try {
      final filters = await repository.fetchProjectFilters();
      state = AsyncValue.data(filters);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await fetchProjectFilters();
  }
}

// Projects Notifier
class ProjectsNotifier extends StateNotifier<AsyncValue<List<Project>>> {
  final ProjectsRepository repository;

  ProjectsNotifier(this.repository) : super(const AsyncValue.loading()) {
    fetchProjects();
  }

  Future<void> fetchProjects() async {
    try {
      final projects = await repository.fetchProjectsData();
      state = AsyncValue.data(projects);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await fetchProjects();
  }
}

// Repository Provider
final projectsRepositoryProvider = Provider((ref) => ProjectsRepository());

// Project Filters Provider
final projectFiltersProvider =
    StateNotifierProvider<ProjectFiltersNotifier, AsyncValue<ProjectFilters>>((ref) {
  final repository = ref.watch(projectsRepositoryProvider);
  return ProjectFiltersNotifier(repository);
});

// Projects Provider
final projectsProvider =
    StateNotifierProvider<ProjectsNotifier, AsyncValue<List<Project>>>((ref) {
  final repository = ref.watch(projectsRepositoryProvider);
  return ProjectsNotifier(repository);
});