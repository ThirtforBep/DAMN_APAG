import 'package:flutter/material.dart';
import 'package:proyecto_f/formato/downbar.dart';
import 'package:proyecto_f/formato/upbar.dart';

class Profesores extends StatefulWidget {
  final Map<String, dynamic> data;

  const Profesores({Key? key, required this.data}) : super(key: key);

  @override
  State<Profesores> createState() => _ProfesoresState();
}

class _ProfesoresState extends State<Profesores> {
  bool showSchedule = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Barrasup(title: 'Información de Usuario'),
      drawer: const DrawerMenu(),
      endDrawer: const DrawerMenuRight(),
      bottomNavigationBar: const Barrainf(),
      body: Column(
        children: [
          const Expanded(flex: 2, child: _TopPortion()),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.data["Profesor asignado"],
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.extended(
                        onPressed: () {
                          setState(() {
                            showSchedule = false;
                          });
                        },
                        heroTag: 'info',
                        elevation: 0,
                        backgroundColor: Colors.grey[600], // Gris claro
                        label: const Text(
                          "Información",
                          style:
                              TextStyle(color: Colors.white), // Letras blancas
                        ),
                        icon: const Icon(
                          Icons.info,
                          color: Colors.white, // Icono blanco
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      FloatingActionButton.extended(
                        onPressed: () {
                          setState(() {
                            showSchedule = true;
                          });
                        },
                        heroTag: 'schedule',
                        elevation: 0,
                        backgroundColor: Colors.grey[600], // Gris claro
                        label: const Text(
                          "Horario",
                          style:
                              TextStyle(color: Colors.white), // Letras blancas
                        ),
                        icon: const Icon(
                          Icons.schedule,
                          color: Colors.white, // Icono blanco
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: showSchedule
                        ? SingleChildScrollView(
                            child: _ClassScheduleTable(data: widget.data),
                          )
                        : _InformationView(data: widget.data),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InformationView extends StatelessWidget {
  final Map<String, dynamic> data;

  const _InformationView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final infoItems = [
      {"title": "Academia", "value": data["Academia"]},
      {"title": "Materia", "value": data["Unidad de Aprendizaje"]},
      {"title": "Grupo", "value": data["Grupo"]},
      {"title": "Laboratorio", "value": data["Lab"]},
      {"title": "Salón", "value": data["Salon"].toString()},
    ];

    return ListView.builder(
      itemCount: infoItems.length,
      itemBuilder: (context, index) {
        final item = infoItems[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListTile(
            title: Text(
              item["title"]!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(item["value"]!),
          ),
        );
      },
    );
  }
}

class _ClassScheduleTable extends StatelessWidget {
  final Map<String, dynamic> data;

  const _ClassScheduleTable({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final schedule = [
      {
        "day": "Lunes",
        "time": data["Lunes"].isEmpty ? "No hay clase" : data["Lunes"]
      },
      {
        "day": "Martes",
        "time": data["Martes"].isEmpty ? "No hay clase" : data["Martes"]
      },
      {
        "day": "Miércoles",
        "time": data["Miercoles"].isEmpty ? "No hay clase" : data["Miercoles"]
      },
      {
        "day": "Jueves",
        "time": data["Jueves"].isEmpty ? "No hay clase" : data["Jueves"]
      },
      {
        "day": "Viernes",
        "time": data["Viernes"].isEmpty ? "No hay clase" : data["Viernes"]
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            // Encabezado con fondo azul y bordes redondeados superiores
            Container(
              decoration: const BoxDecoration(
                color: Color(0xff0043ba), // Fondo azul del encabezado
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15), // Bordes redondeados superiores
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Día",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Horario",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Filas de la tabla
            Table(
              border: TableBorder.symmetric(
                inside: BorderSide(color: Colors.grey.shade300),
              ),
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
              },
              children: [
                ...schedule.map(
                  (item) => TableRow(
                    decoration: BoxDecoration(
                      color: schedule.indexOf(item) % 2 == 0
                          ? Colors.grey.shade200
                          : Colors.white,
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          item["day"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          item["time"]!,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Fondo azul con bordes redondeados
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xff0043ba), Color(0xff006df1)],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
        // Imagen del logo ESCOM con padding superior
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Image.asset(
              'img/logoESCOMBlanco.png',
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
          ),
        ),
        // Imagen de perfil (local)
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('img/Coqueto.jpeg'), // Imagen local
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
