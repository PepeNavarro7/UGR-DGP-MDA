import 'package:app/clases/tarea.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'inicio_profesor.dart';

// Lista de tipo String que contiene todos los lugares de una tarea
final List<String> listaTipos = ["Tarea normal", "Comanda", "Menú"];
FToast ventana_mensajes = FToast();

/*
 * Clase Crear Tarea hereda de StatefulWidget para que los distintos elementos
 * sean dinámicos, es decir, pueden cambiar los distintos widgets en función del
 * tipo de tarea a crear (normal, comanda, menú)
 */

// Tarea a modificar
Tarea? tareaAModificar;

class ModificarTarea extends StatefulWidget {
  ModificarTarea(Tarea tarea) {
    tareaAModificar = tarea;
  }

  @override
  _ModificarTareaState createState() => _ModificarTareaState();
}

class _ModificarTareaState extends State<ModificarTarea> {
  // Color de la AppBar
  final colorAppBar = Colors.blue;

// Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

  //Variable para controlar los pasos que se añaden
  TextEditingController controladorPasos = new TextEditingController();

  // Controladores para poner valores iniciales
  TextEditingController controladorNombre = new TextEditingController(text: tareaAModificar!.nombre);
  TextEditingController controladorDescripcion = new TextEditingController(text: tareaAModificar!.descripcion);
  TextEditingController controladorLugar = new TextEditingController(text: tareaAModificar!.lugar);

  // Datos de la tarea
  String nombre = tareaAModificar!.nombre;
  String descripcion = tareaAModificar!.descripcion;
  String lugar = tareaAModificar!.lugar;
  String tipo = tareaAModificar!.tipo == "N" ? "Tarea normal" : tareaAModificar!.tipo == "C" ? "Comanda" : tareaAModificar!.tipo == "M" ? "Menú" : "Tarea normal";
  String paso = "";
  List<String> listaPasos = tareaAModificar!.pasos;

  // Función que añade un paso a la lista de pasos, solo añade si no es null, el texto
  // no son solo espacio y no esta repetido el paso
  void aniadirPaso(String paso) {
    setState(() {
      if (paso != null && paso.trim().length != 0 && !listaPasos.contains(paso)) {
        listaPasos.add(paso);
        print(listaPasos.length);
      }
    });
  }

  // Función que borrar todos los pasos de una lista
  void borrarPasos() {
    setState(() {
      listaPasos.clear();
    });
  }
  bool datosCompletos() {
    bool aux = true;
    if (nombre == ""){
      aux=false;
    }
    if (descripcion == ""){
      aux=false;
    }
    if (lugar == ""){
      aux=false;
    }
    return aux;
  }

  Future<void> modificarTarea() async{
    String jsonPasos = jsonEncode(listaPasos);

    print("Nombre: $nombre");
    print("Descripción: $descripcion)");
    print("Lugar: $lugar");
    print("Tipo: $tipo");
    print("pasos: $jsonPasos");


    if(datosCompletos()){
      ventana_mensajes.init(context);
      String auxTarea = "";
      if(tipo == "Tarea normal"){
        auxTarea = "N";
      }
      else if(tipo == "Comanda"){
        auxTarea = "C";
      }
      else{
        auxTarea = "M";
      }

      String jsonPasos = jsonEncode(listaPasos);

      print("Nombre: $nombre");
      print("Descripción: $descripcion");
      print("Lugar: $lugar");
      print("Tipo: $auxTarea");
      print("Pasos: $jsonPasos");

      try {

        String uri = "http://10.0.2.2/dgp_php_scripts/modificar_tarea.php";

        final response = await http.post(Uri.parse(uri), body: {
          "nombre_antiguo": tareaAModificar!.nombre,
          "nombre_nuevo": nombre,
          "descripcion_nuevo": descripcion,
          "lugar_nuevo": lugar,
          "tipo_nuevo": auxTarea,
          "pasos_nuevo": jsonPasos.toString(),
        });

        print("Tarea modificada");
        FToast().showToast(
            child: Text("Tarea creada",
              style: TextStyle(fontSize: 25, color: Colors.green),
            )
        );
        Navigator.pop(context);
      } catch (e) {
        print("Exception: $e");
      }
    } else{
      print("Tarea no creada (faltan datos)");
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
              content:
              Text("Tarea no creada (faltan datos)"),
              actions: [
                TextButton(
                  child: Text("Vale"),
                  onPressed: () => Navigator.pop(context),
                ),
              ]
          )
      );
    }
  }

  /*
   * Devuelve un Widget para mostrar el menú de Crear Tarea, con todos
   * sus elementos. Los elementos que lo conforman son:
   *    1. Nombre (TextField)
   *    2. Descripción (TextField)
   *    4. Lugar (Dropdown)
   *    5. Pasos (ListView)
   *    8. Botones Cancelar y Crear (ElevatedButtons en un Row)
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorAppBar,
        title: Text("Crear Tarea"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            // Nombre
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: TextField(
                controller: controladorNombre,
                onChanged: (text) {
                  nombre = text;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nombre",
                ),
              ),
            ),

            // Descripción
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: TextField(
                controller: controladorDescripcion,
                onChanged: (text) {
                  descripcion = text;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Descripción",
                ),
              ),
            ),

            // Lugar
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: TextField(
                controller: controladorLugar,
                onChanged: (text) {
                  lugar = text;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Lugar",
                ),
              ),
            ),

            // Tipo
            Container(
                width: MediaQuery.of(context).size.width - separacionElementos,
                padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
                margin: EdgeInsets.all(10),
                child: DropdownButton(
                  value: tipo,
                  isExpanded: true,
                  items: listaTipos.map<DropdownMenuItem<String>>((String valor) {
                    return DropdownMenuItem<String>(
                      value: valor,
                      child: Text(valor),
                    );
                  }).toList(),
                  onChanged: (String? valor) {
                    setState(() {
                      tipo = valor!;
                    });
                  },
                )
            ),

            // TextField para escribir el paso a añadir
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: TextField(
                controller: controladorPasos,
                onChanged: (text) {
                  paso = text;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Paso",
                ),
              ),
            ),

            // Botones para añadir y quitar pasos
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: borrarPasos,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: Text("Borrar pasos"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      aniadirPaso(paso);
                      controladorPasos.text = "";
                    },
                    child: Text("Añadir pasos"),
                  )
                ],
              ),
            ),

            // Pasos
            Visibility(
              visible: listaPasos.isNotEmpty,
              child: Container(
                height: MediaQuery.of(context).size.width / 2,
                width: MediaQuery.of(context).size.width - separacionElementos,
                padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
                child: ListView(
                  children: listaPasos.map((pasoAux) {
                    return Card(
                        child: Container(
                          padding: EdgeInsets.all(separacionElementos),
                          child: Text((listaPasos.indexOf(pasoAux) + 1).toString() + ". " + pasoAux),
                        )
                    );
                  }).toList(),
                ),
              ),
            ),

            // Botón Crear
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width - separacionElementos,
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: ElevatedButton(
                onPressed: modificarTarea,
                child: Text("Modificar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


