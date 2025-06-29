import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/providers/division_provider.dart';
import 'package:sahary_united_company_for_powers/routes.dart';
import 'package:sahary_united_company_for_powers/widgets/partition_card.dart';
import 'package:sahary_united_company_for_powers/widgets/scrollable_grid_view.dart';

class Divisions extends ConsumerStatefulWidget {
  const Divisions({super.key});

  @override
  ConsumerState<Divisions> createState() => _DivisionsState();
}

class _DivisionsState extends ConsumerState<Divisions> {
  @override
  Widget build(BuildContext context) {
    final divisionsState = ref.watch(divisionsProvider);

    return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: divisionsState.when(
        data: (divisions) {
          final List<Widget> divisionsWidgets = divisions
              .map(
                (division) => PartitionCard(
                  imageUrl: division.image ?? '',
                  text: division.name,
                  showInternalShadow: true,
                  action: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(
                      AppRoutes.departmentScreen,
                      arguments: {
                        'id': division.id,
                        'title': division.name,
                        'divisionName': division.name,
                      },
                    );
                  },
                ),
              )
              .toList();

          return ScrollableGridView(children: divisionsWidgets);
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text(
                Texts.divisionsError,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(divisionsProvider.notifier).fetchDivisions();
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