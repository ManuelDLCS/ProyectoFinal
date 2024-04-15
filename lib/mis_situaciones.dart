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
    final url =
        Uri.parse('https://adamix.net/defensa_civil/def/situaciones.php');
    final response = await http.post(url, body: {
      'token': yourAuthToken,
    });

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['exito']) {
        setState(() {
          situaciones = responseData['datos'];
          isLoading = false;
        });
      } else {
        _showErrorDialog(responseData['mensaje']);
      }
    } else {
      _showErrorDialog(
          'Error al conectar con el servidor, código de estado: ${response.statusCode}');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
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
                    leading: situacion['foto'] != null
                        ? Image.network(situacion['foto'],
                            width: 50, height: 50, fit: BoxFit.cover)
                        : Icon(Icons.image_not_supported),
                    title: Text(situacion['titulo'] ?? 'Sin título'),
                    subtitle: Text(
                        'Reportado el ${situacion['fecha']} - Estado: ${situacion['estado']}'),
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
                situacion['foto'] != null
                    ? Image.network(situacion['foto'], fit: BoxFit.cover)
                    : Text('No hay imagen disponible'),
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
