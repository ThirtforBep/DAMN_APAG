import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:proyecto_f/formato/downbar.dart';
import 'package:proyecto_f/formato/upbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Importar FontAwesome para Instagram

class MCIIAPage extends StatelessWidget {
  const MCIIAPage({super.key});

  Future<void> copyFileToDownloads(BuildContext context) async {
    const String assetPath = 'pa_pdfs/pa_example.pdf';
    const String fileName = 'Mapa_Curricular_MCIIA.pdf';

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
                  'Programa Académico MCIIA',
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
                'Preparar ingenieros altamente especializados para atender las necesidades en ingeniería automotriz y de autopartes en sus Áreas de: manufactura, diseño, automatización, procesos, sistemas inteligentes, protección ambiental, administración e innovación tecnológica.',
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
                'El aspirante a estudiar la Carrera de Ingeniería en Sistemas Automotrices deberá haber egresado de cualquier institución pública o privada en el nivel medio superior o equivalente, dentro de alguna de las especialidades o área afines a las ciencias físico matemáticas, ello contribuirá al mejor equilibrio del conocimiento al ingreso. Aprobar el examen de admisión que el Instituto Politécnico Nacional establezca para este fin y atender los requerimientos de la convocatoria.',
              ),
              const SizedBox(height: 20),
              const Text(
                'Perfil de egreso',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Es un profesionista que aplica conocimientos de la matemática, las ciencias naturales, las ciencias sociales, humanísticas y administrativas que ha adquirido a través del estudio, la experiencia y la práctica',
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
                '- Diseño de Vehículos y sus Componentes',
              ),
              const SizedBox(height: 5),
              const Text(
                '- Manufactura de Autopartes',
              ),
              const SizedBox(height: 5),
              const Text(
                '- Control de Calidad',
              ),
              const SizedBox(height: 5),
              const Text(
                '- Ingeniería y Manufactura Asistidas por Computadora',
              ),
              const SizedBox(height: 5),
              const Text(
                '- Líneas de Ensamble',
              ),
              const SizedBox(height: 5),
              const Text(
                '- Desarrollo de Nuevas Tecnologías',
              ),
              const SizedBox(height: 5),
              const Text(
                '- Dispositivos Electrónicos',
              ),
              const SizedBox(height: 5),
              const Text(
                '- Materiales Compuestos',
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
