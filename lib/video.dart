import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({Key? key}) : super(key: key);

  @override
  _VideosScreenState createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  late List<dynamic> videos = []; // Inicializa videos como una lista vacía

  @override
  void initState() {
    super.initState();
    _fetchVideos();
  }

  Future<void> _fetchVideos() async {
    final response = await http
        .get(Uri.parse('https://adamix.net/defensa_civil/def/videos.php'));

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['exito'] == true) {
        if (responseData['datos'] != null) {
          setState(() {
            videos = responseData['datos'];
          });
        } else {
          throw Exception('No se encontraron videos en la respuesta');
        }
      } else {
        throw Exception('La solicitud de la API no fue exitosa');
      }
    } else {
      throw Exception('Fallo al cargar los videos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Videos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
      ),
      body: videos
              .isEmpty // Verifica si la lista está vacía en lugar de si es null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                return ListTile(
                  title: Text(video['titulo'] ?? 'Sin título'),
                  subtitle: Text(video['descripcion'] ?? 'Sin descripción'),
                  onTap: () {
                    String videoId = video['link'];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => YoutubePlayer(
                          controller: YoutubePlayerController(
                            initialVideoId: videoId,
                            flags: const YoutubePlayerFlags(
                              autoPlay: true,
                              mute: false,
                            ),
                          ),
                          showVideoProgressIndicator: true,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
