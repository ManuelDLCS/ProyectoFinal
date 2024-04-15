import 'package:flutter/material.dart';
import 'dart:convert';

class Servicio {
  final String id;
  final String nombre;
  final String descripcion;
  final String foto;

  Servicio({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.foto,
  });

  factory Servicio.fromJson(Map<String, dynamic> json) {
    return Servicio(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      foto: json['foto'],
    );
  }
}

class ServicioScreen extends StatelessWidget {
  final List<Servicio> servicios = [];

  @override
  Widget build(BuildContext context) {
    String jsonExample = '''
    {
        "exito": true,
        "datos": [
            {
                "id": "1",
                "nombre": "Técnica de Extracción Y Extricación Vehicular",
                "descripcion": "La Unidad de Extricación Vehicular entra en acción cuando hay accidentes de fuerte impacto, donde quedan personas atrapadas dentro de vehículos, utilizando herramientas hidráulicas, como cizalla de cortes, expansores (quijada de la vida), para facilitar la extracción de víctimas y proporcionar las condiciones para una oportuna atención pre hospitalaria.",
                "foto": "https://defensacivil.gob.do/images/thumbnails/images/publicaciones/Servicios/EXTRICACION_VEHICULAR-fit-1123x747.JPG"
            },
            {
                "id": "2",
                "nombre": "Salvamento Acuático",
                "descripcion": "La Unidad de Salvamento Acuático es un equipo especializado en búsqueda y rescate de víctimas en aguas rápidas (TREPI). Asimismo, cuenta con embarcaciones y buzos para ubicación y salvamento de personas en aguas profundas.",
                "foto": "https://defensacivil.gob.do/images/thumbnails/images/publicaciones/Servicios/Salvamento_Acuatico_opt-fit-1000x666.jpg"
            },
            {
                "id": "3",
                "nombre": "Atención Pre-hospitalaria",
                "descripcion": "La Defensa Civil cuenta con un equipo de médicos y técnicos en emergencia médicas que en caso de una emergencia brindan las primeras atenciones en la valorización de la escena, clasificación y estabilización de pacientes hasta que éstos son trasladados a un centro de salud. Además, este equipo realiza operativos médicos en distintas comunidades del país.",
                "foto": "https://defensacivil.gob.do/images/thumbnails/images/thumbnails/images/publicaciones/Servicios/Atencion_Prehospitalaria_opt-fit-399x267.jpeg"
            }
        ],
        "mensaje": ""
    }
    ''';

    Map<String, dynamic> data = jsonDecode(jsonExample);
    List<dynamic> serviciosJson = data['datos'];
    servicios.addAll(serviciosJson.map((json) => Servicio.fromJson(json)));

    return Scaffold(
      appBar: AppBar(
        title: Text('Servicios'),
      ),
      body: ListView.builder(
        itemCount: servicios.length,
        itemBuilder: (context, index) {
          final servicio = servicios[index];
          return ListTile(
            leading: Image.network(
              servicio.foto,
              width: 50,
              height: 50,
            ),
            title: Text(servicio.nombre),
            subtitle: Text(servicio.descripcion),
            onTap: () {},
          );
        },
      ),
    );
  }
}
