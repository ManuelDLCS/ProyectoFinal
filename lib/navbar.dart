import 'package:flutter/material.dart';
import 'package:proyecto_final/main.dart';
import 'noticia.dart';
import 'video.dart';
import 'servicio.dart';
import 'volunterRegistration.dart'; // Asegúrate de que el nombre sea correcto
import 'VolunteerListViewPage.dart'; // Importación de la página de lista de voluntarios
import 'medidasPreventivas.dart'; // Asegúrate de que el nombre del archivo y la clase sean correctos

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Defensa Civil', style: TextStyle(color: Colors.black)),
            accountEmail: const Text('MobileMasters', style: TextStyle(color: Colors.black)),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset('assets/df.png', fit: BoxFit.cover),
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/defensacivil.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MyApp()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.design_services_sharp),
            title: const Text('Servicios'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ServicioScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Noticias'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NoticiasScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.video_collection),
            title: const Text('Galería de Videos'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => VideosScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.shield),
            title: const Text('Medidas Preventivas'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => medidasPreventivas()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Quiero ser Voluntario'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => VolunteerRegistrationPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Lista de Voluntarios'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => VolunteerListViewPage()));
            },
          ),
        ],
      ),
    );
  }
}
