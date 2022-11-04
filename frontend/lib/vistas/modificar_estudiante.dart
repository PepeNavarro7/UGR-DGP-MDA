import 'package:app/clases/estudiante.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

/*
 * Clase Registrar Estudiante hereda de StatefulWidget para que el campo de la
 * contraseña sea dinámico, es decir, pueda cambiar entre los tipos alfanumérico
 * o por pictogramas. Esto dependerá del tipo de Acceso que se seleccione
 */

// Lista de tipo String que contiene todos los tipos de acceso que soporta la
// aplicación. Cualquier cambio en este cambio modificará el campo contraseña
final List<String> tipoDeAccesos = <String>["Alfanumerico", "Pictogramas"];

// Estudiante a modificar
Estudiante? estudianteAModificar;

class ModificarEstudiante extends StatefulWidget {
  ModificarEstudiante(Estudiante estudiante) {
    estudianteAModificar = estudiante;
  }

  @override
  _ModificarEstudianteState createState() => _ModificarEstudianteState();
}

class _ModificarEstudianteState extends State<ModificarEstudiante> {
  // Color de la AppBar
  final colorAppBar = Colors.blue;

// Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

  // Valor del desplegable del tipo de acceso, por defecto es la primera opción
  String valorTipoAcceso = tipoDeAccesos.first;

  // Controlador para gestionar la selección de los pictogramas
  final ImagePicker selectorImagenes = ImagePicker();

  // Lista que almacena todas los pictogramas seleccionados por el usuario
  List<XFile>? listaPictogramas = [];

  // Lista que almacena todas los pictogramas seleccionados para la clave por el usuario
  List<XFile>? listaPictogramasClave = [];

  // Foto del Estudiante
  XFile? fotoEstudiante = null;

  // Datos del estudiante
  String nombre = "";
  String apellidos = "";
  String email = "";
  String passwordUsuario = "";

  // Necesidades del estudiante
  bool audio = false;
  bool video = false;

