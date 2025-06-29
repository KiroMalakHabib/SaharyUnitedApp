import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahary_united_company_for_powers/models/division.dart';
import 'package:sahary_united_company_for_powers/repositories/division_repo.dart';
import 'package:sahary_united_company_for_powers/repositories/request_prices_repo.dart';

class RequestPricesNotifier extends StateNotifier<AsyncValue<List<Division>>> {
  final DivisionRepository divisionRepository;
  final RequestPricesRepository requestPricesRepository;
  
  RequestPricesNotifier(
    this.divisionRepository,
    this.requestPricesRepository,
  ) : super(const AsyncValue.loading()) {
    fetchDivisions();
  }

  Future<void> fetchDivisions() async {
    try {
      final sections = await divisionRepository.fetchDivisions();
      state = AsyncValue.data(sections);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await fetchDivisions();
  }

  Future<bool> submitQuoteRequest({
    required String name,
    required String email,
    required String phone,
    required String companyName,
    required String city,
    required String division,
    required String location,
    String? message,
    File? file,
  }) async {
    try {
      return await requestPricesRepository.submitQuoteRequest(
        name: name,
        email: email,
        phone: phone,
        companyName: companyName,
        city: city,
        division: division,
        location: location,
        message: message,
        file: file,
      );
    } catch (error) {
      rethrow;
    }
  }
}

// Providers
final divisionRepositoryProvider = Provider((ref) => DivisionRepository());

final requestPricesRepositoryProvider = Provider((ref) => RequestPricesRepository());

final requestPricesProvider = StateNotifierProvider<RequestPricesNotifier, AsyncValue<List<Division>>>((ref) {
  final divisionRepository = ref.watch(divisionRepositoryProvider);
  final requestPricesRepository = ref.watch(requestPricesRepositoryProvider);
  return RequestPricesNotifier(divisionRepository, requestPricesRepository);
});

// Loading state provider for form submission
final isSubmittingProvider = StateProvider<bool>((ref) => false);