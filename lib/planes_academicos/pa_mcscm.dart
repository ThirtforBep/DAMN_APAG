import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:proyecto_f/formato/downbar.dart';
import 'package:proyecto_f/formato/upbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Importar FontAwesome para Instagram

class MCSCMPage extends StatelessWidget {
  const MCSCMPage({super.key});

  Future<void> copyFileToDownloads(BuildContext context) async {
    const String assetPath = 'pa_pdfs/pa_example.pdf';
    const String fileName = 'Mapa_Curricular_MCSCM.pdf';

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
                  'Programa Académico MCSCM',
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
                'Formar especialistas en el diseño, desarrollo e implementación de soluciones tecnológicas avanzadas para dispositivos móviles, con énfasis en la innovación, eficiencia energética, conectividad y seguridad.',
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
                'Formación en ingeniería en sistemas computacionales, informática, electrónica o áreas afines, junto con conocimientos básicos de programación, interés en tecnologías móviles, IoT y redes inalámbricas, además de un nivel intermedio de inglés técnico.',
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
                'El egresado será capaz de diseñar y desarrollar aplicaciones móviles nativas y multiplataforma, implementar soluciones en tecnologías emergentes como IoT y realidad aumentada, dominar protocolos de comunicación móvil, optimizar la eficiencia energética de sistemas móviles y garantizar la seguridad y privacidad en dichas tecnologías.',
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
                'El campo laboral incluye empresas de desarrollo de software móvil, la industria automotriz en sistemas de conectividad, startups enfocadas en IoT y wearables, empresas de telecomunicaciones y centros de investigación en tecnologías móviles y redes.',
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
