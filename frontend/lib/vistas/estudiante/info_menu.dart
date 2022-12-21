import 'dart:convert';

import 'package:app/clases/estudiante.dart';
import 'package:app/clases/material.dart';
import 'package:app/clases/tarea.dart';
import 'package:app/clases/tarea_asignada.dart';
import 'package:app/vistas/estudiante/pasar_menu.dart';
import 'package:app/vistas/estudiante/tareas_estudiante.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Tarea? tarea;
List<String> clases = ["A", "B", "C", "D"];

class InfoMenu extends StatefulWidget {
  InfoMenu(Tarea t) {
    tarea = t;
  }

  @override
  _InfoMenuState createState() => _InfoMenuState();
}

class _InfoMenuState extends State<InfoMenu> {
  // Color de la AppBar
  final colorAppBar = Colors.blue;

// Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

  final int numClases = clases.length;

  Widget MostrarClases() {
    return Container(
      height: MediaQuery.of(context).size.width * 0.85,
      child: GridView.builder(
        itemCount: numClases,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            childAspectRatio: 1.2
        ),
        itemBuilder: (BuildContext context, int index){
          if(index >= clases.length) {
            return Container();
          } else {
            return GestureDetector(
              onTap: () {
                Navigator.push( context, MaterialPageRoute(builder: (context) => PasarMenu(clases[index])));
              },
              child: Container(
                margin: EdgeInsets.all(5),
                color: Colors.white,
                child: Center(child: Text(clases[index], style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold)))
              ),
            );
          }
        },
      ),
    );
  }

  Widget MostrarBotones() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Image.asset("assets/imagenes/salir.png"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(separacionElementos),
          width: MediaQuery.of(context).size.width,
          color: Color(0xffffff50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tarea!.nombre.toUpperCase(), style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold)),
              Text(tarea!.descripcion.toUpperCase(), style: TextStyle(fontSize: 50)),

              MostrarClases(),
              MostrarBotones(),
            ],
          )
      ),
    );
  }
}
