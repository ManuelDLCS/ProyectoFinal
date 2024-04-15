import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MisSituracionesScreen extends StatefulWidget {
  @override
  _MisSituracionesScreenState createState() => _MisSituracionesScreenState();
}

class _MisSituracionesScreenState extends State<MisSituracionesScreen> {
  List<Situacion> _situaciones = [];

  @override
  void initState() {
    super.initState();
    // Llamar a la función para cargar las situaciones al iniciar la pantalla
    _fetchSituaciones();
  }

  // Función para cargar las situaciones desde la API
  Future<void> _fetchSituaciones() async {
    try {
      // Hacer la solicitud HTTP para obtener las situaciones
      final response = await http.get(
        Uri.parse('https://adamix.net/defensa_civil/def/situaciones.php'),
        // No necesitamos un token para esta solicitud
      );

      if (response.statusCode == 200) {
        // Decodificar la respuesta JSON y actualizar la lista de situaciones
        final List<dynamic> data = jsonDecode(response.body)['datos'];
        setState(() {
          _situaciones = data.map((item) => Situacion.fromJson(item)).toList();
        });
      } else {
        // Si la solicitud falla, mostrar un mensaje de error
        throw Exception(
            'Error al cargar las situaciones: ${response.statusCode}');
      }
    } catch (error) {
      // Manejar cualquier error que ocurra durante la solicitud
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Situaciones'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: _situaciones.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _situaciones.length,
              itemBuilder: (context, index) {
                final situacion = _situaciones[index];
                return ListTile(
                  title: Text(situacion.titulo),
                  subtitle: Text(situacion.descripcion),
                  onTap: () {
                    // Navegar a la pantalla de detalles de la situación cuando se toca una situación
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SituacionDetalleScreen(situacion: situacion),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class Situacion {
  final String id;
  final String titulo;
  final String descripcion;
  final String fecha;
  final String estado;

  Situacion({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    required this.estado,
  });

  factory Situacion.fromJson(Map<String, dynamic> json) {
    return Situacion(
      id: json['id'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      fecha: json['fecha'],
      estado: json['estado'],
    );
  }
}

class SituacionDetalleScreen extends StatelessWidget {
  final Situacion situacion;

  SituacionDetalleScreen({required this.situacion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de la Situación'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Título: ${situacion.titulo}'),
            SizedBox(height: 8),
            Text('Descripción: ${situacion.descripcion}'),
            SizedBox(height: 8),
            Text('Fecha: ${situacion.fecha}'),
            SizedBox(height: 8),
            Text('Estado: ${situacion.estado}'),
          ],
        ),
      ),
    );
  }
}
