import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NoticiasScreen extends StatefulWidget {
  const NoticiasScreen({super.key});

  @override
  _NoticiasScreenState createState() => _NoticiasScreenState();
}

class _NoticiasScreenState extends State<NoticiasScreen> {
  List<dynamic> noticias = [];

  @override
  void initState() {
    super.initState();
    _fetchNoticias();
  }

  Future<void> _fetchNoticias() async {
    final response = await http
        .get(Uri.parse('https://adamix.net/defensa_civil/def/noticias.php'));

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['exito'] == true) {
        if (responseData['datos'] != null) {
          setState(() {
            noticias = responseData['datos'];
          });
        } else {
          throw Exception('No se encontraron noticias en la respuesta');
        }
      } else {
        throw Exception('La solicitud de la API no fue exitosa');
      }
    } else {
      throw Exception('Failed to load noticias');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: noticias.length,
        itemBuilder: (context, index) {
          final noticia = noticias[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Text(
                  noticia['titulo'] ?? 'Sin título',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    noticia['contenido'] ?? 'Sin descripción',
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
