import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final textSizeProvider = StateNotifierProvider<TextSizeNotifier, double>((ref) {
  return TextSizeNotifier();
});

class TextSizeNotifier extends StateNotifier<double> {
  TextSizeNotifier() : super(1.0) {
    _loadTextSize();
  }

  // Load the text size from SharedPreferences
  Future<void> _loadTextSize() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTextSize = prefs.getDouble('textSize') ?? 1.0;
    state = savedTextSize;
  }

  // Save the selected text size to SharedPreferences
  Future<void> setTextSize(double newTextSize) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('textSize', newTextSize);
    state = newTextSize;
  }
}
