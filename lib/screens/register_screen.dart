import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController boletaController = TextEditingController();
  final TextEditingController curpController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController primerApeController = TextEditingController();
  final TextEditingController segundoApeController = TextEditingController();
  String? selectedCarrera;

  bool isBoletaValid = false;
  bool isCurpValid = false;
  String boletaError = '';
  String curpError = '';
  Map<String, bool> fieldErrors = {
    'boleta': false,
    'curp': false,
    'nombre': false,
    'primerApe': false,
    'segundoApe': false,
  };

  // Función para validar si la boleta ya existe en tiempo real
  Future<void> validateBoleta(String boleta) async {
    final query = await FirebaseFirestore.instance
        .collection('alumnos')
        .where('boleta', isEqualTo: boleta)
        .get();
    setState(() {
      if (query.docs.isNotEmpty) {
        isBoletaValid = false;
        boletaError = 'Ya existe este número de boleta';
      } else {
        isBoletaValid = true;
        boletaError = '';
      }
    });
  }

  // Función para validar si la CURP ya existe en tiempo real
  Future<void> validateCurp(String curp) async {
    final query = await FirebaseFirestore.instance
        .collection('alumnos')
        .where('curp', isEqualTo: curp)
        .get();
    setState(() {
      if (query.docs.isNotEmpty) {
        isCurpValid = false;
        curpError = 'Ya existe este CURP';
      } else {
        isCurpValid = true;
        curpError = '';
      }
    });
  }

  // Validación de campos vacíos al perder el enfoque
  void validateField(String fieldName, String value) {
    setState(() {
      fieldErrors[fieldName] = value.trim().isEmpty;
    });
  }

  // Registro del usuario
  Future<void> registerUser() async {
    // Validar que no haya errores en los campos obligatorios
    if (fieldErrors.containsValue(true) ||
        !isBoletaValid ||
        !isCurpValid ||
        selectedCarrera == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, verifica los campos e intenta nuevamente')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('alumnos').add({
        'boleta': boletaController.text.trim(),
        'curp': curpController.text.trim(),
        'nombre': nombreController.text.trim(),
        'primerApe': primerApeController.text.trim(),
        'segundoApe': segundoApeController.text.trim(),
        'pacad': selectedCarrera,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Alumno registrado correctamente')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registro de Usuario',
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Campo de boleta
              TextField(
                controller: boletaController,
                onChanged: (value) {
                  validateBoleta(value.trim());
                  validateField('boleta', value);
                },
                onEditingComplete: () =>
                    validateField('boleta', boletaController.text),
                maxLength: 10,
                decoration: InputDecoration(
                  labelText: 'Número de Boleta',
                  border: OutlineInputBorder(),
                  errorText: fieldErrors['boleta']!
                      ? 'Campo obligatorio'
                      : boletaError.isEmpty
                          ? null
                          : boletaError,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isBoletaValid ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Campo de CURP
              TextField(
                controller: curpController,
                onChanged: (value) {
                  validateCurp(value.trim());
                  validateField('curp', value);
                },
                onEditingComplete: () =>
                    validateField('curp', curpController.text),
                maxLength: 18,
                decoration: InputDecoration(
                  labelText: 'CURP',
                  border: OutlineInputBorder(),
                  errorText: fieldErrors['curp']!
                      ? 'Campo obligatorio'
                      : curpError.isEmpty
                          ? null
                          : curpError,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isCurpValid ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Campo de nombre
              TextField(
                controller: nombreController,
                onChanged: (value) => validateField('nombre', value),
                onEditingComplete: () =>
                    validateField('nombre', nombreController.text),
                maxLength: 50,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                  errorText:
                      fieldErrors['nombre']! ? 'Campo obligatorio' : null,
                ),
              ),
              SizedBox(height: 20),
              // Campo de apellido paterno
              TextField(
                controller: primerApeController,
                onChanged: (value) => validateField('primerApe', value),
                onEditingComplete: () =>
                    validateField('primerApe', primerApeController.text),
                maxLength: 50,
                decoration: InputDecoration(
                  labelText: 'Apellido Paterno',
                  border: OutlineInputBorder(),
                  errorText: fieldErrors['primerApe']!
                      ? 'Campo obligatorio'
                      : null,
                ),
              ),
              SizedBox(height: 20),
              // Campo de apellido materno
              TextField(
                controller: segundoApeController,
                onChanged: (value) => validateField('segundoApe', value),
                onEditingComplete: () =>
                    validateField('segundoApe', segundoApeController.text),
                maxLength: 50,
                decoration: InputDecoration(
                  labelText: 'Apellido Materno',
                  border: OutlineInputBorder(),
                  errorText: fieldErrors['segundoApe']!
                      ? 'Campo obligatorio'
                      : null,
                ),
              ),
              SizedBox(height: 20),
              // Dropdown para la carrera
              DropdownButtonFormField<String>(
                value: selectedCarrera,
                items: ['ISC', 'LCD', 'IA', 'ISA']
                    .map((carrera) => DropdownMenuItem(
                          value: carrera,
                          child: Text(carrera),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCarrera = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Carrera',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),
              // Botón de registro
              ElevatedButton(
                onPressed: registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  foregroundColor: Colors.white,
                ),
                child: Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
