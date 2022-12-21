import 'package:app/clases/tarea.dart';
import 'package:app/vistas/estudiante/info_comanda.dart';
import 'package:app/vistas/estudiante/info_menu.dart';
import 'package:app/vistas/estudiante/info_tarea.dart';
import 'package:flutter/material.dart';

List<Tarea> listaTareas = [];

class TareasEstudiante extends StatefulWidget {
  TareasEstudiante(List<Tarea> tareas) {
    listaTareas.clear();
    listaTareas.addAll(tareas);
  }

  @override
  _TareasEstudianteState createState() => _TareasEstudianteState();
}

class _TareasEstudianteState extends State<TareasEstudiante> {
  // Color de la AppBar
  final colorAppBar = Colors.blue;

// Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

  Widget MostrarTareas() {
    return Container(
      margin: EdgeInsets.all(separacionElementos),
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: listaTareas.map((tarea) {
          return GestureDetector(
            onTap: () {
              if (tarea.tipo == "N")
                Navigator.push( context, MaterialPageRoute(builder: (context) => InfoTarea(tarea)));

              else if (tarea.tipo == "C")
                Navigator.push( context, MaterialPageRoute(builder: (context) => InfoComanda(tarea)));

              else
                Navigator.push( context, MaterialPageRoute(builder: (context) => InfoMenu(tarea)));
            },
            child: Card(
              color: Colors.white,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.all(separacionElementos),
                  child: Text(tarea.nombre.toUpperCase(), style: TextStyle(fontSize: 50))
              ),
            ),
          );
        }).toList(),
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
        color: Color(0xffffff50),
        child: Column(
          children: [
            MostrarTareas(),
            MostrarBotones()
          ],
        ),
      )
    );
  }
}