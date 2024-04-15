import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'navbar.dart';
import 'package:proyecto_final/acceder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Defensa Civil',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Defensa Civil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
      ),
      drawer: const NavBar(),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Lo mas destacado',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          CarouselSlider(
            options: CarouselOptions(
              height: 400.0,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            items: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: AssetImage('assets/imagen1.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Center(
                  child: Text(
                    'La Defensa Civil Dominicana fue reconocida como la tercera institución del Estado con mejor desempeño ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage('assets/imagen2.jpg'),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Reconocimiento por el Día Nacional de la Defensa Civil',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage('assets/imagen3.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Center(
                  child: Text(
                    '17 de junio se celebro el aniversario de la defensa civil',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Noticia {
  final String titulo;
  final String descripcion;
  final String fecha;

  Noticia({
    required this.titulo,
    required this.descripcion,
    required this.fecha,
  });

  factory Noticia.fromJson(Map<String, dynamic> json) {
    return Noticia(
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      fecha: json['fecha'],
    );
  }
}

class Video {
  final String titulo;
  final String url;

  Video({
    required this.titulo,
    required this.url,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      titulo: json['titulo'],
      url: json['url'],
    );
  }
}

class Albergue {
  final String ciudad;
  final String edificio;
  final String coordinador;
  final String telefono;
  final String capacidad;
  final double latitud;
  final double longitud;

  Albergue({
    required this.ciudad,
    required this.edificio,
    required this.coordinador,
    required this.telefono,
    required this.capacidad,
    required this.latitud,
    required this.longitud,
  });

  factory Albergue.fromJson(Map<String, dynamic> json) {
    return Albergue(
      ciudad: json['ciudad'],
      edificio: json['edificio'],
      coordinador: json['coordinador'],
      telefono: json['telefono'],
      capacidad: json['capacidad'],
      latitud: double.parse(json['latitud']),
      longitud: double.parse(json['longitud']),
    );
  }
}

Future<List<Albergue>> fetchAlbergues() async {
  final response =
      await http.get(Uri.parse('https://adamix.net/defensa_civil/albergues'));
  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => Albergue.fromJson(item)).toList();
  } else {
    throw Exception('Error al cargar los albergues');
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
