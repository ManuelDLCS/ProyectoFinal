import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MiembrosScreen extends StatelessWidget {
  const MiembrosScreen({super.key});

  Future<List<dynamic>> fetchMembers() async {
    final response = await http
        .get(Uri.parse('https://adamix.net/defensa_civil/def/miembros.php'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['exito']) {
        return data[
            'datos']; // Usamos el campo 'datos' que contiene la lista de miembros
      } else {
        throw Exception('Failed to load data: ${data['mensaje']}');
      }
    } else {
      throw Exception('Failed to load members');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Miembros',
            style: TextStyle(color: Colors.white)), // Texto blanco
        backgroundColor: Colors.orange, // Color de fondo naranja
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchMembers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                var member = snapshot.data![index];
                return ListTile(
                  leading: member['foto'] != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(member['foto']),
                          radius: 30.0,
                        )
                      : null,
                  title: Text(member['nombre']),
                  subtitle: Text('Cargo: ${member['cargo']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
