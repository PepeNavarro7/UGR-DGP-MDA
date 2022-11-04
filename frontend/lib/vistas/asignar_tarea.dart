import 'package:flutter/material.dart';

// Lista de tipo String que contiene todas las tareas
final List<String> listaTareas = <String>["Tarea 1", "Tarea 2", "Tarea 3"];

// Lista de tipo String que contiene todos los alumnos
final List<String> listaAlumnos = <String>["Alumno 1", "Alumno 2", "Alumno 3"];

/*
 * Clase Asignar Tarea hereda de StatefulWidget para que los distintos elementos
 * sean dinámicos, es decir, pueden cambiar los distintos widgets
 */

class AsignarTarea extends StatefulWidget {
  @override
  _AsignarTareaState createState() => _AsignarTareaState();
}

class _AsignarTareaState extends State<AsignarTarea> {
  // Color de la AppBar
  final colorAppBar = Colors.blue;

// Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

  // Datos de la asignación
  String tarea = listaTareas.first;
  String alumno = listaAlumnos.first;

  // Cotrolador del campo fecha
  TextEditingController controladorFecha = TextEditingController();

  /*
   * Devuelve un Widget para mostrar el menú de Asignar Tarea, con todos
   * sus elementos. Los elementos que lo conforman son:
   *    1. Nombre de la tarea (Dropdown)
   *    2. Nombre del alumno (Dropdown)
   *    3. Asignar (ElevatedButton)
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorAppBar,
        title: Text("Asignar Tarea"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            // Nombre de la tarea
            Container(
                width: MediaQuery.of(context).size.width - separacionElementos,
                padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
                margin: EdgeInsets.all(10),
                child: DropdownButton(
                  value: tarea,
                  isExpanded: true,
                  items: listaTareas.map<DropdownMenuItem<String>>((String valor) {
                    return DropdownMenuItem<String>(
                      value: valor,
                      child: Text(valor),
                    );
                  }).toList(),
                  onChanged: (String? valor) {
                    setState(() {
                      tarea = valor!;
                    });
                  },
                )
            ),

            // Nombre del alumno
            Container(
                width: MediaQuery.of(context).size.width - separacionElementos,
                padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
                margin: EdgeInsets.all(10),
                child: DropdownButton(
                  value: alumno,
                  isExpanded: true,
                  items: listaAlumnos.map<DropdownMenuItem<String>>((String valor) {
                    return DropdownMenuItem<String>(
                      value: valor,
                      child: Text(valor),
                    );
                  }).toList(),
                  onChanged: (String? valor) {
                    setState(() {
                      alumno = valor!;
                    });
                  },
                )
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Cancelar"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                ),

                ElevatedButton(
                  onPressed: () {},
                  child: Text("Asignar"),
                  style: ElevatedButton.styleFrom(
                    primary: colorBotones,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
