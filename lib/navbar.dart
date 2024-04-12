import 'package:flutter/material.dart';
import 'package:proyecto_final/historia.dart';
import 'package:proyecto_final/main.dart';
import 'package:proyecto_final/miembros.dart';
import 'historia.dart';
import 'noticia.dart';
import 'video.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              'Defensa Civil',
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: const Text(
              'MobileMasters',
              style: TextStyle(color: Colors.black),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/df.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/defensacivil.png',
                ),
                fit: BoxFit.cover,
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
            leading: const Icon(Icons.supervised_user_circle_outlined),
            title: const Text('Miembros'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MiembrosScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
