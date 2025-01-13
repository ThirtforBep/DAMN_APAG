import 'package:flutter/material.dart';
import 'package:proyecto_f/formato/downbar.dart';
import 'package:proyecto_f/formato/upbar.dart';
import 'planes_academicos/pa_isc.dart';
import 'planes_academicos/pa_iia.dart';
import 'planes_academicos/pa_lcd.dart';
import 'planes_academicos/pa_mcscm.dart';
import 'planes_academicos/pa_mciia.dart';
import 'planes_academicos/pa_mccd.dart';
import 'package:proyecto_f/screens/map_screen.dart'; // Asegúrate de que la ruta esté correcta
import 'package:proyecto_f/screens/login_screen.dart';
import 'package:proyecto_f/screens/directorio_screen.dart';
import 'package:firebase_core/firebase_core.dart'; // Importa Firebase
import 'package:proyecto_f/screens/facebook_page.dart'; // Importa FacebookPage correctamente
import 'package:url_launcher/url_launcher.dart';

void main() async {
  // Inicializar Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        // Rutas
        '/': (context) => const HomePage(),
        '/pa_isc': (context) => const ISCPage(), // Ruta hacia la pantalla de ISC
        '/pa_iia': (context) => const IIAPage(), // Ruta hacia la pantalla de IIA
        '/pa_lcd': (context) => const LCDPage(), // Ruta hacia la pantalla de LCD
        '/pa_mcscm': (context) => const MCSCMPage(), // Ruta hacia la pantalla de MCSCM
        '/pa_mciia': (context) => const MCIIAPage(), // Ruta hacia la pantalla de MCIIA
        '/pa_mccd': (context) => const MCCDPage(), // Ruta hacia la pantalla de MCCD
        '/screens/map_screen': (context) => const MapScreen(),
        '/screens/login_screen': (context) => LoginScreen(), // Asegúrate de agregar esta ruta
        '/screens/directorio_screen': (context) => DirectorioScreen(), // Asegúrate de agregar esta ruta
        '/facebook': (context) => const FacebookPage(), // Ruta para la página de Facebook
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Barrasup(title: 'ESCOM'), // Llamamos al AppBar de Barrasup 
      drawer: const DrawerMenu(),  // Menú desplegable izquierdo
      endDrawer: const DrawerMenuRight(),  // Menú desplegable derecho
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Scroll de imágenes superiores
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildImage('img/escom1.jpg'),
                  _buildImage('img/escom2.jpg'),
                  _buildImage('img/escom3.jpg'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Título "Escuela Superior de Cómputo"
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Escuela Superior de Cómputo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Descripción
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "La Escuela Superior de Cómputo (ESCOM) es una institución pública mexicana de educación superior perteneciente al Instituto Politécnico Nacional que inició sus actividades académicas en 1993...",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14),
              ),
            ),

            const SizedBox(height: 20),

            // Título "Oferta Educativa"
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Oferta Educativa',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Imágenes de estrellas con enlaces
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: const EdgeInsets.all(16),
              children: [
                _buildIconLink(
                  Icons.computer,
                  'ISC',
                  () {
                    Navigator.pushNamed(context, '/pa_isc'); // Navega a ISCPage
                  },
                ),
                _buildIconLink(
                  Icons.voice_chat,
                  'IIA',
                  () {
                    Navigator.pushNamed(context, '/pa_iia'); // Navega a IIAPage
                  },
                ),
                _buildIconLink(
                  Icons.data_usage,
                  'LCD',
                  () {
                    Navigator.pushNamed(context, '/pa_lcd'); // Navega a LCDPage
                  },
                ),
                _buildIconLink(
                  Icons.cloud,
                  'MCSCM',
                  () {
                    Navigator.pushNamed(context, '/pa_mcscm'); // Navega a MCSCMPage
                  },
                ),
                _buildIconLink(
                  Icons.code,
                  'MCIIA',
                  () {
                    Navigator.pushNamed(context, '/pa_mciia'); // Navega a MCIIAPage
                  },
                ),
                _buildIconLink(
                  Icons.storage,
                  'MCCD',
                  () {
                    Navigator.pushNamed(context, '/pa_mccd'); // Navega a MCCDPage
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Barrainf(),  // Usa Barrainf para la navegación en la parte inferior
    );
  }

  Widget _buildImage(String path) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        path,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildIconLink(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 50,
            color: Colors.black,
          ),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

