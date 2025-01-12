import 'package:flutter/material.dart';

class Barrasup extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const Barrasup({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          // Mostrar el menú desplegable a la izquierda (Drawer)
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () {
            // Mostrar el menú desplegable a la derecha (Drawer)
            Scaffold.of(context).openEndDrawer();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(  // Drawer para menú lateral izquierdo
      child: Container(
        color: Colors.white, // Fondo blanco para el menú
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,  // Fondo blanco para la cabecera del Drawer
              ),
              child: Align(
                alignment: Alignment.center,  // Centrar el texto "Menú de Navegación"
                child: Text(
                  'Menú de Navegación',
                  style: TextStyle(
                    color: Colors.blue,  // Letras azules
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio', style: TextStyle(color: Colors.blue)),  // Letras azules
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Directorio', style: TextStyle(color: Colors.blue)),  // Letras azules
              onTap: () {
                Navigator.pushNamed(context, '/directorio');  // Cambia la ruta según tu necesidad
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerMenuRight extends StatelessWidget {
  const DrawerMenuRight({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(  // Drawer para menú lateral derecho
      child: Container(
        color: Colors.white, // Fondo blanco para el menú
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,  // Fondo blanco para la cabecera del Drawer
              ),
              child: Align(
                alignment: Alignment.center,  // Centrar el texto "Menú de Navegación"
                child: Text(
                  'Menú de Usuario',
                  style: TextStyle(
                    color: Colors.blue,  // Letras azules
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Profesores', style: TextStyle(color: Colors.blue)),  // Letras azules
              onTap: () {
                Navigator.pushNamed(context, '/profesores'); // Cambia la ruta según tu necesidad
              },
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Iniciar sesión', style: TextStyle(color: Colors.blue)),  // Letras azules
              onTap: () {
                Navigator.pushNamed(context, '/screens/login_screen');  // Ruta correcta
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar Perfil', style: TextStyle(color: Colors.blue)),  // Letras azules
              onTap: () {
                Navigator.pushNamed(context, '/editar_perfil'); // Cambia la ruta según tu necesidad
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Cerrar Sesión', style: TextStyle(color: Colors.blue)),  // Letras azules
              onTap: () {
                Navigator.pushNamed(context, '/cerrar_sesion'); // Cambia la ruta según tu necesidad
              },
            ),
            
            
          ],
        ),
      ),
    );
  }
}
