import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Defensa Civil',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Defensa Civil',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.orange,
        ),
        drawer: const NavBar(),
        body: const Center(
          child: Text('Contenido principal aquí'),
        ),
      ),
    );
  }
}

class Noticia {
  final String titulo;
  final String descripcion;
  final String fecha;

  Noticia(
      {required this.titulo, required this.descripcion, required this.fecha});

  factory Noticia.fromJson(Map<String, dynamic> json) {
    return Noticia(
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      fecha: json['fecha'],
    );
  }
}

// modelo de Video
class Video {
  final String titulo;
  final String url;

  Video({required this.titulo, required this.url});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      titulo: json['titulo'],
      url: json['url'],
    );
  }
}

Future<List<Noticia>> fetchNoticias() async {
  final response =
      await http.get(Uri.parse('https://adamix.net/defensa_civil/noticias'));
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => Noticia.fromJson(item)).toList();
  } else {
    throw Exception('Error al cargar las noticias');
  }
}

Future<List<Video>> fetchVideos() async {
  final response =
      await http.get(Uri.parse('https://adamix.net/defensa_civil/videos'));
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => Video.fromJson(item)).toList();
  } else {
    throw Exception('Error al cargar los videos');
  }
}
