import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahary_united_company_for_powers/models/division.dart';
import 'package:sahary_united_company_for_powers/models/product.dart';
import 'package:sahary_united_company_for_powers/repositories/division_repo.dart';

// Model to hold both divisions and products data
class HomeData {
  final List<Division> divisions;
  final List<Product> products;

  HomeData({
    required this.divisions,
    required this.products,
  });

  HomeData copyWith({
    List<Division>? divisions,
    List<Product>? products,
  }) {
    return HomeData(
      divisions: divisions ?? this.divisions,
      products: products ?? this.products,
    );
  }
}

class HomeDataNotifier extends StateNotifier<AsyncValue<HomeData>> {
  final DivisionRepository repository;

  HomeDataNotifier(this.repository) : super(const AsyncValue.loading()) {
    fetchHomeData();
  }

  Future<void> fetchHomeData() async {
    try {
      // Fetch both divisions and products concurrently
      final results = await Future.wait([
        repository.fetchDivisions(),
        repository.fetchProducts(numberOfItems: 10),
      ]);

      final divisions = results[0] as List<Division>;
      final products = results[1] as List<Product>;

      final homeData = HomeData(
        divisions: divisions,
        products: products,
      );

      state = AsyncValue.data(homeData);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await fetchHomeData();
  }
}

// Repository provider (reusing the existing one)
final divisionRepositoryProvider = Provider((ref) => DivisionRepository());

// Home data provider
final homeDataProvider =
    StateNotifierProvider<HomeDataNotifier, AsyncValue<HomeData>>((ref) {
  final repository = ref.watch(divisionRepositoryProvider);
  return HomeDataNotifier(repository);
});

// Convenience providers to access divisions and products separately
final homeDivisionsProvider = Provider<AsyncValue<List<Division>>>((ref) {
  final homeData = ref.watch(homeDataProvider);
  return homeData.when(
    data: (data) => AsyncValue.data(data.divisions),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

final homeProductsProvider = Provider<AsyncValue<List<Product>>>((ref) {
  final homeData = ref.watch(homeDataProvider);
  return homeData.when(
    data: (data) => AsyncValue.data(data.products),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});