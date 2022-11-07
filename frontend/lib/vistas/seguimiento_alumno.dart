import 'package:flutter/material.dart';

// Lista de tipo String que contiene todas las tareas asignadas y completadas de un alumno
 List<String> listaTareasAsignadasCompletadas = <String>[];

// Lista de tipo String que contiene todas las tareas asignadas no completadas de un alumno
List<String> listaTareasAsignadasNoCompletadas = <String>[];


// Lista de tipo String que contiene todos los alumnos
final List<String> listaAlumnos = <String>["Alumno 1", "Alumno 2", "Alumno 3"];

/*
 * Clase Seguimiento hereda de StatefulWidget para que los distintos elementos
 * sean dinámicos, es decir, pueden cambiar los distintos widgets
 */

class Seguimiento extends StatefulWidget {
  @override
  _SeguimientoState createState() => _SeguimientoState();
}

class _SeguimientoState extends State<Seguimiento> {
  // Color de la AppBar
  final colorAppBar = Colors.blue;

// Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

  // Datos de la asignación
  String alumno = listaAlumnos.first;
  bool alumno_seleccionado = false;

  // Cotrolador del campo fecha
  TextEditingController controladorFecha = TextEditingController();

  void buscar_tareas_de_alumno(String alumno)
  {
    alumno_seleccionado = true;
    listaTareasAsignadasCompletadas = <String>["Tarea 1", "Tarea 2", "Tarea 3"];
    listaTareasAsignadasNoCompletadas = <String>["Tarea A", "Tarea B", "Tarea C"];
  }




  /*
   * Devuelve un Widget para mostrar el menú de seguimiento del alumno, con todos
   * sus elementos. Los elementos que lo conforman son:
   *    1. Nombre del alumno (Dropdown)
   *    2. Lista de tareas asignadas completadas
   *    3. Lista de tareas asignadas no completadas
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorAppBar,
        title: Text("Seguimiento de Alumno"),
      ),
      body: SafeArea(
        child: ListView(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
                  child: Text("Seleccione el Alumno")),
              Container(
                  width: MediaQuery.of(context).size.width - separacionElementos,
                  padding: EdgeInsets.fromLTRB(separacionElementos, 0, separacionElementos, 0.0),
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
                        buscar_tareas_de_alumno(alumno);
                      });
                    },
                  )
              ),

              //Contenedor para tareas asignadas y completadas
              if(alumno_seleccionado) Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - separacionElementos,
                    padding: EdgeInsets.fromLTRB(
                        separacionElementos, separacionElementos,
                        separacionElementos, 0.0),
                    margin: EdgeInsets.all(10),
                child: RichText(
                  text: TextSpan(children: <InlineSpan>[
                    for (var string in listaTareasAsignadasCompletadas)
                      TextSpan(text: string, style: TextStyle(color: Colors.black)),
                  ]),
                ),
                ),

                //Contenedor para tareas asignadas no completadas
              if(alumno_seleccionado) Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - separacionElementos,
                  padding: EdgeInsets.fromLTRB(
                      separacionElementos, separacionElementos,
                      separacionElementos, 0.0),
                  margin: EdgeInsets.all(10),
                  child: RichText(
                      text: TextSpan(children: <InlineSpan>[
                        for (var string in listaTareasAsignadasNoCompletadas)
                          TextSpan(text: string, style: TextStyle(color: Colors.black)),
                      ]),
                    ),
              )
            ], // children
        ),
      ),
    );
  }
}
