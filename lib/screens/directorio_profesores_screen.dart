import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DirectorioProfesScreen extends StatelessWidget {
  const DirectorioProfesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Directorio de Profesores',
        style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue.shade900,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Cambia el color aquí
          onPressed: () {
            Navigator.pop(context); // Vuelve a la pantalla anterior
          },
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('horarios_actualizado').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error al cargar los datos'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No hay datos disponibles'));
          }
          // Procesar los datos para evitar duplicados
          final profesores = <String, String>{}; // Map para evitar duplicados, usando el nombre como clave y academia como valor
          for (var doc in snapshot.data!.docs) {
            final data = doc.data() as Map<String, dynamic>;
            final profesor = data['Profesor asignado'] ?? '';
            final academia = data['Academia'] ?? '';
            if (profesor.isNotEmpty) {
              profesores[profesor] = academia;
            }
          }
          return ListView.builder(
            itemCount: profesores.length,
            itemBuilder: (context, index) {
              final nombreProfesor = profesores.keys.elementAt(index);
              final academia = profesores.values.elementAt(index);
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade900,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text(
                  nombreProfesor,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Text(academia),
              );
            },
          );
        },
      ),
    );
  }
}