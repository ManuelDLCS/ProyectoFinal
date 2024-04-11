import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//Adrian Estevez | 2021-1263

class Shelter {
  final String city;
  final String building;
  final String coordinator;
  final String phone;
  final String capacity;
  final double latitude;
  final double longitude;

  Shelter({
    required this.city,
    required this.building,
    required this.coordinator,
    required this.phone,
    required this.capacity,
    required this.latitude,
    required this.longitude,
  });

  factory Shelter.fromJson(Map<String, dynamic> json) {
    return Shelter(
      city: json['ciudad'],
      building: json['edificio'],
      coordinator: json['coordinador'],
      phone: json['telefono'],
      capacity: json['capacidad'],
      // Intercambia latitud y longitud aquí
      latitude: double.parse(json['lng']),
      longitude: double.parse(json['lat']),
    );
  }
}

//Adrian Estevez | 2021-1263

class ShelterListPage extends StatefulWidget {
  @override
  _ShelterListPageState createState() => _ShelterListPageState();
}

class _ShelterListPageState extends State<ShelterListPage> {
  late Future<List<Shelter>> _sheltersFuture;

  @override
  void initState() {
    super.initState();
    _sheltersFuture = fetchShelters();
  }

  Future<List<Shelter>> fetchShelters() async {
    final response = await http
        .get(Uri.parse('https://adamix.net/defensa_civil/def/albergues.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['datos'];
      return data.map((shelterData) => Shelter.fromJson(shelterData)).toList();
    } else {
      throw Exception('Failed to load shelters');
    }
  }

  //Adrian Estevez | 2021-1263

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albergues'),
      ),
      body: FutureBuilder<List<Shelter>>(
        future: _sheltersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Shelter> shelters = snapshot.data!;
            return ListView.builder(
              itemCount: shelters.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(shelters[index].building),
                  subtitle: Text(shelters[index].city),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ShelterDetailsPage(shelter: shelters[index]),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ShelterDetailsPage extends StatelessWidget {
  final Shelter shelter;

  ShelterDetailsPage({required this.shelter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shelter.building),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('City: ${shelter.city}'),
            SizedBox(height: 8),
            Text('Coordinator: ${shelter.coordinator}'),
            SizedBox(height: 8),
            Text('Phone: ${shelter.phone}'),
            SizedBox(height: 8),
            Text('Capacity: ${shelter.capacity}'),
            SizedBox(height: 8),
            Text('Latitude: ${shelter.latitude}'),
            SizedBox(height: 8),
            Text('Longitude: ${shelter.longitude}'),
            SizedBox(height: 16),
            Expanded(
              child: MapWidget(
                initialPosition: LatLng(shelter.latitude, shelter.longitude),
                city: shelter.city,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Adrian Estevez | 2021-1263

class MapWidget extends StatefulWidget {
  final LatLng initialPosition;
  final String city;

  MapWidget({required this.initialPosition, required this.city});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController _controller;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: widget.initialPosition,
        zoom: 15,
      ),
      onMapCreated: (controller) {
        setState(() {
          _controller = controller;
        });
      },
      markers: {
        Marker(
          markerId: MarkerId('shelter_marker'),
          position: widget.initialPosition,
          infoWindow: InfoWindow(
            title: 'Shelter',
            snippet: 'City: ${widget.city}',
          ),
        ),
      },
    );
  }
}


//Adrian Estevez | 2021-1263