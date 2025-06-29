import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/providers/clients_provider.dart';
import 'package:sahary_united_company_for_powers/screens/drawerScreens/drawer_screens_container.dart';
import 'package:sahary_united_company_for_powers/widgets/image_card.dart';
import 'package:sahary_united_company_for_powers/widgets/scrollable_grid_view.dart';

class Clients extends ConsumerWidget {
  const Clients({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientsAsync = ref.watch(clientsProvider);

    return DrawerScreensContainer(
      title: Texts.clients,
      child: clientsAsync.when(
        data: (clients) {
          final List<Widget> clientWidgets =
              clients
                  .map((client) => ImageCard(imageUrl: client.imageUrl))
                  .toList();
          return ScrollableGridView(children: clientWidgets);
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
                      ref.read(clientsProvider.notifier).refresh();
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
