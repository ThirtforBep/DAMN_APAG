import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:proyecto_f/formato/downbar.dart';
import 'package:proyecto_f/formato/upbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Importar FontAwesome para Instagram

class LCDPage extends StatelessWidget {
  const LCDPage({super.key});

  Future<void> copyFileToDownloads(BuildContext context) async {
    const String assetPath = 'pa_pdfs/palcd2020.pdf';
    const String fileName = 'Mapa_Curricular_LCD.pdf';

    try {
      // Muestra un indicador de carga
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // Obtén el archivo del almacenamiento de assets
      final ByteData data = await DefaultAssetBundle.of(context).load(assetPath);

      // Determina la ruta de la carpeta de descargas
      final String downloadsPath = '/storage/emulated/0/Download/$fileName';

      // Escribe el archivo en la carpeta de descargas
      final File file = File(downloadsPath);
      await file.writeAsBytes(data.buffer.asUint8List());

      // Cierra el indicador de carga
      Navigator.pop(context);

      // Muestra un mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Archivo guardado en: $downloadsPath')),
      );
    } catch (e) {
      // Cierra el indicador de carga y muestra un mensaje de error
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al descargar el archivo: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Barrasup(title: 'ESCOM'),
      drawer: const DrawerMenu(),  // Menú desplegable izquierdo
      endDrawer: const DrawerMenuRight(),  // Menú desplegable derecho
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Programa Académico LCD',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.center,  // Esto asegura que el texto esté centrado dentro de su área.
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Objetivo',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Formar expertos capaces de extraer conocimiento implícito y complejo, potencialmente útil a partir de grandes conjuntos de datos, utilizando métodos de inteligencia artificial, aprendizaje de máquina, estadística, sistemas de bases de datos y modelos matemáticos sobre comportamientos probables, para apoyar la toma de decisiones de alta dirección.',
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Perfil de ingreso',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Los estudiantes que ingresen al Instituto Politécnico Nacional, en cualquiera de sus programas y niveles, deberán contar con los conocimientos y las habilidades básicas que garanticen un adecuado desempeño en el nivel al que solicitan su ingreso. Asimismo, deberán contar con las actitudes y valores necesarios para responsabilizarse de su proceso formativo y asumir una posición activa frente al estudio y al desarrollo de los proyectos y trabajos requeridos, coincidentes con el ideario y principios del IPN.',
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Perfil de egreso',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'El egresado de la Licenciatura de Ciencia de Datos será capaz de extraer conocimiento implícito y complejo, potencialmente útil (descubrimiento de patrones, desviaciones, anomalías, valores anómalos, situaciones interesantes, tendencias), a partir de grandes conjuntos de datos. Utiliza los métodos de la inteligencia artificial, aprendizaje de máquina, estadística y sistemas de bases de datos para la toma de decisiones de alta dirección, fundadas en los datos y modelos matemáticos sobre comportamientos probables, deseables e indeseables, participando en dinámicas de trabajo colaborativo e interdisciplinario con sentido ético y responsabilidad social.',
              ),
              const SizedBox(height: 20),
              const Text(
                'Campo laboral',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '- MERCADOTECNIA',
              ),
              const SizedBox(height: 5),
              const Text(
                '- SALUD',
              ),
              const SizedBox(height: 5),
              const Text(
                '- FINANZAS',
              ),
              const SizedBox(height: 5),
              const Text(
                '- BIOINFORMÁTICA',
              ),
              const SizedBox(height: 5),
              const Text(
                '- ENERGÍA',
              ),
              const SizedBox(height: 5),
              const Text(
                '- COMERCIO ELECTRÓNICO',
              ),
              const SizedBox(height: 5),
              const Text(
                '- TRANSPORTE',
              ),
              const SizedBox(height: 5),
              const Text(
                '- EDUCACIÓN',
              ),
              const SizedBox(height: 5),
              const Text(
                '- NEGOCIOS',
              ),
              const SizedBox(height: 5),
              const Text(
                'SEGURIDAD',
              ),
              const SizedBox(height: 5),
              ElevatedButton.icon(
                onPressed: () => copyFileToDownloads(context),
                icon: const Icon(Icons.download),
                label: const Text('Mapa Curricular'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Barrainf(),  // Usa Barrainf para la navegación en la parte inferior
    );
  }
}
