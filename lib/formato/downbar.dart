import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Para lanzar URLs
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Para Instagram y Map

class Barrainf extends StatelessWidget {
  const Barrainf({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.facebook),
          label: 'Facebook',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.mapMarkedAlt),  // Usando FaIcon para Map
          label: 'Mapa',
        ),
      ],
      selectedItemColor: Colors.black,  // Color para el ícono y texto seleccionado
      unselectedItemColor: Colors.black,  // Color para los íconos no seleccionados
      onTap: (index) async {
        if (index == 0) {
          // Redirigir a Facebook
          final url = Uri.parse('https://www.facebook.com/escomipnmx/?ref=embed_page');
          if (await canLaunch(url.toString())) {  // Verifica si la URL puede ser lanzada
            await launch(url.toString(), forceWebView: false, forceSafariVC: false);  // Abre la URL fuera de la app
          } else {
            debugPrint('No se puede abrir la URL');
          }
        } else if (index == 1) {
          // Redirigir a Home
          Navigator.pushNamed(context, '/');
        } else if (index == 2) {
          // Redirigir a map_screen.dart
          Navigator.pushNamed(context, '/opciones/map_screen');  // Usa la ruta registrada
        }
      },
    );
  }
}
