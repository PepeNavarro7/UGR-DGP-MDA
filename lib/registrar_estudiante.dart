import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

/*
 * Clase Registrar Estudiante herede de StatefulWidget para que el campo de la
 * contraseña sea dinámico, es decir, pueda cambiar entre los tipos alfanumérico
 * o por pictogramas. Esto dependerá del tipo de Acceso que se seleccione
 */

// Lista de tipo String que contiene todos los tipos de acceso que soporta la
// aplicación. Cualquier cambio en este cambio modificará el campo contraseña
final List<String> tipoDeAccesos = <String>["Alfanumerico", "Pictogramas"];

// Lista de tipo String que contiene todos los grados de accesibilidad
final List<String> gradosDeAccesibilidad = <String>["Cognitiva", "Motora", "Visual"];

// Lista con los pictogramas para el campo de la contraseña
List<XFile> pictogramas = <XFile>[];

// Lista de pictogramas para el campo de la contraseña
List listaPictogramas = [];

class RegistrarEstudiante extends StatefulWidget {
  @override
  _RegistrarEstudianteState createState() => _RegistrarEstudianteState();
}

class _RegistrarEstudianteState extends State<RegistrarEstudiante> {
  // Color de la AppBar
  final colorAppBar = Colors.green;

// Color de los ElevatedButton
  final colorElevatedButton = Colors.green;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

  // Valor del desplegable del tipo de acceso, por defecto es la primera opción
  String valorTipoAcceso = tipoDeAccesos.first;

  // Valor del desplegable del grado de accesibilidad, por defecto es la primera opción
  String valorGradoAccesibilidad = gradosDeAccesibilidad.first;

  File? image;

  /*
   * Devuelve un Widget para mostrar el menú de Registrar Estudiante, con todos
   * sus elementos. Los elementos que lo conforman son:
   *    1. Nombre (TextField)
   *    2. Apellidos (TextField)
   *    3. Email (TextField)
   *    4. Tipo de Acceso (DropDown)
   *    5. Grado de Accesibilidad (DropDown)
   *    6. Contraseña (TextField o Pictogramas)
   *    7. Añadir foto (ElevatedButton)
   *    8. Registrar (ElevatedButton)
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorAppBar,
        title: Center(child: Text("Registrar Estudiante")),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            // Nombre
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nombre",
                ),
              ),
            ),

            // Apellidos
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Apellidos",
                ),
              ),
            ),

            // Email
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Email",
                ),
              ),
            ),

            // Tipo de Acceso
            Container(
              width: MediaQuery.of(context).size.width - separacionElementos,
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: DropdownButton(
                value: valorTipoAcceso,
                items: tipoDeAccesos.map<DropdownMenuItem<String>>((String valor) {
                  return DropdownMenuItem<String>(
                    value: valor,
                    child: Text(valor),
                  );
                }).toList(),
                onChanged: (String? valor) {
                  setState(() {
                    valorTipoAcceso = valor!;
                  });
                },
              )
            ),

            // Grado de accesibilidad
            Container(
                width: MediaQuery.of(context).size.width - separacionElementos,
                padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
                child: DropdownButton(
                  value: valorGradoAccesibilidad,
                  items: gradosDeAccesibilidad.map<DropdownMenuItem<String>>((String valor) {
                    return DropdownMenuItem<String>(
                      value: valor,
                      child: Text(valor),
                    );
                  }).toList(),
                  onChanged: (String? valor) {
                    setState(() {
                      valorGradoAccesibilidad = valor!;
                    });
                  },
                )
            ),

            // Contraseña
            Container(
              child: passwordWidget(valorTipoAcceso),
            ),

            // Añadir foto
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Añadir Foto"),
                style: ElevatedButton.styleFrom(
                  primary: colorElevatedButton,
                ),
              ),
            ),

            //Registrar
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, separacionElementos),
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Registrar"),
                style: ElevatedButton.styleFrom(
                  primary: colorElevatedButton,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget passwordWidget(String tipoDeAcceso) {
    if (tipoDeAcceso == "Alfanumerico") {
      return Container(
        padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Contraseña",
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}


