import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Map<String, dynamic> userData; // Recibe los datos del usuario autenticado

  const HomeScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Row(
          children: [
            // Menú desplegable (a la izquierda de "Bienvenido")
            IconButton(
              icon: Icon(Icons.menu, size: 28, color: Colors.white),
              onPressed: () {
                // Mostrar menú desplegable como un modal o menú
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Profesores'),
                          onTap: () {
                            Navigator.pop(context);
                            // Acción para Profesores
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.school),
                          title: Text('Oferta académica'),
                          onTap: () {
                            Navigator.pop(context);
                            // Acción para Oferta académica
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.share),
                          title: Text('Redes sociales'),
                          onTap: () {
                            Navigator.pop(context);
                            // Acción para Redes sociales
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.info),
                          title: Text('Más información'),
                          onTap: () {
                            Navigator.pop(context);
                            // Acción para Más información
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            SizedBox(width: 8), // Espacio entre el menú y el texto "Bienvenido"
            Text(
              'Bienvenido',
              style: TextStyle(
                fontSize: 24, // Tamaño del texto
                color: Colors.white, // Color del texto
                fontWeight: FontWeight.bold, // Negrita
              ),
            ),
          ],
        ),
        actions: [
          // Foto de perfil en la esquina superior derecha
          IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo_escom.png'), // Reemplaza con la ruta correcta de la imagen
            ),
            onPressed: () {
              // Mostrar información del usuario en un diálogo
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Mi información'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Nombre: ${userData['nombre'] ?? 'Sin información'}'),
                        Text('Primer Apellido: ${userData['primerApe'] ?? 'Sin información'}'),
                        Text('Segundo Apellido: ${userData['segundoApe'] ?? 'Sin información'}'),
                        Text('Boleta: ${userData['boleta'] ?? 'Sin información'}'),
                        Text('CURP: ${userData['curp'] ?? 'Sin información'}'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cerrar'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
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
