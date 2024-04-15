import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proyecto_final/token.dart'; // Asegúrate de que la ruta del import sea correcta

class CambiarClaveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cambiar Contraseña'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: CambiarClaveForm(),
      ),
    );
  }
}

class CambiarClaveForm extends StatefulWidget {
  @override
  _CambiarClaveFormState createState() => _CambiarClaveFormState();
}

class _CambiarClaveFormState extends State<CambiarClaveForm> {
  final _formKey = GlobalKey<FormState>();
  late String _oldPassword;
  late String _newPassword;
  String? _token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  void _loadToken() {
    final token = TokenApi();
    _token = token.token;
  }

  Future<void> _cambiarClave() async {
    if (_token == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Token no disponible'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    final url =
        Uri.parse('https://adamix.net/defensa_civil/def/cambiar_clave.php');
    final response = await http.post(url, body: {
      'token': _token!,
      'clave_anterior': _oldPassword,
      'clave_nueva': _newPassword,
    });

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final bool success = responseData['exito'];
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Contraseña cambiada exitosamente'),
          backgroundColor: Colors.green,
        ));
      } else {
        final String errorMessage = responseData['mensaje'];
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      print('Error al cambiar la contraseña: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Contraseña Anterior',
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu contraseña anterior';
              }
              return null;
            },
            onSaved: (value) {
              _oldPassword = value!;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Nueva Contraseña',
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu nueva contraseña';
              }
              return null;
            },
            onSaved: (value) {
              _newPassword = value!;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                _cambiarClave();
              }
            },
            child: Text('Cambiar Contraseña'),
          ),
        ],
      ),
    );
  }
}
