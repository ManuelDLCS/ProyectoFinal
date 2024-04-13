import 'package:flutter/material.dart';

class HistoriaScreen extends StatelessWidget {
  const HistoriaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historia'),
        backgroundColor: Colors.deepPurple, // Cambia el color del AppBar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Puedes agregar una imagen que represente la historia o la entidad
            /*
            Image.asset(
              'assets/defensa_civil_history.jpg',
              fit: BoxFit.cover,
            ),*/
            const SizedBox(height: 20),
            // Título de la sección
            const Text(
              '¿Qué es la Defensa Civil?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'La Defensa Civil es una organización dedicada a la protección y asistencia de '
              'la población civil en situaciones de emergencia. Es fundamental en la respuesta '
              'a desastres naturales, calamidades y otros eventos que pongan en riesgo la '
              'seguridad pública.',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Evolución y Capacitación',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Desde su creación, la Defensa Civil ha evolucionado y se ha expandido para '
              'incluir la educación y capacitación de la población en medidas de prevención '
              'y respuesta ante emergencias, convirtiéndose en una pieza clave en la gestión '
              'de riesgos y desastres en múltiples países.',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
