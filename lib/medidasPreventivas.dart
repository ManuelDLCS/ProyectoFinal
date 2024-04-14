import 'package:flutter/material.dart';

class medidasPreventivas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medidas Preventivas en RD"),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: <Widget>[
          buildInfoCard(
            title: 'Preparación ante Huracanes',
            subtitle: 'Mantener un kit de emergencia, revisar y asegurar techos, ventanas y puertas, y conocer los refugios más cercanos.',
            icon: Icons.cloud_queue,
            imageUrl: 'https://example.com/image_huracanes.jpg',
          ),
          buildInfoCard(
            title: 'En caso de Terremotos',
            subtitle: 'Identificar zonas seguras dentro y fuera de la casa, practicar simulacros de evacuación y mantener objetos pesados en lugares bajos.',
            icon: Icons.landscape,
            imageUrl: 'https://example.com/image_terremotos.jpg',
          ),
          buildInfoCard(
            title: 'COVID-19: Medidas de Higiene',
            subtitle: 'Detalles sobre el lavado de manos, uso de gel desinfectante y más.',
            icon: Icons.local_hospital,
            imageUrl: 'https://example.com/image_covid.jpg',
          ),
          // Continúa agregando otros temas con su respectiva imagen
        ],
      ),
    );
  }

  Widget buildInfoCard({required String title, required String subtitle, required IconData icon, required String imageUrl}) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(icon, color: Colors.blueAccent),
            title: Text(title),
            subtitle: Text(subtitle),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network('https://repositorio.msp.gob.do/bitstream/handle/123456789/2134/planprevencion-huracan.jpg?sequence=3&isAllowed=y'),
          ),
        ],
      ),
    );
  }
}
