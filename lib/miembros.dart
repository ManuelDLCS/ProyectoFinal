import 'package:flutter/material.dart';

class MiembrosScreen extends StatelessWidget {
  const MiembrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Miembros'),
      ),
      body: const Center(
        child: Text('Pantalla de Miembros'),
      ),
    );
  }
}
