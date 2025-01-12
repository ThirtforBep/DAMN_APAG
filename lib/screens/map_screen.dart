import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:proyecto_f/formato/downbar.dart'; // Asegúrate de que downbar.dart esté en formato
import 'package:proyecto_f/formato/upbar.dart'; // Asegúrate de que upbar.dart esté en formato
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Para los íconos adicionales

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final MapController _mapController;
  LatLng _center = LatLng(19.505, -99.14666667); // Ubicación inicial (Ciudad de México)

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Barrasup(title: 'ESCOM'),
      drawer: const DrawerMenu(),  // Menú desplegable izquierdo
      endDrawer: const DrawerMenuRight(),  // Menú desplegable derecho
      body: Column(
        children: [
          // Mapa
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _center,  // Cambiado a 'initialCenter'
                initialZoom: 17.0,  // Cambiado a 'initialZoom'
                maxZoom: 18.0, // Ajuste del valor máximo de zoom
                minZoom: 10.0, // Ajuste del valor mínimo de zoom
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
              ],
            ),
          ),
          // Datos de la dirección
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dirección:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Av. Juan de Dios Batíz casi esquina Miguel Othón de Mendizabal. \nU.P. Adolfo López Mateos. C. P. 12345\nAlcaldía Gustavo A. Madero\nTeléfono: 55 5729 6000 Ext. 52001\nCorreo: escom@ipn.mx',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        tooltip: 'Get Location',
        backgroundColor: Color.fromARGB(255, 24, 28, 255),
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
      bottomNavigationBar: const Barrainf(), // Usa Barrainf para la navegación en la parte inferior
    );
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica si los servicios de ubicación están habilitados.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Los servicios de ubicación están deshabilitados.')),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Permisos de ubicación denegados')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Los permisos de ubicación están permanentemente denegados, no podemos solicitarlos.'),
        ),
      );
      return;
    }

    // Obtiene la posición del dispositivo cuando los permisos son concedidos.
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _center = LatLng(position.latitude, position.longitude);
      _mapController.move(_center, 13.0); // Mueve el mapa a la nueva ubicación
    });
  }
}
