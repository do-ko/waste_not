import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProductView extends ConsumerWidget {
  const EditProductView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(title: const Text('Edit product')),
        body: const Placeholder());
  }
}
