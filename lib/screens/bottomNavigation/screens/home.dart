import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/constants/app_text_styles.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/providers/home_provider.dart';
import 'package:sahary_united_company_for_powers/routes.dart';
import 'package:sahary_united_company_for_powers/widgets/image_card.dart';
import 'package:sahary_united_company_for_powers/widgets/partition_card.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  // Helper method to build specifications map from product properties
  Map<String, dynamic> _buildSpecifications(product) {
    Map<String, dynamic> specifications = {};
    
    if (product.brand != null) specifications['Brand'] = product.brand!;
    if (product.model != null) specifications['Model'] = product.model!;
    if (product.categorry != null) specifications['Category'] = product.categorry!;
    if (product.year != null) specifications['Year'] = product.year!;
    if (product.operatinghours != null) specifications['Operating Hours'] = product.operatinghours!;
    if (product.carriage != null) specifications['Carriage'] = product.carriage!;
    if (product.weight != null) specifications['Weight'] = product.weight!;
    if (product.drillingdepth != null) specifications['Drilling Depth'] = product.drillingdepth!;
    if (product.drillingradius != null) specifications['Drilling Radius'] = product.drillingradius!;
    if (product.dischargeheight != null) specifications['Discharge Height'] = product.dischargeheight!;
    if (product.hydropump != null) specifications['Hydro Pump'] = product.hydropump!;
    if (product.hoppercapacity != null) specifications['Hopper Capacity'] = product.hoppercapacity!;
    if (product.generalstandards != null) specifications['General Standards'] = product.generalstandards!;
    if (product.enginepower != null) specifications['Engine Power'] = product.enginepower!;
    if (product.gastype != null) specifications['Gas Type'] = product.gastype!;
    
    // Add boolean features
    if (product.warming == true) specifications['Warming'] = 'Yes';
    if (product.airconditioner == true) specifications['Air Conditioner'] = 'Yes';
    if (product.tacometer == true) specifications['Tacometer'] = 'Yes';
    if (product.frontheadlights == true) specifications['Front Headlights'] = 'Yes';
    if (product.foglights == true) specifications['Fog Lights'] = 'Yes';
    if (product.regularhooper == true) specifications['Regular Hooper'] = 'Yes';
    
    return specifications;
  }

  @override
  Widget build(BuildContext context) {
    final homeDataState = ref.watch(homeDataProvider);

    return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: homeDataState.when(
        data:
            (homeData) => SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Texts.departments,
                    style: AppTextStyles.inputLargeMedium.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homeData.divisions.length,
                      itemBuilder: (context, index) {
                        final division = homeData.divisions[index];
                        return Container(
                          width: 160,
                          margin: EdgeInsets.only(right: 12),
                          child: PartitionCard(
                            imageUrl: division.image ?? '',
                            text: division.name,
                            showInternalShadow: true,
                            action:
                                () => Navigator.of(
                                  context,
                                  rootNavigator: true,
                                ).pushNamed(
                                  AppRoutes.departmentScreen,
                                  arguments: {
                                    'id': division.id,
                                    'title': division.name,
                                    'divisionName': division.name,
                                  },
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 35),
                  Text(
                    Texts.notableProducts,
                    style: AppTextStyles.inputLargeMedium.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homeData.products.length,
                      itemBuilder: (context, index) {
                        final product = homeData.products[index];
                        final imageUrl =
                            (product.gallery.isNotEmpty)
                                ? product.gallery[0].url
                                : '';

                        // Build specifications for this product
                        final specifications = _buildSpecifications(product);

                        // Get the first division ID, or use a default if no divisions
                        final departmentId = product.divisions.isNotEmpty
                            ? product.divisions[0].id
                            : 0;

                        return Container(
                          width: 180,
                          margin: EdgeInsets.only(right: 12),
                          child: ImageCard(
                            imageUrl: imageUrl,
                            title: product.title,
                            subTitle: product.categorry,
                            action:
                                () => Navigator.of(
                                  context,
                                  rootNavigator: true,
                                ).pushNamed(
                                  AppRoutes.productDetails,
                                  arguments: {
                                    'department_id': departmentId,
                                    'id': product.id,
                                    'imageUrl': imageUrl,
                                    'title': product.title,
                                    'tags':
                                        product.brands
                                            .map((brand) => brand.name)
                                            .toList(),
                                    'specifications': specifications,
                                  },
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
        loading:
            () => const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
        error:
            (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    Texts.homeError,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(homeDataProvider.notifier).refresh();
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