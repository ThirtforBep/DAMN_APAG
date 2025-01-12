import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:proyecto_f/formato/downbar.dart';
import 'package:proyecto_f/formato/upbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Importar FontAwesome para Instagram

class MCCDPage extends StatelessWidget {
  const MCCDPage({super.key});

  Future<void> copyFileToDownloads(BuildContext context) async {
    const String assetPath = 'pa_pdfs/pa_example.pdf';
    const String fileName = 'Mapa_Curricular_MCCD.pdf';

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
                  'Programa Académico MCCD',
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
                'Formar profesionistas especializados en la gestión, análisis e interpretación de grandes volúmenes de datos para la toma de decisiones estratégicas, desarrollando competencias en áreas como inteligencia artificial, aprendizaje automático, estadística avanzada y visualización de datos.',
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
                'Requiere una formación previa en áreas afines como ingeniería en sistemas, matemáticas aplicadas, estadística o carreras relacionadas. También se espera conocimientos básicos en programación, habilidad para resolver problemas complejos, interés por la investigación y un nivel intermedio o avanzado de inglés técnico.',
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
                'Los profesionistas tendrán capacidad para desarrollar modelos predictivos y prescriptivos mediante técnicas avanzadas de machine learning, dominio de herramientas para el análisis de datos, integración de datos heterogéneos y habilidades para comunicar hallazgos a través de visualizaciones efectivas. También estarán preparados para liderar proyectos de ciencia de datos en diversos sectores.',
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
                'El campo laboral incluye empresas tecnológicas, instituciones financieras, el sector salud, empresas de retail y centros de investigación relacionados con inteligencia artificial y análisis de datos.',
              ),
              const SizedBox(height: 20),
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
