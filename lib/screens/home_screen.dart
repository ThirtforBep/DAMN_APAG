import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'directorio_screen.dart';

class HomeScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  HomeScreen({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        centerTitle: true, // Centra el título en la AppBar
        title: Text(
          'ESCOM',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Builder(
          // Usamos Builder para obtener un contexto adecuado
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Abrir el Drawer del lado izquierdo
              },
            );
          },
        ),
        actions: [
          Builder(
            // Usamos Builder para abrir el endDrawer
            builder: (BuildContext context) {
              return IconButton(
                icon: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile_picture.jpg'),
                ),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer(); // Abrir el Drawer del lado derecho
                },
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        // Menú deslizable desde la izquierda
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue.shade900),
              child: Text(
                'Menú',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profesores'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DirectorioScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: Text('Oferta académica'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Redes sociales'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Más información'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        // Menú deslizable desde la derecha
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue.shade900),
              child: Text(
                'Mi información',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: Text('Nombre: ${userData['nombre'] ?? 'Sin información'}'),
            ),
            ListTile(
              title: Text('Primer Apellido: ${userData['primerApe'] ?? 'Sin información'}'),
            ),
            ListTile(
              title: Text('Segundo Apellido: ${userData['segundoApe'] ?? 'Sin información'}'),
            ),
            ListTile(
              title: Text('Boleta: ${userData['boleta'] ?? 'Sin información'}'),
            ),
            ListTile(
              title: Text('CURP: ${userData['curp'] ?? 'Sin información'}'),
            ),
            Divider(), // Línea divisoria para separar el contenido
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text(
                'Cerrar sesión',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false, // Elimina las rutas previas
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Hola, ${userData['nombre'] ?? 'Usuario'}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