  // Función para seleccionar los pictogramas de la galería
  void seleccionarPictogramas() async {
    final List<XFile>? pictogramasSeleccionados = await selectorImagenes.pickMultiImage();

    if (pictogramasSeleccionados!.isNotEmpty) {
      listaPictogramas!.addAll(pictogramasSeleccionados);

      if (listaPictogramas!.length > 9) {
        listaPictogramas!.length = 9;
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

  // Función para seleccionar la foto de perfil del estudiante de la galería
  void seleccionarFotoEstudiante() async {
    fotoEstudiante = await selectorImagenes.pickImage(source: ImageSource.gallery);
    setState(() {});
    print(fotoEstudiante!.path);
  }

  bool datosCompletos() {
    if (nombre == "")
      return false;
    if (apellidos == "")
      return false;
    if (email == "")
      return false;
    if (valorTipoAcceso == "Alfanumerico" && passwordUsuario == "")
      return false;

    return true;
  }

  // Función para registrar estudiante
  Future<void> modificar() async {
    if (datosCompletos()) {
      String accesibilidad = "";

      if (audio && video) {
        accesibilidad = "audio y video";
      } else if (audio) {
        accesibilidad = "audio";
      } else if (video) {
        accesibilidad = "video";
      } else {
        accesibilidad = "ninguna";
      }

      String foto = "a";

      print("Nombre: $nombre");
      print("Apellidos: $apellidos");
      print("Email: $email");
      print("Acceso: $valorTipoAcceso");
      print("Accesibilidad: $accesibilidad");
      print("Password: $passwordUsuario");
      print("Foto: $foto");

      try {
        String uri = "http://10.0.2.2/dgp_php_scripts/modificar_estudiante.php";

        final response = await http.post(Uri.parse(uri), body: {
          "nombre_antiguo": estudianteAModificar!.nombre,
          "apellidos_antiguo": estudianteAModificar!.apellidos,
          "email_antiguo": estudianteAModificar!.email,
          "nombre_nuevo": nombre,
          "apellidos_nuevo": apellidos,
          "email_nuevo": email,
          "acceso_nuevo": valorTipoAcceso,
          "accesibilidad_nuevo": accesibilidad,
          "password_usuario_nuevo": passwordUsuario,
          "foto_nuevo": "a",
        });

        print("Estudiante modificado  ");
      } catch (e) {
        print("Exception: $e");
      }

      Navigator.pop(context);
    } else {
      print("Estudiante no modificado (faltan datos)");
    }
  }

  Widget FotoEstudiante() {
    return GestureDetector(
      onTap: seleccionarFotoEstudiante,
      child: Container(
        height: 250,
        width: 250,
        padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
        child: fotoEstudiante == null ?
        CircleAvatar(backgroundImage: AssetImage("assets/imagenes/sin_foto_perfil.jpg"), backgroundColor: Colors.grey) :
        CircleAvatar(backgroundImage: FileImage(File(fotoEstudiante!.path)), backgroundColor: Colors.grey),
      ),
    );
  }

  // Widget de las necesidades del estudiante (CheckBoxes)
  Widget NecesidadesEstudiante() {
    return Container(
      padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
      child: Column(
        children: [
          Container(
              alignment: Alignment.centerLeft,
              child: Text("Necesidades para el estudiante", style: TextStyle(fontSize: 17))
          ),
          Row(
            children: [
              Checkbox(
                checkColor: Colors.white,
                activeColor: colorBotones,
                value: audio,
                onChanged: (bool? valor) {
                  setState(() {
                    audio = !audio;
                  });
                },
              ),
              Text("Audio")
            ],
          ),
          Row(
            children: [
              Checkbox(
                checkColor: Colors.white,
                activeColor: colorBotones,
                value: video,
                onChanged: (bool? valor) {
                  setState(() {
                    video = !video;
                  });
                },
              ),
              Text("Video")
            ],
          ),
        ],
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
        obscureText: true,
        onChanged: (text) {
          passwordUsuario = text;
        },
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
        Container(
            padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, separacionElementos / 2),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Pictogramas que se le mostrarán al estudiante", style: TextStyle(fontSize: 17))
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Seleccione los pictogramas de la clave", style: TextStyle(fontSize: 17))
                )
              ],
            )
        ),
        cuadriculaPictogramas(),
        Container(
          padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: listaPictogramas!.length < 9 ? seleccionarPictogramas : null,
                child: Text("Añadir Pictogramas"),
                style: ElevatedButton.styleFrom(
                  primary: colorBotones,
                ),
              ),
              ElevatedButton(
                onPressed: listaPictogramas!.isNotEmpty ? eliminarPictogramas : null,
                child: Text("Eliminar Pictogramas"),
                style: ElevatedButton.styleFrom(
                  primary: colorBotones,
                ),
              ),
            ],
          ),
        ),
        (listaPictogramas!.length == 9 && listaPictogramasClave!.isNotEmpty) ?
        Container(
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, separacionElementos / 2),
                    child: Text("Pictogramas de la clave del estudiante", style: TextStyle(fontSize: 17))
                ),
                cuadriculaPictogramasClave()
              ],
            )
        ) :
        Container(),
      ],
    );
  }

  // Widget para mostrar los pictogramas seleccionados en una cuadricula de 3x3
  Widget cuadriculaPictogramas() {
    return Container(
        padding: EdgeInsets.all(2.0),
        child: SizedBox(
          height: listaPictogramas!.isEmpty ? 0.0 : MediaQuery.of(context).size.width / 3 * (((listaPictogramas!.length - 1) / 3).toInt() + 1),
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: listaPictogramas!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.all(2.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (!listaPictogramasClave!.contains(listaPictogramas![index])) {
                        if (listaPictogramasClave!.length < 4)
                          listaPictogramasClave!.add(listaPictogramas![index]);
                      } else {
                        listaPictogramasClave!.remove(listaPictogramas![index]);
                      }
                    });
                  },
                  child: Image.file(
                      File(listaPictogramas![index].path),
                      fit: BoxFit.cover
                  ),
                ),
              );
            },
          ),
        )
    );
  }

  // Widget para mostrar los pictogramas seleccionados para la clave en una cuadricula de 2x2
  Widget cuadriculaPictogramasClave() {
    return Container(
      padding: EdgeInsets.all(2.0),
      child: SizedBox(
        height: listaPictogramasClave!.isEmpty ? 0.0 : MediaQuery.of(context).size.width / 2 * (((listaPictogramasClave!.length - 1) / 2).toInt() + 1),
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: listaPictogramasClave!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
                padding: EdgeInsets.all(2.0),
                child: Image.file(File(listaPictogramasClave![index].path), fit: BoxFit.cover)
            );
          },
        ),
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
   *    5. Necesidades del estudiante (Checkboxes)
   *    6. Tipo de Acceso (DropDown)
   *    7. Contraseña (TextField o Pictogramas)
   *    8. Registrar (ElevatedButton)
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorAppBar,
        title: Text("Modificar Estudiante"),
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
                onChanged: (text) {
                  nombre = text;
                },
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
                onChanged: (text) {
                  apellidos = text;
                },
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
                onChanged: (text) {
                  email = text;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Email",
                ),
              ),
            ),

            // Necesidades del estudiante
            NecesidadesEstudiante(),

            // Tipo de Acceso
            Container(
                width: MediaQuery.of(context).size.width - separacionElementos,
                padding: EdgeInsets.fromLTRB(separacionElementos, 0.0, separacionElementos, 0.0),
                margin: EdgeInsets.all(10),
                child: DropdownButton(
                  value: valorTipoAcceso,
                  isExpanded: true,
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

            // Contraseña
            Container(
              child: PasswordWidget(valorTipoAcceso),
            ),

            //Registrar
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, separacionElementos),
              child: ElevatedButton(
                onPressed: modificar,
                child: Text("Modificar"),
                style: ElevatedButton.styleFrom(
                  primary: colorBotones,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}


