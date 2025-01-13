import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FacebookPage extends StatelessWidget {
  const FacebookPage({super.key});

  // Método para lanzar la URL
  void _launch(String url) async {
    final Uri uri = Uri.parse(url);  // Usamos Uri.parse para la URL
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('No se puede abrir la URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facebook'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Lanzar la URL de Facebook
            _launch('https://www.google.com');
          },
          child: const Text('Ir a Facebook'),
        ),
      ),
    );
  }
}
