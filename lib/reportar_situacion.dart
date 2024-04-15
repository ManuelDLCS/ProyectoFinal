import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ReportarSituacionScreen extends StatefulWidget {
  @override
  _ReportarSituacionScreenState createState() =>
      _ReportarSituacionScreenState();
}

class _ReportarSituacionScreenState extends State<ReportarSituacionScreen> {
  XFile? _image;
  TextEditingController _tituloController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();
  double _latitud = 0.0;
  double _longitud = 0.0;

  // Función para seleccionar una imagen de la galería
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedImage;
    });
  }

  // Función para reportar la situación
  Future<void> _reportarSituacion() async {
    if (_image == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Debes seleccionar una imagen.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final bytes = await _image!.readAsBytes();
    String base64Image = base64Encode(bytes);

    final Map<String, dynamic> data = {
      'titulo': _tituloController.text,
      'descripcion': _descripcionController.text,
      'foto': base64Image,
      'latitud': _latitud.toString(),
      'longitud': _longitud.toString(),
    };

    final response = await http.post(
      Uri.parse('https://adamix.net/defensa_civil/def/nueva_situacion.php'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Éxito'),
          content: Text('Situación reportada correctamente.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Después de cerrar el diálogo, actualizar las situaciones llamando a _fetchSituaciones()
                _fetchSituaciones();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Ocurrió un error al reportar la situación.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  // Función para cargar las situaciones en la pantalla de "Mis Situaciones"
  Future<void> _fetchSituaciones() async {
    // Lógica para cargar las situaciones
    // Aquí deberías implementar la lógica para cargar las situaciones desde la API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reportar Situación'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _tituloController,
              decoration:
                  InputDecoration(labelText: 'Título del evento o situación'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descripcionController,
              decoration: InputDecoration(
                  labelText: 'Descripción completa de lo ocurrido'),
              maxLines: null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Seleccionar Imagen'),
            ),
            SizedBox(height: 20),
            _image != null ? Image.file(File(_image!.path)) : Container(),
            SizedBox(height: 20),
            Text('Ubicación Geográfica:'),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Latitud'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) =>
                        _latitud = double.tryParse(value) ?? 0.0,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Longitud'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) =>
                        _longitud = double.tryParse(value) ?? 0.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _reportarSituacion,
              child: Text('Reportar Situación'),
            ),
          ],
        ),
      ),
    );
  }
}
