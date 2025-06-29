import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/models/brand.dart';
import 'package:sahary_united_company_for_powers/providers/division_screen_provider.dart';
import 'package:sahary_united_company_for_powers/routes.dart';
import 'package:sahary_united_company_for_powers/screens/bottomNavigation/screens/divisions/brands_filter.dart';
import 'package:sahary_united_company_for_powers/screens/drawerScreens/secondary_app_bar.dart';
import 'package:sahary_united_company_for_powers/widgets/image_card.dart';
import 'package:sahary_united_company_for_powers/widgets/scrollable_grid_view.dart';

class DivisionScreen extends ConsumerStatefulWidget {
  final int divisionId;
  final String title;
  final String divisionName;
  final bool isSearchMode;

  const DivisionScreen({
    super.key,
    required this.divisionId,
    required this.title,
    required this.divisionName,
    this.isSearchMode = false,
  });

  @override
  ConsumerState<DivisionScreen> createState() => _DivisionScreenState();
}

class _DivisionScreenState extends ConsumerState<DivisionScreen> {
  List<Brand> _selectedFilters = [];
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: widget.isSearchMode ? widget.divisionName : '',
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _showFilterBottomSheet(List<Brand> availableBrands) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => BrandsFilter(
            initialBrands: _selectedFilters.toSet(),
            availableBrands: availableBrands,
          ),
    );

    if (result != null) {
      setState(() {
        _selectedFilters = (result['brands'] ?? <Brand>{}).toList();
      });
    }
  }

  void _onSearchChanged(String query) {
    if (widget.isSearchMode) {
      ref
          .read(
            divisionScreenDataProvider((
              divisionName: widget.divisionName,
              isSearchMode: widget.isSearchMode,
            )).notifier,
          )
          .updateSearch(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    final providerParams = (
      divisionName: widget.divisionName,
      isSearchMode: widget.isSearchMode,
    );

    final divisionDataState = ref.watch(
      divisionScreenDataProvider(providerParams),
    );

    return Scaffold(
      appBar: SecondaryAppBar(
        title: widget.title,
        showFilterIcon: true,
        filtered: _selectedFilters.isNotEmpty,
        filterAction: () {
          final data = ref.read(divisionScreenDataProvider(providerParams));
          data.whenData((divisionData) {
            _showFilterBottomSheet(divisionData.brands);
          });
        },
      ),
      body: Container(
        color: AppColors.primary,
        padding: const EdgeInsets.only(top: 2),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.neutral,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: AppColors.secondary.withAlpha(100),
                blurRadius: 5,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              children: [
                // Search bar for search mode
                if (widget.isSearchMode) ...[
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: AppColors.background0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: AppColors.icon),
                      ),
                      hintText: Texts.searchProducts,
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onChanged: _onSearchChanged,
                  ),
                  const SizedBox(height: 16),
                ],

                // Products list
                Expanded(
                  child: divisionDataState.when(
                    data: (divisionData) {
                      var productsToShow = divisionData.filteredProducts;

                      // Apply brand filters
                      if (_selectedFilters.isNotEmpty) {
                        productsToShow =
                            productsToShow.where((product) {
                              return product.brands.any(
                                (productBrand) => _selectedFilters.any(
                                  (selectedBrand) =>
                                      selectedBrand.id == productBrand.id,
                                ),
                              );
                            }).toList();
                      }

                      if (productsToShow.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.inventory_2_outlined,
                                size: 64,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                widget.isSearchMode
                                    ? Texts.noProductsMatchSearch
                                    : Texts.noProducts,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ScrollableGridView(
                        children:
                            productsToShow.map((product) {
                              final imageUrl =
                                  product.gallery.isNotEmpty
                                      ? product.gallery[0].url
                                      : '';
                              return Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: ImageCard(
                                  imageUrl: imageUrl,
                                  title: product.title,
                                  subTitle: product.categorry,
                                  action: () {
                                    // Build specifications map from product properties
                                    Map<String, dynamic> specifications = {};

                                    if (product.brand != null)
                                      specifications['Brand'] = product.brand!;
                                    if (product.model != null)
                                      specifications['Model'] = product.model!;
                                    if (product.categorry != null)
                                      specifications['Category'] =
                                          product.categorry!;
                                    if (product.year != null)
                                      specifications['Year'] = product.year!;
                                    if (product.operatinghours != null)
                                      specifications['Operating Hours'] =
                                          product.operatinghours!;
                                    if (product.carriage != null)
                                      specifications['Carriage'] =
                                          product.carriage!;
                                    if (product.weight != null)
                                      specifications['Weight'] =
                                          product.weight!;
                                    if (product.drillingdepth != null)
                                      specifications['Drilling Depth'] =
                                          product.drillingdepth!;
                                    if (product.drillingradius != null)
                                      specifications['Drilling Radius'] =
                                          product.drillingradius!;
                                    if (product.dischargeheight != null)
                                      specifications['Discharge Height'] =
                                          product.dischargeheight!;
                                    if (product.hydropump != null)
                                      specifications['Hydro Pump'] =
                                          product.hydropump!;
                                    if (product.hoppercapacity != null)
                                      specifications['Hopper Capacity'] =
                                          product.hoppercapacity!;
                                    if (product.generalstandards != null)
                                      specifications['General Standards'] =
                                          product.generalstandards!;
                                    if (product.enginepower != null)
                                      specifications['Engine Power'] =
                                          product.enginepower!;
                                    if (product.gastype != null)
                                      specifications['Gas Type'] =
                                          product.gastype!;

                                    // Add boolean features
                                    if (product.warming == true)
                                      specifications['Warming'] = 'Yes';
                                    if (product.airconditioner == true)
                                      specifications['Air Conditioner'] = 'Yes';
                                    if (product.tacometer == true)
                                      specifications['Tacometer'] = 'Yes';
                                    if (product.frontheadlights == true)
                                      specifications['Front Headlights'] =
                                          'Yes';
                                    if (product.foglights == true)
                                      specifications['Fog Lights'] = 'Yes';
                                    if (product.regularhooper == true)
                                      specifications['Regular Hooper'] = 'Yes';
                                    final departmentId =
                                        product.divisions.isNotEmpty
                                            ? product.divisions[0].id
                                            : 0;
                                    Navigator.of(
                                      context,
                                      rootNavigator: true,
                                    ).pushNamed(
                                      AppRoutes.productDetails,
                                      arguments: {
                                        'department_id':
                                            widget.divisionId == 0
                                                ? departmentId
                                                : widget.divisionId,
                                        'id': product.id,
                                        'imageUrl': imageUrl,
                                        'title': product.title,
                                        'tags':
                                            product.brands
                                                .map((brand) => brand.name)
                                                .toList(),
                                        'specifications': specifications,
                                        'product': product,
                                      },
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                      );
                    },
                    loading:
                        () => const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                    error:
                        (error, stack) => Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 48,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                Texts.productsError,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.red),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  ref
                                      .read(
                                        divisionScreenDataProvider(
                                          providerParams,
                                        ).notifier,
                                      )
                                      .refresh();
                                },
                                child: Text(Texts.retry),
                              ),
                            ],
                          ),
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
