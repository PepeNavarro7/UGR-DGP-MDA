import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:app/clases/material.dart';

import 'inicio_profesor.dart';

// Lista de tipo String que contiene todos los lugares de una tarea
final List<String> listaTipos = ["Tarea normal", "Comanda", "Menú"];
FToast ventana_mensajes = FToast();

/*
 * Clase Crear Tarea hereda de StatefulWidget para que los distintos elementos
 * sean dinámicos, es decir, pueden cambiar los distintos widgets en función del
 * tipo de tarea a crear (normal, comanda, menú)
 */

class CrearTarea extends StatefulWidget {
  @override
  _CrearTareaState createState() => _CrearTareaState();
}

class _CrearTareaState extends State<CrearTarea> {
  // Color de la AppBar
  final colorAppBar = Colors.blue;

// Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

  //Variable para controlar los pasos que se añaden
  TextEditingController controladorPasos = new TextEditingController();
  TextEditingController controladorMaterial = new TextEditingController();
  TextEditingController controladorCantidad = new TextEditingController();

  // Datos de la tarea
  String nombre = "";
  String descripcion = "";
  String lugar = "";
  String tipo = listaTipos.first;
  String paso = "";
  String material = "";
  String cantidad = "";
  List<String> listaPasos = [];
  List<MaterialComanda> listaMateriales = [];

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

  // Función que añade un material a la lista de materiales, solo añade si no es null, el texto
  // no son solo espacio y no esta repetido el material
  void aniadirMaterial(String material, String cantidad) {
    setState(() {
      if (material != null && paso.trim().length != 0 && cantidad != null) {
        MaterialComanda aux = new MaterialComanda(material, cantidad);
        listaMateriales.add(aux);
        print(listaMateriales.length);
      }
    });
  }

  // Función que borrar todos los pasos de una lista
  void borrarMateriales() {
    setState(() {
      listaMateriales.clear();
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

  List<String> convert(List<MaterialComanda> lista){
    List<String> aux = [];
    lista.forEach((element) {
      aux.add(element.lista_string());
    });
    return aux;
  }

  void registrarTarea() async{
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
      String jsonMateriales = jsonEncode(convert(listaMateriales));
      //jsonEncode(listaMateriales);

      print("Nombre: $nombre");
      print("Descripción: $descripcion");
      print("Lugar: $lugar");
      print("Tipo: $auxTarea");
      print("Pasos: $jsonPasos");
      print("Materiales: $jsonMateriales");

      try {

        String uri = "http://10.0.2.2/dgp_php_scripts/crear_tarea.php";

        final response = await http.post(Uri.parse(uri), body: {
          "nombre": nombre,
          "descripcion": descripcion,
          "lugar": lugar,
          "tipo": auxTarea,
          "pasos": jsonPasos.toString(),
          "materiales": jsonMateriales.toString()
        });

        print("Tarea registrada");
        FToast().showToast(
            child: Text("Tarea creada",
              style: TextStyle(fontSize: 25, color: Colors.green),
            )
        );
        Navigator.push( context, MaterialPageRoute(builder: (context) => InicioProfesor()), );
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
                onChanged: (text) {
                  nombre = text;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Nombre",
                )
              ),
            ),

            // Descripción
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: TextField(
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

            // TextFields para escribir el material y la cantidad a añadir
            Visibility(
              visible: tipo == "Comanda",
              child: Container(
                padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      controller: controladorMaterial,
                      onChanged: (text) {
                        material = text;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Material",
                      ),
                    ),
                    TextField(
                      controller: controladorCantidad,
                      onChanged: (text) {
                        cantidad = text;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Cantidad",
                      ),
                    )
                  ],
                ),
              ),
            ),

            // Botones para añadir y quitar materiales
            Visibility(
              visible: tipo == "Comanda",
              child: Container(
                padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: borrarMateriales,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      child: Text("Borrar materiales"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          aniadirMaterial(material, cantidad);
                          controladorMaterial.text = "";
                          controladorCantidad.text = "";
                        });
                      },
                      child: Text("Añadir Materiales"),
                    )
                  ],
                ),
              ),
            ),

            // Materiales
            Visibility(
              visible: tipo == "Comanda",
              child: Visibility(
                visible: listaMateriales.isNotEmpty,
                child: Container(
                  height: MediaQuery.of(context).size.width / 2,
                  width: MediaQuery.of(context).size.width - separacionElementos,
                  padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
                  child: ListView(
                    children: listaMateriales.map((materialAux) {
                      return Card(
                          child: Container(
                            padding: EdgeInsets.all(separacionElementos),
                            child: Text(materialAux.cantidad + " " + materialAux.nombre),
                          )
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),


            /***************************************************/
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
                onPressed: () {
                  registrarTarea();
                },
                child: Text("Crear"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


