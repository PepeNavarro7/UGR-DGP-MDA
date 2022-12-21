import 'dart:convert';

import 'package:app/clases/estudiante.dart';
import 'package:app/clases/material.dart';
import 'package:app/clases/tarea.dart';
import 'package:app/clases/tarea_asignada.dart';
import 'package:app/vistas/estudiante/tareas_estudiante.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Tarea? tarea;
int numeroPaso = 0;

class InfoTarea extends StatefulWidget {
  InfoTarea(Tarea t) {
    tarea = t;
  }

  @override
  _InfoTareaState createState() => _InfoTareaState();
}

class _InfoTareaState extends State<InfoTarea> {
  // Color de la AppBar
  final colorAppBar = Colors.blue;

// Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

  void PasoSiguiente() {
    setState(() {
      numeroPaso++;
    });
  }

  void PasoAnterior() {
    setState(() {
      numeroPaso--;
    });
  }

  Widget MostrarPasos() {
    if (tarea!.pasos.isEmpty)
      return Text("NO HAY PASOS", style: TextStyle(fontSize: 50));
    else
      return Text(tarea!.pasos[numeroPaso], style: TextStyle(fontSize: 50));
  }

  Widget MostrarBotones() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Visibility(
              visible: numeroPaso > 0,
              child: GestureDetector(
                onTap: PasoAnterior,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.height * 0.2,
                  child: Icon(Icons.arrow_back, size: MediaQuery.of(context).size.height * 0.2),
                ),
              )
          ),
          Visibility(
              visible: numeroPaso < tarea!.pasos.length - 1,
              child: GestureDetector(
                onTap: PasoSiguiente,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.height * 0.2,
                  child: Icon(Icons.arrow_forward, size: MediaQuery.of(context).size.height * 0.2),
                ),
              )
          ),
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
            Text(tarea!.lugar.toUpperCase(), style: TextStyle(fontSize: 50)),
            Text("PASOS:", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
            MostrarPasos(),
            MostrarBotones(),
          ],
        )
      ),
    );
  }
}
