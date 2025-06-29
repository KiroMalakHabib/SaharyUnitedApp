import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahary_united_company_for_powers/repositories/contact_repo.dart';

class ContactNotifier extends StateNotifier<AsyncValue<void>> {
  final ContactRepository contactRepository;
  
  ContactNotifier(this.contactRepository) : super(const AsyncValue.data(null));

  Future<bool> submitContactMessage({
    required String name,
    required String email,
    required String phone,
    required String message,
  }) async {
    try {
      state = const AsyncValue.loading();
      
      final success = await contactRepository.submitContactMessage(
        name: name,
        email: email,
        phone: phone,
        message: message,
      );
      
      state = const AsyncValue.data(null);
      return success;
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
      rethrow;
    }
  }
}

// Providers
final contactRepositoryProvider = Provider((ref) => ContactRepository());

final contactProvider = StateNotifierProvider<ContactNotifier, AsyncValue<void>>((ref) {
  final contactRepository = ref.watch(contactRepositoryProvider);
  return ContactNotifier(contactRepository);
});

// Loading state provider for form submission
final isSubmittingContactProvider = StateProvider<bool>((ref) => false);