import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_final/token.dart';

class NoticiasEspecificasScreen extends StatefulWidget {
  const NoticiasEspecificasScreen({Key? key}) : super(key: key);

  @override
  _NoticiasEspecificasScreenState createState() =>
      _NoticiasEspecificasScreenState();
}

class _NoticiasEspecificasScreenState extends State<NoticiasEspecificasScreen> {
  List<dynamic> noticiasEspecificas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNoticiasEspecificas();
  }

  Future<void> _fetchNoticiasEspecificas() async {
    final token = TokenApi();
    String? yourAuthToken = token.token;

    final response = await http.post(
        Uri.parse(
            'https://adamix.net/defensa_civil/def/noticias_especificas.php'),
        body: {'token': yourAuthToken});

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['exito']) {
        setState(() {
          noticiasEspecificas = responseData['datos'];
          isLoading = false;
        });
      } else {
        throw Exception(
            'La solicitud de la API no fue exitosa: ${responseData['mensaje']}');
      }
    } else {
      throw Exception(
          'Failed to load noticias especificas with status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias Específicas'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: noticiasEspecificas.length,
              itemBuilder: (context, index) {
                final noticia = noticiasEspecificas[index];
                return ListTile(
                  title: Text(noticia['titulo']),
                  subtitle: Text(noticia['contenido']),
                );
              },
            ),
    );
  }
}
