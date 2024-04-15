import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proyecto_final/token.dart';

class MapaSituacionScreen extends StatefulWidget {
  @override
  _MapaSituacionScreenState createState() => _MapaSituacionScreenState();
}

class _MapaSituacionScreenState extends State<MapaSituacionScreen> {
  List<dynamic> situaciones = [];
  bool isLoading = true;
  late GoogleMapController mapController;

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

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['exito']) {
        setState(() {
          situaciones = responseData['datos'];
          isLoading = false;
        });
      } else {
        throw Exception(
            'La solicitud de la API no fue exitosa: ${responseData['mensaje']}');
      }
    } else {
      throw Exception(
          'Failed to load situaciones with status code: ${response.statusCode}');
    }
  }

  Set<Marker> _createMarkers() {
    return situaciones.map((situacion) {
      return Marker(
        markerId: MarkerId(situacion['id']),
        position: LatLng(
          double.parse(situacion['latitud']),
          double.parse(situacion['longitud']),
        ),
        infoWindow: InfoWindow(
          title: situacion['titulo'],
          snippet: situacion['descripcion'],
        ),
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de Situaciones'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(0.0, 0.0), // Coordenadas iniciales del mapa
                zoom: 2.0, // Zoom inicial
              ),
              markers: _createMarkers(),
            ),
    );
  }
}
