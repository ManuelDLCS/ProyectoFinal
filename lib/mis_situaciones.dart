import 'package:flutter/material.dart';

class MisSituracionesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Situaciones'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'Hola',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
