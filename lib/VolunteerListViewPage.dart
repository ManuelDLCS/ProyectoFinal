import 'package:flutter/material.dart';
import 'dart:io';
import 'volunteer.dart';
import 'database_helper.dart';

class VolunteerListViewPage extends StatefulWidget {
  @override
  _VolunteerListViewPageState createState() => _VolunteerListViewPageState();
}

class _VolunteerListViewPageState extends State<VolunteerListViewPage> {
  late List<Volunteer> volunteers = [];

  @override
  void initState() {
    super.initState();
    _loadVolunteers();
  }

  Future<void> _loadVolunteers() async {
    final dbVolunteers = await DatabaseHelper.instance.getVolunteers();
    setState(() {
      volunteers = dbVolunteers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Voluntarios'),
      ),
      body: ListView.builder(
        itemCount: volunteers.length,
        itemBuilder: (context, index) {
          final volunteer = volunteers[index];
          return ListTile(
            title: Text(volunteer.fullName),
            subtitle: Text("${volunteer.educationLevel} - ${volunteer.availability}"),
            leading: Icon(Icons.person),
            trailing: IconButton(
              icon: Icon(Icons.info),
              onPressed: () => _showVolunteerDetails(context, volunteer),
            ),
            onTap: () => _showVolunteerDetails(context, volunteer),
          );
        },
      ),
    );
  }

  void _showVolunteerDetails(BuildContext context, Volunteer volunteer) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(volunteer.fullName),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Identificación: ${volunteer.identification}'),
                Text('Contacto: ${volunteer.contactInfo}'),
                Text('Dirección: ${volunteer.address}'),
                Text('Nivel de Educación: ${volunteer.educationLevel}'),
                Text('Disponibilidad: ${volunteer.availability}'),
                Text('Estado de Salud: ${volunteer.healthStatus}'),
                Text('Motivación: ${volunteer.motivation}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
