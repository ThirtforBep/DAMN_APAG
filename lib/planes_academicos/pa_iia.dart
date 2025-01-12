import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:proyecto_f/formato/downbar.dart';
import 'package:proyecto_f/formato/upbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Importar FontAwesome para Instagram

class IIAPage extends StatelessWidget {
  const IIAPage({super.key});

  Future<void> copyFileToDownloads(BuildContext context) async {
    const String assetPath = 'pa_pdfs/paiia2020.pdf';
    const String fileName = 'Mapa_Curricular_IIA.pdf';

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
                  'Programa Académico IIA',
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
                'Formar expertos capaces de desarrollar sistemas inteligentes utilizando diferentes metodologías en las diferentes etapas de desarrollo y aplicando algoritmos en áreas como aprendizaje de máquina, procesamiento automático de lenguaje natural, visión artificial y modelos bioinspirados para atender las necesidades de los diferentes sectores de la sociedad a través de la generación de procesos y soluciones innovadoras.',
                textAlign: TextAlign.justify,
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
                textAlign: TextAlign.justify,
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
                'El egresado de la Ingeniería en Inteligencia Artificial se desempeñará colaborativamente en equipos multidisciplinarios en el análisis, diseño, implementación, validación, implantación, supervisión y gestión de sistemas inteligentes, aplicando algoritmos en áreas como aprendizaje de máquina, procesamiento automático de lenguaje natural, visión artificial y modelos bioinspirados; ejerciendo su profesión con liderazgo, ética y responsabilidad social.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Campo laboral',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '- MEDICINA PERSONALIZADA',
              ),
              const SizedBox(height: 5),
              const Text(
                '- ASISTENCIA Y MOVILIDAD PARA PERSONAS CON DISCAPACIDAD O DE LA TERCERA EDAD',
              ),
              const SizedBox(height: 5),
              const Text(
                '- CIUDADES INTELIGENTES Y SOSTENIBLES',
              ),
              const SizedBox(height: 5),
              ElevatedButton.icon(
                onPressed: () => copyFileToDownloads(context),
                icon: const Icon(Icons.download),
                label: const Text(
                  'Mapa Curricular',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Barrainf(),  // Usa Barrainf para la navegación en la parte inferior
    );
  }
}
