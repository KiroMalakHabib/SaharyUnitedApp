import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/providers/partners_provider.dart';
import 'package:sahary_united_company_for_powers/screens/drawerScreens/drawer_screens_container.dart';
import 'package:sahary_united_company_for_powers/widgets/scrollable_grid_view.dart';
import 'package:sahary_united_company_for_powers/widgets/image_card.dart';

class Partners extends ConsumerWidget {
  const Partners({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partnersAsync = ref.watch(partnersProvider);

    return DrawerScreensContainer(
      title: Texts.partners,
      child: partnersAsync.when(
        data: (partners) {
          final List<Widget> partnerWidgets =
              partners
                  .map((partner) => ImageCard(imageUrl: partner.imageUrl))
                  .toList();
          return ScrollableGridView(children: partnerWidgets);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    Texts.partnersError,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(partnersProvider.notifier).refresh();
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
