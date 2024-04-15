import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_final/clave.dart';
import 'dart:convert';
import 'package:proyecto_final/main.dart';
import 'package:proyecto_final/userdata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccederScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late String _username;
  late String _password;

  Future<void> _iniciarSesion() async {
    final url =
        Uri.parse('https://adamix.net/defensa_civil/def/iniciar_sesion.php');
    final response = await http.post(url, body: {
      'cedula': _username,
      'clave': _password,
    });

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final bool success = responseData['exito'];
      if (success) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        if (responseData.containsKey('datos')) {
          final datos = responseData['datos'];
          if (datos is Map<String, dynamic>) {
            UserData.correo = datos['correo'];
            UserData.clave = datos['clave'];
            if (datos.containsKey('token')) {
              UserData.token = datos['token'];
            }
          }
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      } else {
        final String errorMessage = responseData['mensaje'];
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      print('Error en el inicio de sesión: ${response.body}');
    }
  }

  void _navigateToChangePassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CambiarClaveScreen()),
    );
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
              labelText: 'Correo',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu nombre de usuario';
              }
              return null;
            },
            onSaved: (value) {
              _username = value!;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Contraseña',
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu contraseña';
              }
              return null;
            },
            onSaved: (value) {
              _password = value!;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                _iniciarSesion();
              }
            },
            child: Text('Iniciar sesión'),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: _navigateToChangePassword,
            child: Text('¿Olvidaste tu contraseña?'),
          ),
        ],
      ),
    );
  }
}
