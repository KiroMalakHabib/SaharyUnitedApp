import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/constants/app_icons_path.dart';
import 'package:sahary_united_company_for_powers/constants/app_text_styles.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/models/product.dart';
import 'package:sahary_united_company_for_powers/widgets/app_filled_btn.dart';
import 'package:sahary_united_company_for_powers/routes.dart';

class ProductDetails extends StatefulWidget {
  final int departmentId;
  final int id;
  final String imageUrl;
  final String title;
  final Map<String, dynamic> specifications;
  final List<String> tags;
  final VoidCallback? onRequestProduct;
  final VoidCallback? onViewEquipment;
  final Product product;

  const ProductDetails({
    super.key,
    required this.departmentId,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.specifications,
    required this.tags,
    required this.product,
    this.onRequestProduct,
    this.onViewEquipment,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _navigateToRequestPrices() {
    final departmentId =
        widget.product.divisions.isNotEmpty
            ? widget.product.divisions[0].id
            : 0;
    Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
      AppRoutes.bottomNavigator,
      (route) => false,
      arguments: {
        'tabIndex': 2,
        'productName': widget.title,
        'department_id': departmentId != 0 ? departmentId : widget.departmentId,
      },
    );
  }

  Widget _buildSpecificationsTab() {
    if (widget.specifications.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            Texts.noSpecs,
            style: AppTextStyles.paragraphMediumMedium.copyWith(
              color: AppColors.text500,
            ),
          ),
        ),
      );
    }

    return Column(
      children:
          widget.specifications.entries.map<Widget>((entry) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          entry.key,
                          style: AppTextStyles.paragraphLargeMedium_2.copyWith(
                            color: AppColors.text500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          entry.value.toString(),
                          style: AppTextStyles.paragraphLargeMedium_3.copyWith(
                            color: AppColors.secondary,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: AppColors.divider, thickness: 1.5),
              ],
            );
          }).toList(),
    );
  }

  Widget _buildUsageGuideTab() {
    return Center(
      child: Text(Texts.guide, style: AppTextStyles.paragraphMediumMedium),
    );
  }

  Widget _buildVideosTab() {
    return Center(
      child: Text(Texts.videos, style: AppTextStyles.paragraphMediumMedium),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double expandedHeight = MediaQuery.of(context).size.height * 0.32;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors.background0,
                expandedHeight: expandedHeight,
                toolbarHeight: 40,
                automaticallyImplyLeading: false,
                pinned: true,
                titleSpacing: 0,
                title: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppColors.neutral,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        AppIconsPath.rightArrow,
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(32),
                  child: Container(
                    width: double.infinity,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.background0,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      FastCachedImage(
                        url: widget.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        cacheHeight: 800,
                        fadeInDuration: const Duration(milliseconds: 300),
                        alignment: Alignment.topCenter,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.background200,
                            child: Icon(Icons.error, color: AppColors.error),
                          );
                        },
                        loadingBuilder: (context, progress) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                      Positioned.fill(
                        child: IgnorePointer(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.secondary.withAlpha(153),
                                  Colors.transparent,
                                  AppColors.secondary.withAlpha(153),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(18, 0, 18, bottomPadding + 110),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: AppTextStyles.titleH1Light.copyWith(
                          color: AppColors.secondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),

                      // Tags - Show only if not empty
                      if (widget.tags.isNotEmpty) ...[
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children:
                                widget.tags.map((tag) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 20,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.secondary,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        tag,
                                        style: AppTextStyles
                                            .paragraphMediumMedium
                                            .copyWith(
                                              color: AppColors.secondary,
                                            ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),
                        const SizedBox(height: 25),
                      ],

                      // Tab Bar
                      TabBar(
                        controller: _tabController,
                        labelColor: AppColors.primary,
                        unselectedLabelColor: AppColors.secondary,
                        indicatorColor: AppColors.primary,
                        indicatorWeight: 3,
                        labelStyle: AppTextStyles.paragraphMediumBold,
                        unselectedLabelStyle: AppTextStyles.paragraphMediumBold,
                        dividerColor: AppColors.secondary.withAlpha(30),
                        labelPadding: EdgeInsets.zero,
                        tabs: [
                          Tab(text: Texts.specs),
                          Tab(text: Texts.guide),
                          Tab(text: Texts.videos),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Tab content with dynamic height
                      IndexedStack(
                        index: _tabController.index,
                        children: [
                          _buildSpecificationsTab(),
                          _buildUsageGuideTab(),
                          _buildVideosTab(),
                        ],
                      ),

                      const SizedBox(height: 45),

                      // Request Product Button
                      AppFilledBtn(
                        btnText: Texts.requestProduct,
                        onPressed: _navigateToRequestPrices,
                        isFullWidth: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
