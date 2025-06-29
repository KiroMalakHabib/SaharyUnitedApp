import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahary_united_company_for_powers/models/partner.dart';
import 'package:sahary_united_company_for_powers/repositories/partners_repo.dart';

class PartnersNotifier extends StateNotifier<AsyncValue<List<Partner>>> {
  final PartnersRepository repository;

  PartnersNotifier(this.repository) : super(const AsyncValue.loading()) {
    fetchPartners();
  }

  Future<void> fetchPartners() async {
    try {
      final partners = await repository.fetchPartners();
      state = AsyncValue.data(partners);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await fetchPartners();
  }
}

final partnersRepositoryProvider = Provider((ref) => PartnersRepository());

final partnersProvider =
    StateNotifierProvider<PartnersNotifier, AsyncValue<List<Partner>>>((ref) {
  final repository = ref.watch(partnersRepositoryProvider);
  return PartnersNotifier(repository);
});