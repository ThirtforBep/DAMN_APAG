import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController boletaController = TextEditingController();
  final TextEditingController curpController = TextEditingController();

  // Lógica de autenticación personalizada con Firestore
  Future<void> loginUser(BuildContext context) async {
    try {
      // Obtén los valores ingresados
      String boleta = boletaController.text.trim();
      String curp = curpController.text.trim();

      if (boleta.isEmpty || curp.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor, ingresa ambos campos')),
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
          SnackBar(content: Text('Inicio de sesión exitoso')),
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
          SnackBar(content: Text('Credenciales incorrectas')),
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
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo_escom.png', height: 150), // Asegúrate de agregar esta imagen a tus assets
              SizedBox(height: 20),
              Text(
                'Bienvenido a ESCOM',
                style: TextStyle(fontSize: 24, color: Colors.blue.shade900),
              ),
              SizedBox(height: 20),
              TextField(
                controller: boletaController,
                decoration: InputDecoration(
                  labelText: 'Número de Boleta',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: curpController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'CURP',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => loginUser(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  foregroundColor: Colors.white,
                ),
                child: Text('Iniciar Sesión'),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Text('¿Nuevo usuario? Regístrate aquí'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
