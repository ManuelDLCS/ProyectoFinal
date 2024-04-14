import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'volunteer.dart';
import 'database_helper.dart';

class VolunteerRegistrationPage extends StatefulWidget {
  @override
  _VolunteerRegistrationPageState createState() => _VolunteerRegistrationPageState();
}

class _VolunteerRegistrationPageState extends State<VolunteerRegistrationPage> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _identificationController = TextEditingController();
  TextEditingController _contactInfoController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _educationLevelController = TextEditingController();
  TextEditingController _availabilityController = TextEditingController();
  TextEditingController _healthStatusController = TextEditingController();
  TextEditingController _motivationController = TextEditingController();

  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<void> _saveVolunteer() async {
    Volunteer volunteer = Volunteer(
      fullName: _fullNameController.text,
      identification: _identificationController.text,
      contactInfo: _contactInfoController.text,
      address: _addressController.text,
      educationLevel: _educationLevelController.text,
      availability: _availabilityController.text,
      healthStatus: _healthStatusController.text,
      motivation: _motivationController.text,
    );

    await _dbHelper.insertVolunteer(volunteer);
    _clearFields();
  }

  void _clearFields() {
    _fullNameController.clear();
    _identificationController.clear();
    _contactInfoController.clear();
    _addressController.clear();
    _educationLevelController.clear();
    _availabilityController.clear();
    _healthStatusController.clear();
    _motivationController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Voluntarios'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(labelText: 'Nombre completo'),
            ),
            TextField(
              controller: _identificationController,
              decoration: InputDecoration(labelText: 'Identificación'),
            ),
            TextField(
              controller: _contactInfoController,
              decoration: InputDecoration(labelText: 'Información de contacto'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Dirección'),
            ),
            TextField(
              controller: _educationLevelController,
              decoration: InputDecoration(labelText: 'Nivel de Educación'),
            ),
            TextField(
              controller: _availabilityController,
              decoration: InputDecoration(labelText: 'Disponibilidad'),
            ),
            TextField(
              controller: _healthStatusController,
              decoration: InputDecoration(labelText: 'Estado de Salud'),
            ),
            TextField(
              controller: _motivationController,
              decoration: InputDecoration(labelText: 'Motivación'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveVolunteer,
              child: Text('Guardar Voluntario'),
            ),
          ],
        ),
      ),
    );
  }
}
