import 'package:flutter/material.dart';

class MapaSituacionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa Situacion'),
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