import 'package:flutter/material.dart';
import 'package:sahary_united_company_for_powers/services/toast_service.dart';

class ToastInitializer extends StatefulWidget {
  final Widget child;

  const ToastInitializer({super.key, required this.child});

  @override
  State<ToastInitializer> createState() => _ToastInitializerState();
}

class _ToastInitializerState extends State<ToastInitializer> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ToastService().init(context); // Ensures ToastService is initialized after the Overlay is available
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
