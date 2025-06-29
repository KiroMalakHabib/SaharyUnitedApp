import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahary_united_company_for_powers/models/brand.dart';
import 'package:sahary_united_company_for_powers/models/product.dart';
import 'package:sahary_united_company_for_powers/repositories/division_repo.dart';

class DivisionScreenData {
  final List<Product> products;
  final List<Brand> brands;
  final List<Product> filteredProducts;

  DivisionScreenData({
    required this.products,
    required this.brands,
    required this.filteredProducts,
  });

  DivisionScreenData copyWith({
    List<Product>? products,
    List<Brand>? brands,
    List<Product>? filteredProducts,
  }) {
    return DivisionScreenData(
      products: products ?? this.products,
      brands: brands ?? this.brands,
      filteredProducts: filteredProducts ?? this.filteredProducts,
    );
  }
}

class DivisionScreenNotifier extends StateNotifier<AsyncValue<DivisionScreenData>> {
  final DivisionRepository repository;
  final String divisionName;
  final bool isSearchMode;

  DivisionScreenNotifier(this.repository, this.divisionName, this.isSearchMode) 
      : super(const AsyncValue.loading()) {
    fetchDivisionData();
  }

  Future<void> fetchDivisionData() async {
    try {
      final results = await Future.wait([
        isSearchMode 
          ? repository.fetchProducts() // Fetch all products for search
          : repository.fetchProducts(
              hasDivision: true,
              division: divisionName,
            ),
        repository.fetchBrands(),
      ]);

      final allProducts = results[0] as List<Product>;
      final brands = results[1] as List<Brand>;

      List<Product> filteredProducts;
      
      if (isSearchMode) {
        // Filter products based on search query
        filteredProducts = allProducts.where((product) {
          final searchQuery = divisionName.toLowerCase();
          return product.title.toLowerCase().contains(searchQuery) ||
                 (product.titleEn?.toLowerCase().contains(searchQuery) ?? false) ||
                 (product.brand?.toLowerCase().contains(searchQuery) ?? false) ||
                 (product.model?.toLowerCase().contains(searchQuery) ?? false) ||
                 (product.categorry?.toLowerCase().contains(searchQuery) ?? false) ||
                 product.brands.any((brand) => brand.name.toLowerCase().contains(searchQuery));
        }).toList();
      } else {
        filteredProducts = allProducts;
      }

      final divisionData = DivisionScreenData(
        products: allProducts,
        brands: brands,
        filteredProducts: filteredProducts,
      );

      state = AsyncValue.data(divisionData);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await fetchDivisionData();
  }

  void updateSearch(String query) {
    final currentState = state;
    if (currentState is AsyncData<DivisionScreenData>) {
      final data = currentState.value;
      final filteredProducts = data.products.where((product) {
        final searchQuery = query.toLowerCase();
        return product.title.toLowerCase().contains(searchQuery) ||
               (product.titleEn?.toLowerCase().contains(searchQuery) ?? false) ||
               (product.brand?.toLowerCase().contains(searchQuery) ?? false) ||
               (product.model?.toLowerCase().contains(searchQuery) ?? false) ||
               (product.categorry?.toLowerCase().contains(searchQuery) ?? false) ||
               product.brands.any((brand) => brand.name.toLowerCase().contains(searchQuery));
      }).toList();

      state = AsyncValue.data(data.copyWith(filteredProducts: filteredProducts));
    }
  }
}

final divisionRepositoryProvider = Provider((ref) => DivisionRepository());

final divisionScreenDataProvider = StateNotifierProvider.family<
    DivisionScreenNotifier,
    AsyncValue<DivisionScreenData>,
    ({String divisionName, bool isSearchMode})>((ref, params) {
  final repository = ref.watch(divisionRepositoryProvider);
  return DivisionScreenNotifier(repository, params.divisionName, params.isSearchMode);
});

final divisionProductsProvider = Provider.family<AsyncValue<List<Product>>, ({String divisionName, bool isSearchMode})>((ref, params) {
  final divisionData = ref.watch(divisionScreenDataProvider(params));
  return divisionData.when(
    data: (data) => AsyncValue.data(data.filteredProducts),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

final divisionBrandsProvider = Provider.family<AsyncValue<List<Brand>>, ({String divisionName, bool isSearchMode})>((ref, params) {
  final divisionData = ref.watch(divisionScreenDataProvider(params));
  return divisionData.when(
    data: (data) => AsyncValue.data(data.brands),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});