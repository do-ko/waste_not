import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditAccountView extends ConsumerWidget {
  const EditAccountView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(title: const Text('Edit account')),
        body: const Placeholder());
  }
}
