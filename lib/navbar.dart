import 'package:flutter/material.dart';
import 'package:proyecto_final/VolunteerListViewPage.dart';
import 'package:proyecto_final/acceder.dart';
import 'package:proyecto_final/acercade.dart';
import 'package:proyecto_final/albergues.dart';
import 'package:proyecto_final/historia.dart';
import 'package:proyecto_final/main.dart';
import 'package:proyecto_final/mapa_situacion.dart';
import 'package:proyecto_final/medidasPreventivas.dart';
import 'package:proyecto_final/miembros.dart';
import 'package:proyecto_final/mis_situaciones.dart';
import 'package:proyecto_final/noticia.dart';
import 'package:proyecto_final/noticias_especificas.dart';
import 'package:proyecto_final/reportar_situacion.dart';
import 'package:proyecto_final/servicio.dart';
import 'package:proyecto_final/video.dart';
import 'package:proyecto_final/volunterRegistration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: SharedPreferences.getInstance()
          .then((prefs) => prefs.getBool('isLoggedIn') ?? false),
      initialData: false,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          final bool isLoggedIn = snapshot.data!;
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
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.library_books_outlined),
                  title: const Text('Historia'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HistoriaScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.design_services_sharp),
                  title: const Text('Servicios'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ServicioScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text('Noticias'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NoticiasScreen()));
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
                      MaterialPageRoute(
                          builder: (context) => ShelterListPage()),
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
                      MaterialPageRoute(builder: (context) => MiembrosScreen()),
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
                if (isLoggedIn) ...[
                  Divider(), // Añade una línea divisoria
                  ListTile(
                    leading: const Icon(Icons.description),
                    title: const Text('Noticias Específicas'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NoticiasEspecificasScreen()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.add_alert),
                    title: const Text('Reportar Situación'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReportarSituacionScreen()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.view_list),
                    title: const Text('Mis Situaciones'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MisSituacionesScreen()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.map),
                    title: const Text('Mapa de Situaciones'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MapaSituacionScreen()));
                    },
                  ),
                ],
                if (!isLoggedIn)
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text('Acceder'),
                    tileColor: Colors.orange,
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccederScreen()),
                      );
                    },
                  ),
                if (isLoggedIn)
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Cerrar Sesión'),
                    tileColor: Colors.orange,
                    textColor: Colors.white,
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('isLoggedIn', false);
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
                    },
                  ),
              ],
            ),
          );
        }
      },
    );
  }
}
