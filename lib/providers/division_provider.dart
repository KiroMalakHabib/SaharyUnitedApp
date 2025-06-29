import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahary_united_company_for_powers/models/division.dart';
import 'package:sahary_united_company_for_powers/repositories/division_repo.dart';

class DivisionNotifier extends StateNotifier<AsyncValue<List<Division>>> {
  final DivisionRepository repository;

  DivisionNotifier(this.repository) : super(const AsyncValue.loading()) {
    fetchDivisions();
  }

  Future<void> fetchDivisions() async {
    try {
      final sections = await repository.fetchDivisions();
      state = AsyncValue.data(sections);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await fetchDivisions();
  }
}

final divisionsRepositoryProvider = Provider((ref) => DivisionRepository());

final divisionsProvider =
    StateNotifierProvider<DivisionNotifier, AsyncValue<List<Division>>>((ref) {
      final repository = ref.watch(divisionsRepositoryProvider);
      return DivisionNotifier(repository);
    });
