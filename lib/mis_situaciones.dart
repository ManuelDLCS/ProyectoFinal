import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_final/token.dart';

class MisSituacionesScreen extends StatefulWidget {
  @override
  _MisSituacionesScreenState createState() => _MisSituacionesScreenState();
}

class _MisSituacionesScreenState extends State<MisSituacionesScreen> {
  List<dynamic> situaciones = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSituaciones();
  }

  Future<void> _fetchSituaciones() async {
    final token = TokenApi();
    String? yourAuthToken = token.token;
    final response = await http.post(
      Uri.parse('https://adamix.net/defensa_civil/def/situaciones.php'),
      body: {'token': yourAuthToken},
    );

    try {
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['exito']) {
          setState(() {
            situaciones = responseData['datos'];
            isLoading = false;
          });
        } else {
          // Mostrar mensaje de error
          print('Error: ${responseData['mensaje']}');
        }
      } else {
        // Manejar errores
        print(
            'Failed to fetch situaciones with status code: ${response.statusCode}');
      }
    } on Exception catch (e) {
      Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Situaciones'),
        backgroundColor: Colors.orange,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: situaciones.length,
              itemBuilder: (context, index) {
                final situacion = situaciones[index];
                return Card(
                  child: ListTile(
                    leading: Image.memory(base64Decode(situacion['foto'])),
                    title: Text(situacion['titulo']),
                    subtitle: Text(
                        'Reportado el: ${situacion['fecha']} - Estado: ${situacion['estado']}'),
                    isThreeLine: true,
                    onTap: () => _mostrarDetallesSituacion(situacion),
                  ),
                );
              },
            ),
    );
  }

  void _mostrarDetallesSituacion(dynamic situacion) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(situacion['titulo']),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Código: ${situacion['codigo']}'),
                Text('Fecha: ${situacion['fecha']}'),
                Text('Descripción: ${situacion['descripcion']}'),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  height: 200.0,
                  child: Image.memory(base64Decode(situacion['foto']),
                      fit: BoxFit.cover),
                ),
                Text('Estado: ${situacion['estado']}'),
                Text('Comentarios: ${situacion['comentarios'] ?? "Ninguno"}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar', style: TextStyle(color: Colors.orange)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
