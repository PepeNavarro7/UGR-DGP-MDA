import 'package:flutter/material.dart';

/*
 * Clase Modificar Tarea hereda de StatefulWidget para que los distintos elementos
 * sean dinámicos, es decir, pueden cambiar los distintos widgets en función del
 * tipo de tarea a modificar (normal, comanda, menú)
 */

class TareaCompletada extends StatefulWidget {
  @override
  _TareaCompletadaState createState() => _TareaCompletadaState();
}

class _TareaCompletadaState extends State<TareaCompletada> {
  // Color de la AppBar
  final colorAppBar = Colors.blue;

// Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorAppBar,
        title: Center(child: Text("Tarea completada")),
      ),
      body: SafeArea(
        child: ListView(
          children: [

          ],
        ),
      ),
    );
  }
}
