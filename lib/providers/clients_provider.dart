import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahary_united_company_for_powers/models/client.dart';
import 'package:sahary_united_company_for_powers/repositories/clients_repo.dart';

class ClientsNotifier extends StateNotifier<AsyncValue<List<Client>>> {
  final ClientsRepository repository;

  ClientsNotifier(this.repository) : super(const AsyncValue.loading()) {
    fetchClients();
  }

  Future<void> fetchClients() async {
    try {
      final clients = await repository.fetchClients();
      state = AsyncValue.data(clients);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await fetchClients();
  }
}

final clientsRepositoryProvider = Provider((ref) => ClientsRepository());

final clientsProvider =
    StateNotifierProvider<ClientsNotifier, AsyncValue<List<Client>>>((ref) {
  final repository = ref.watch(clientsRepositoryProvider);
  return ClientsNotifier(repository);
});