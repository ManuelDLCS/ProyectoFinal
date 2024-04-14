class Volunteer {
  final int id;
  final String fullName;
  final String identification;
  final String contactInfo;
  final String address;
  final String educationLevel;
  final String availability;
  final String healthStatus;
  final String motivation;

  Volunteer({
    this.id = 0,
    required this.fullName,
    required this.identification,
    required this.contactInfo,
    required this.address,
    required this.educationLevel,
    required this.availability,
    required this.healthStatus,
    required this.motivation,
  });
Map<String, dynamic> toJson() {
  // Eliminar 'id' de toJson para asegurar que la base de datos maneje el autoincremento
  return {
    'fullName': fullName,
    'identification': identification,
    'contactInfo': contactInfo,
    'address': address,
    'educationLevel': educationLevel,
    'availability': availability,
    'healthStatus': healthStatus,
    'motivation': motivation,
  };
}


  static Volunteer fromJson(Map<String, dynamic> json) { 
    return Volunteer(
      id: json['id'],
      fullName: json['fullName'],
      identification: json['identification'],
      contactInfo: json['contactInfo'],
      address: json['address'],
      educationLevel: json['educationLevel'],
      availability: json['availability'],
      healthStatus: json['healthStatus'],
      motivation: json['motivation'],
    );
  }
}
