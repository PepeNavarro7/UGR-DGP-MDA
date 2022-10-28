import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

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

  // Controlador para gestionar la selección de los pictogramas
  final ImagePicker selectorImagenes = ImagePicker();

  // Lista que almacena todas los pictogramas seleccionados por el usuario
  List<XFile>? listaPictogramas = [];

  // Foto del Estudiante
  XFile? fotoEstudiante = null;

  // Función para seleccionar los pictogramas de la galería
  void seleccionarPictogramas() async {
    final List<XFile>? pictogramasSeleccionados = await selectorImagenes.pickMultiImage();

    if (pictogramasSeleccionados!.isNotEmpty) {
      listaPictogramas!.addAll(pictogramasSeleccionados);

      if (listaPictogramas!.length > 4) {
        listaPictogramas!.length = 4;
      }
    }

    setState(() {});
  }

  // Función para vacir la lista de pictogramas
  void eliminarPictogramas() {
    setState(() {
      listaPictogramas!.clear();
    });
  }

  // Función para seleccionar la foto de perfil del estudiante de la galería o camara
  void seleccionarFotoEstudiante() async {
    fotoEstudiante = await selectorImagenes.pickImage(source: ImageSource.gallery);
    setState(() {});
    print(fotoEstudiante!.path);
  }

  Widget FotoEstudiante() {
    return GestureDetector(
      onTap: seleccionarFotoEstudiante,
      child: Container(
        height: 250,
        width: 250,
        padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
        child: CircleAvatar(
          backgroundImage: fotoEstudiante == null ? AssetImage("assets/imagenes/sin_foto_perfil.jpg") : AssetImage("assets/imagenes/sin_foto_perfil.jpg"),
        ),
      ),
    );
  }

  // Widget que contiene la vista del campo contraseña, cambia según el tipo de acceso
  Widget PasswordWidget(String tipoDeAcceso) {
    if (tipoDeAcceso == "Alfanumerico") {
      return PasswordAlfanumerico();
    } else {
      return PasswordPictogramas();
    }
  }

  // Widget para la contraseña alfanumérica
  Widget PasswordAlfanumerico() {
    return Container(
      padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Contraseña",
        ),
      ),
    );
  }

  // Widget para la contraseña por pictogramas
  Widget PasswordPictogramas() {
      return Column(
        children: [
          cuadriculaPictogramas(),
          Container(
            padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: listaPictogramas!.length < 4 ? seleccionarPictogramas : null,
                  child: Text("Añadir Pictogramas"),
                  style: ElevatedButton.styleFrom(
                    primary: colorElevatedButton,
                  ),
                ),
                ElevatedButton(
                  onPressed: listaPictogramas!.isNotEmpty ? eliminarPictogramas : null,
                  child: Text("Eliminar Pictogramas"),
                  style: ElevatedButton.styleFrom(
                    primary: colorElevatedButton,
                  ),
                ),
              ],
            ),
          )
        ],
      );
  }

  // Widget para mostrar los pictogramas seleccionados en una cuadricula de 2x2
  Widget cuadriculaPictogramas() {
    return SizedBox(
      height: listaPictogramas!.length == 0 ? 0.0 : (listaPictogramas!.length < 3 ? MediaQuery.of(context).size.width / 2 : MediaQuery.of(context).size.width),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: listaPictogramas!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Image.file(File(listaPictogramas![index].path), fit: BoxFit.cover);
        },
      ),
    );
  }

  /*
   * Devuelve un Widget para mostrar el menú de Registrar Estudiante, con todos
   * sus elementos. Los elementos que lo conforman son:
   *    1. Añadir foto (Imagen como botón)
   *    2. Nombre (TextField)
   *    3. Apellidos (TextField)
   *    4. Email (TextField)
   *    5. Tipo de Acceso (DropDown)
   *    6. Grado de Accesibilidad (DropDown)
   *    7. Contraseña (TextField o Pictogramas)
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
            // Añadir foto
            FotoEstudiante(),

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
              child: PasswordWidget(valorTipoAcceso),
            ),

            //Registrar
            Container(
              alignment: Alignment.center,
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
}


