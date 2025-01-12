import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Para Firestore
import 'package:proyecto_f/formato/downbar.dart';
import 'package:proyecto_f/formato/upbar.dart';
import 'home_screen.dart'; // Página a la que se navega al hacer login

class LoginScreen extends StatelessWidget {
  final TextEditingController boletaController = TextEditingController();
  final TextEditingController curpController = TextEditingController();

  LoginScreen({super.key});

  // Lógica de autenticación personalizada con Firestore
  Future<void> loginUser(BuildContext context) async {
    try {
      // Obtén los valores ingresados
      String boleta = boletaController.text.trim();
      String curp = curpController.text.trim();

      if (boleta.isEmpty || curp.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, ingresa ambos campos')),
        );
        return;
      }

      // Consulta en Firestore
      final query = await FirebaseFirestore.instance
          .collection('alumnos') // Cambia al nombre de tu colección en Firestore
          .where('boleta', isEqualTo: boleta)
          .where('curp', isEqualTo: curp)
          .get();

      if (query.docs.isNotEmpty) {
        // Usuario autenticado
        final userData = query.docs.first.data(); // Datos del usuario
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Inicio de sesión exitoso')),
        );

        // Navegar a la siguiente pantalla
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(userData: userData),
          ),
        );
      } else {
        // Usuario no encontrado
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credenciales incorrectas')),
        );
      }
    } catch (e) {
      // Manejo de errores
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Barrasup(title: 'Iniciar Sesión'), // Llamamos al AppBar de Barrasup
      drawer: const DrawerMenu(),  // Menú desplegable izquierdo
      endDrawer: const DrawerMenuRight(),  // Menú desplegable derecho
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              // Título "Iniciar sesión"
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Iniciar Sesión',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Campo de número de boleta
              TextField(
                controller: boletaController,
                decoration: const InputDecoration(
                  labelText: 'Número de Boleta',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Campo de CURP
              TextField(
                controller: curpController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'CURP',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Botón de inicio de sesión
              ElevatedButton(
                onPressed: () => loginUser(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Iniciar Sesión'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Barrainf(), // Usa Barrainf para la navegación en la parte inferior
    );
  }
}
