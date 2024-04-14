import 'package:flutter/material.dart';

class AcercaDe {
  final String foto;
  final String nombre;
  final String numeroTelefono;
  final String correo;

  AcercaDe({
    required this.foto,
    required this.nombre,
    required this.numeroTelefono,
    required this.correo,
  });
}

class DetallesPersonaScreen extends StatelessWidget {
  final AcercaDe persona;
  final String backgroundImage;

  const DetallesPersonaScreen(
      {super.key, required this.persona, required this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles',
            style: TextStyle(
                color: Colors
                    .white)), // Establecer el color del texto en la barra de aplicaciones
        backgroundColor: Colors.orange,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Image.asset(
            backgroundImage,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(persona.foto),
                  radius: 80,
                ),
                const SizedBox(height: 20),
                Text(
                  persona.nombre,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text('Teléfono: ${persona.numeroTelefono}',
                    style: const TextStyle(color: Colors.white)),
                Text('Correo: ${persona.correo}',
                    style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AcercaDeScreen extends StatelessWidget {
  final List<AcercaDe> personas = [
    AcercaDe(
      foto: 'assets/dariel.jpeg',
      nombre: 'Dariel Restituyo',
      numeroTelefono: '849-710-3318',
      correo: 'darielrestituyo@hotmail.com',
    ),
    AcercaDe(
      foto: 'assets/Manuelito.jpg',
      nombre: 'Manuel De la Cruz',
      numeroTelefono: '829-661-5050',
      correo: 'mdelacruzsolano2003@gmail.com',
    ),
    AcercaDe(
      foto: 'assets/adrian.jpeg',
      nombre: 'Adrián Estévez',
      numeroTelefono: '829-570-0003',
      correo: 'adrianestevezlol@gmail.com',
    ),
    AcercaDe(
      foto: 'assets/julio.jpeg',
      nombre: 'Julio Carrillo',
      numeroTelefono: '849-206-2655',
      correo: 'jeacn123@gmail.com',
    ),
    AcercaDe(
      foto: 'assets/roberto.jpeg',
      nombre: 'Roberto Cuevas',
      numeroTelefono: '809-698-1890',
      correo: 'robel970914@gmail.com',
    ),
  ];

  AcercaDeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Acerca De',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/compu.gif',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          ListView.builder(
            itemCount: personas.length,
            itemBuilder: (context, index) {
              final persona = personas[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetallesPersonaScreen(
                        persona: persona,
                        backgroundImage: 'assets/compu.gif',
                      ),
                    ),
                  );
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(persona.foto),
                  ),
                  title: Text(
                    persona.nombre,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Teléfono: ${persona.numeroTelefono}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Correo: ${persona.correo}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
