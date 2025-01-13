import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Para Firestore
import 'package:proyecto_f/formato/downbar.dart';
import 'package:proyecto_f/formato/upbar.dart';

class DirectorioScreen extends StatefulWidget {
  const DirectorioScreen({super.key});

  @override
  _DirectorioScreenState createState() => _DirectorioScreenState();
}

class _DirectorioScreenState extends State<DirectorioScreen> {
  // Lista de profesores que se actualizará con los datos de Firestore
  late Future<List<Map<String, dynamic>>> _professors;

  @override
  void initState() {
    super.initState();
    _professors = getProfessors(); // Carga los profesores desde Firestore al inicio
  }

  // Función para obtener los datos de los jefes desde Firestore
  Future<List<Map<String, dynamic>>> getProfessors() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('jefes') // Colección de los jefes/profesores
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception('Error al cargar los datos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Barrasup(title: 'Directorio'), // AppBar con título
      drawer: const DrawerMenu(), // Menú desplegable izquierdo
      endDrawer: const DrawerMenuRight(), // Menú desplegable derecho
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _professors, // Obtén la lista de profesores
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay profesores disponibles.'));
            } else {
              final professors = snapshot.data!;
              return ListView.builder(
                itemCount: professors.length,
                itemBuilder: (context, index) {
                  final professor = professors[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.person), // Ícono de persona
                      title: Text('${professor['Nombre']} ${professor['PrimerApe']}${professor['SegundoApe']}'),
                      subtitle: Text('${professor['Academia']}'),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('${professor['Contacto']}'), // Información de contacto
                          const SizedBox(height: 5),
                        
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      bottomNavigationBar: const Barrainf(), // Barra de navegación inferior
    );
  }
}
