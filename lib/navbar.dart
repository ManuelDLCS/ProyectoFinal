import 'package:flutter/material.dart';
import 'package:proyecto_final/acercade.dart';
import 'package:proyecto_final/historia.dart';
import 'package:proyecto_final/main.dart';
import 'package:proyecto_final/miembros.dart';
import 'historia.dart';
import 'noticia.dart';
import 'video.dart';
import 'servicio.dart';
import 'volunterRegistration.dart';
import 'VolunteerListViewPage.dart';
import 'medidasPreventivas.dart';
import 'albergues.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.orange,
            ),
            accountName: const Text(
              'Defensa Civil',
              style: TextStyle(color: Colors.white),
            ),
            accountEmail: const Text(
              'MobileMasters',
              style: TextStyle(color: Colors.white),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset('assets/df.png', fit: BoxFit.cover),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.library_books_outlined),
            title: const Text('Historia'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoriaScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.design_services_sharp),
            title: const Text('Servicios'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ServicioScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Noticias'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NoticiasScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.video_collection),
            title: const Text('Galería de Videos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VideosScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Albergues'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShelterListPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shield),
            title: const Text('Medidas Preventivas'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => medidasPreventivas()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.supervised_user_circle_outlined),
            title: const Text('Miembros'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MiembrosScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Quiero ser Voluntario'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VolunteerRegistrationPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Lista de Voluntarios'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VolunteerListViewPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Acerca de'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AcercaDeScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
