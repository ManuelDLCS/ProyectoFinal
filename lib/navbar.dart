import 'package:flutter/material.dart';
import 'package:proyecto_final/main.dart';
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
            leading: const Icon(Icons.description),
            title: const Text('Noticias'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NoticiasScreen()),
              );
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
            leading: const Icon(Icons.description),
            title: const Text('Acerca de'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VideosScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('En mi Vida'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VideosScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.computer),
            title: const Text('Contrátame'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VideosScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
