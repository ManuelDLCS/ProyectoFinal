import 'package:flutter/material.dart';

class Noticias_Especificas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias'),
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
