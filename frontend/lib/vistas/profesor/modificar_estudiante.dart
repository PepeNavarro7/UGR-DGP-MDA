import 'dart:convert';

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

// Lista que almacena todas los pictogramas no seleccionados para la clave por el usuario
List<XFile>? listaPictogramasNoClave = [];

class ModificarEstudiante extends StatefulWidget {
  ModificarEstudiante(Estudiante estudiante) {
    estudianteAModificar = estudiante;
    estudianteAModificar!.foto = "http://10.0.2.2/" + estudianteAModificar!.foto.substring(3);
    print(estudianteAModificar!.foto);
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
  final double separacionElementos = 30.0;

  // Valor del desplegable del tipo de acceso, por defecto es la primera opción
  String valorTipoAcceso = estudianteAModificar!.acceso;

  // Controlador para gestionar la selección de los pictogramas
  final ImagePicker selectorImagenes = ImagePicker();

  // Controladores para poner valores iniciales
  TextEditingController controladorNombre = new TextEditingController(text: estudianteAModificar!.nombre);
  TextEditingController controladorApellidos = new TextEditingController(text: estudianteAModificar!.apellidos);
  TextEditingController controladorMail = new TextEditingController(text: estudianteAModificar!.email);
  TextEditingController controladorPassword = new TextEditingController(text: estudianteAModificar!.password);


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
  bool audio = estudianteAModificar!.accesibilidad.contains("audio");
  bool video = estudianteAModificar!.accesibilidad.contains("video");

  // Función para seleccionar los pictogramas de la galería
  void seleccionarPictogramas() async {
    final List<XFile>? pictogramasSeleccionados = await selectorImagenes.pickMultiImage();

    if (pictogramasSeleccionados!.isNotEmpty) {
      listaPictogramas!.addAll(pictogramasSeleccionados);

      if (listaPictogramas!.length > 6) {
        listaPictogramas!.length = 6;
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

    nombre = controladorNombre.text;
    apellidos = controladorApellidos.text;
    email = controladorMail.text;
    passwordUsuario = controladorPassword.text;

    if (valorTipoAcceso == "Pictogramas")
    {
      passwordUsuario="NULL";
    }

    String foto = "sin_cambios";

    if (fotoEstudiante != null) {
      List<int> bytesImagen = File(fotoEstudiante!.path).readAsBytesSync();
      foto = base64Encode(bytesImagen);
      print("Bytes imagen: " + foto);
    }

    print("Id: " + estudianteAModificar!.idEstudiante);
    print("Nombre: $nombre");
    print("Apellidos: $apellidos");
    print("Email: $email");
    print("Acceso: $valorTipoAcceso");
    print("Accesibilidad: $accesibilidad");
    print("Password: $passwordUsuario");
    print("Foto: $foto");
    if (datosCompletos()) {

      String pictogramaClave1 = "";
      String pictogramaClave2 = "";
      String pictogramaClave3 = "";
      String pictogramaClave4 = "";
      String pictogramaNoClave1 = "";
      String pictogramaNoClave2 = "";

      if (valorTipoAcceso == "Pictogramas") {
        List<int> bytesPictogramaClave1 = File(listaPictogramasClave![0].path).readAsBytesSync();
        pictogramaClave1 = base64Encode(bytesPictogramaClave1);

        List<int> bytesPictogramaClave2 = File(listaPictogramasClave![1].path).readAsBytesSync();
        pictogramaClave2 = base64Encode(bytesPictogramaClave2);

        List<int> bytesPictogramaClave3 = File(listaPictogramasClave![2].path).readAsBytesSync();
        pictogramaClave3 = base64Encode(bytesPictogramaClave3);

        List<int> bytesPictogramaClave4 = File(listaPictogramasClave![3].path).readAsBytesSync();
        pictogramaClave4 = base64Encode(bytesPictogramaClave4);

        // Se calculan los pictogramas no clave
        listaPictogramasNoClave!.clear();
        for(int i = 0; i < listaPictogramas!.length; i++) {
          if (!listaPictogramasClave!.contains(listaPictogramas![i]))
            listaPictogramasNoClave!.add(listaPictogramas![i]);
        }

        List<int> bytesPictogramaNoClave1 = File(listaPictogramasNoClave![0].path).readAsBytesSync();
        pictogramaNoClave1 = base64Encode(bytesPictogramaNoClave1);

        List<int> bytesPictogramaNoClave2 = File(listaPictogramasNoClave![1].path).readAsBytesSync();
        pictogramaNoClave2 = base64Encode(bytesPictogramaNoClave2);
      }

      try {
        String uri = "http://10.0.2.2/dgp_php_scripts/modificar_estudiante.php";

        final response = await http.post(Uri.parse(uri), body: {
          "id_estudiante": estudianteAModificar!.idEstudiante,
          "nombre": nombre,
          "apellidos": apellidos,
          "email": email,
          "acceso": valorTipoAcceso,
          "accesibilidad": accesibilidad,
          "password_usuario": passwordUsuario,
          "foto": foto,
          "pictograma_clave_1": pictogramaClave1,
          "pictograma_clave_2": pictogramaClave2,
          "pictograma_clave_3": pictogramaClave3,
          "pictograma_clave_4": pictogramaClave4,
          "pictograma_no_clave_1": pictogramaNoClave1,
          "pictograma_no_clave_2": pictogramaNoClave2,
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
        height: 500,
        width: 500,
        padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
        child: fotoEstudiante != null ?
        CircleAvatar(backgroundImage: FileImage(File(fotoEstudiante!.path)), backgroundColor: Colors.grey) :
        CircleAvatar(backgroundImage: NetworkImage(estudianteAModificar!.foto)),
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
              child: Text("Necesidades para el estudiante", style: TextStyle(fontSize: 30))
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
              Text("Audio", style: TextStyle(fontSize: 30))
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
              Text("Video", style: TextStyle(fontSize: 30))
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
        controller: controladorPassword,
        obscureText: true,
        onChanged: (text) {
          passwordUsuario = text;
        },
        style: TextStyle(fontSize: 30),
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
                    child: Text("Pictogramas que se le mostrarán al estudiante", style: TextStyle(fontSize: 30))
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Seleccione los pictogramas de la clave", style: TextStyle(fontSize: 30))
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
                onPressed: listaPictogramas!.length < 6 ? seleccionarPictogramas : null,
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
        (listaPictogramas!.length == 6 && listaPictogramasClave!.isNotEmpty) ?
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
        title: Text("Modificar Estudiante", style: TextStyle(fontSize: 30)),
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
                controller: controladorNombre,
                onChanged: (text) {
                  nombre = text;
                },
                style: TextStyle(fontSize: 30),
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
                controller: controladorApellidos,
                onChanged: (text) {
                  apellidos = text;
                },
                style: TextStyle(fontSize: 30),
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
                controller: controladorMail,
                onChanged: (text) {
                  email = text;
                },
                style: TextStyle(fontSize: 30),
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
                      child: Text(valor, style: TextStyle(fontSize: 30)),
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
              padding: EdgeInsets.all(separacionElementos),
              child: ElevatedButton(
                onPressed: modificar,
                child: Text("Modificar", style: TextStyle(fontSize: 30)),
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


