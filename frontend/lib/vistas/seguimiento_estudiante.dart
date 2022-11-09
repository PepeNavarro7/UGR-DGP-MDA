import 'package:flutter/material.dart';

// Lista de tipo String que contiene todas las tareas asignadas y completadas de un alumno
List<String> listaTareasAsignadasCompletadas = <String>[];

// Lista de tipo String que contiene todas las tareas asignadas no completadas de un alumno
List<String> listaTareasAsignadasNoCompletadas = <String>[];

int numeroTareasRealizadas = 0;
int numeroTareasBienRealizadas = 0;
int numeroTareasMuyBienRealizadas = 0;

// Lista de tipo String que contiene todos los alumnos
final List<String> listaAlumnos = <String>["Alumno 1", "Alumno 2", "Alumno 3"];

/*
 * Clase Seguimiento hereda de StatefulWidget para que los distintos elementos
 * sean dinámicos, es decir, pueden cambiar los distintos widgets
 */

class SeguimientoEstudiante extends StatefulWidget {
  @override
  _SeguimientoEstudianteState createState() => _SeguimientoEstudianteState();
}

class _SeguimientoEstudianteState extends State<SeguimientoEstudiante> {
  // Color de la AppBar
  final colorAppBar = Colors.blue;

  // Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

  // Datos de la búsqueda
  String alumno = listaAlumnos.first;
  bool alumnoSeleccionado = false;


  void buscarTareasDeAlumno(String alumno)
  {
    alumnoSeleccionado = true;
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
        title: const Text("Seguimiento de Alumno"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child:
              Row(
                children: [
                  Icon(Icons.person,color: Colors.blue,),
                  Text(
                    "Alumno: ",
                    style: TextStyle(color: Colors.black87, fontSize: 20,fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width - separacionElementos,
                padding: EdgeInsets.fromLTRB(separacionElementos, 0, separacionElementos, 0.0),
                margin: const EdgeInsets.all(10),
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
                      buscarTareasDeAlumno(alumno);
                    });
                  },
                )
            ),

            //Contenedor para tareas asignadas y completadas
            if(alumnoSeleccionado) SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                  separacionElementos, separacionElementos,
                  separacionElementos, 0.0),

              child:
              RichText(
                text: TextSpan(children: <InlineSpan>[
                  const TextSpan(text: "Tareas asignadas completadas\n\n", style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold)),
                  for (var string in listaTareasAsignadasNoCompletadas)
                    TextSpan(text: "\t$string\n\n", style: const TextStyle(color: Colors.black)),
                ]),
              ),
            ),

            //Contenedor para tareas asignadas no completadas
            if(alumnoSeleccionado) SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                  separacionElementos, separacionElementos,
                  separacionElementos, 0.0),

              child:
              RichText(
                text: TextSpan(children: <InlineSpan>[
                  const TextSpan(text: "Tareas asignadas no completadas\n\n", style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold)),
                  for (var string in listaTareasAsignadasNoCompletadas)
                    TextSpan(text: "\t$string\n\n", style: const TextStyle(color: Colors.black)),

                ]),
              ),
            ),

            if(alumnoSeleccionado) Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width - separacionElementos,
              padding: EdgeInsets.fromLTRB(
                  separacionElementos, separacionElementos,
                  separacionElementos, 0.0),
              margin: const EdgeInsets.all(10),
              child: RichText(
                text: const TextSpan(children: <InlineSpan>[
                  TextSpan(text: "Número de tareas bien realizadas:", style: TextStyle(color: Colors.black,fontSize: 16)),
                  TextSpan(text:"\n"),
                  TextSpan(text:"\n"),
                  TextSpan(text: "Número de tareas muy bien realizadas:", style: TextStyle(color: Colors.black,fontSize: 16)),
                  TextSpan(text:"\n"),
                  TextSpan(text:"\n"),
                  TextSpan(text: "Evaluación media:", style: TextStyle(color: Colors.black,fontSize: 16)),
                  TextSpan(text:"\n"),
                  TextSpan(text:"\n"),
                ]),
              ),
            ),
          ], // children
        ),
      ),
    );
  }
}