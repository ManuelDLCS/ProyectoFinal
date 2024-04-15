import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:proyecto_final/token.dart';
import 'package:geolocator/geolocator.dart';

class ReportarSituacionScreen extends StatefulWidget {
  @override
  _ReportarSituacionScreenState createState() =>
      _ReportarSituacionScreenState();
}

class _ReportarSituacionScreenState extends State<ReportarSituacionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  File? _imagen;
  Position? _posicion;

  Future<void> _obtenerPosicion() async {
    bool servicioHabilitado;
    LocationPermission permiso;

    servicioHabilitado = await Geolocator.isLocationServiceEnabled();
    if (!servicioHabilitado) {
      return Future.error('Los servicios de ubicación están desactivados.');
    }

    permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
      if (permiso == LocationPermission.denied) {
        return Future.error('Permiso de ubicación denegado.');
      }
    }

    if (permiso == LocationPermission.deniedForever) {
      return Future.error('Permiso de ubicación denegado permanentemente.');
    }

    _posicion = await Geolocator.getCurrentPosition();
  }

  Future<void> _seleccionarImagen() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imagen = File(pickedFile.path);
      });
    }
  }

  Future<void> _reportarSituacion() async {
    if (_posicion == null || _imagen == null) {
      print('No se ha seleccionado imagen o ubicación.');
      return;
    } else {
      final bytes = await _imagen!.readAsBytes();
      String _base64Imagen = base64Encode(bytes);

      final token = TokenApi();
      String? yourAuthToken = token.token;
      final response = await http.post(
        Uri.parse('https://adamix.net/defensa_civil/def/nueva_situacion.php'),
        body: jsonEncode({
          'titulo': _tituloController.text,
          'descripcion': _descripcionController.text,
          'foto': _base64Imagen,
          'latitud': _posicion!.latitude.toString(),
          'longitud': _posicion!.longitude.toString(),
          'token': yourAuthToken
        }),
      );
    }
  }

  void _limpiarFormulario() {
    _tituloController.clear();
    _descripcionController.clear();
    setState(() {
      _imagen = null;
      _posicion = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reportar Situación'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _tituloController,
                  decoration: InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.orange),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _descripcionController,
                  decoration: InputDecoration(
                    labelText: 'Descripción',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.orange),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  maxLines: 5,
                ),
                SizedBox(height: 20),
                OutlinedButton.icon(
                  icon: Icon(Icons.camera_alt, color: Colors.orange),
                  label: Text('Seleccionar Imagen',
                      style: TextStyle(color: Colors.orange)),
                  onPressed: _seleccionarImagen,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.orange),
                  ),
                ),
                SizedBox(height: 20),
                OutlinedButton.icon(
                  icon: Icon(Icons.location_on, color: Colors.orange),
                  label: Text('Obtener Ubicación',
                      style: TextStyle(color: Colors.orange)),
                  onPressed: _obtenerPosicion,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.orange),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _reportarSituacion();
                      _limpiarFormulario();
                    }
                  },
                  child: Text('Reportar Situación'),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
