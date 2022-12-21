import 'package:app/clases/estudiante.dart';
import 'package:app/clases/tarea.dart';
import 'package:app/clases/tarea_asignada.dart';
import 'package:flutter/material.dart';

List<Tarea> listaTareas = [];
List<TareaAsignada> listaTareasAsignadas = [];
Estudiante? estudiante;

class VerMiEvaluacion extends StatefulWidget {
  VerMiEvaluacion(Estudiante e, List<Tarea> tareas, List<TareaAsignada> tareasAsignadas) {
    listaTareas.clear();
    listaTareasAsignadas.clear();

    listaTareas.addAll(tareas);
    listaTareasAsignadas.addAll(tareasAsignadas);

    estudiante = e;
  }

  @override
  _VerMiEvaluacionState createState() => _VerMiEvaluacionState();
}


class _VerMiEvaluacionState extends State<VerMiEvaluacion> {
  // Color de la AppBar
  final colorAppBar = Colors.blue;

  // Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

  Widget EvaluacionMedia() {
    double notaBien = 1;
    double notaMuyBien = 2;
    double notaExcelente = 3;
    double nota = 0;
    int numTareas = 0;

    for (TareaAsignada ta in listaTareasAsignadas) {
      if (ta.idEstudiante == estudiante!.idEstudiante) {
        numTareas++;
        if (ta.calificacion == "Bien")
          nota += notaBien;
        else if (ta.calificacion == "Muy Bien")
          nota += notaMuyBien;
        else if (ta.calificacion == "Excelente")
          nota += notaExcelente;
      }
    }

    double media = nota / numTareas;

    if (media > 2) {
      return SizedBox(
        height: 300,
        child: Image.asset("assets/imagenes/evaluacion/excelente.png"),
      );
    } else if (media > 1) {
      return SizedBox(
        height: 300,
        child: Image.asset("assets/imagenes/evaluacion/muyBien.png"),
      );
    } else {
      return SizedBox(
        height: 300,
        child: Image.asset("assets/imagenes/evaluacion/bien.png"),
      );
    }
  }

  Widget TareasCompletadas() {
    int numTareasCompletas = 0;
    int numTareas = 0;

    for (TareaAsignada ta in listaTareasAsignadas) {
      if (ta.idEstudiante == estudiante!.idEstudiante) {
        numTareas++;
        if (ta.completada == "1")
          numTareasCompletas++;
      }
    }

    double porcentaje = numTareasCompletas / numTareas * 100;

    if (porcentaje <= 10) {
      return SizedBox(
        height: 300,
        child: Image.asset("assets/imagenes/cantidadespictogramas/10%.png"),
      );
    } else if (porcentaje <= 15) {
      return SizedBox(
        height: 300,
        child: Image.asset("assets/imagenes/cantidadespictogramas/15%.png"),
      );
    } else if (porcentaje <= 25) {
      return SizedBox(
        height: 300,
        child: Image.asset("assets/imagenes/cantidadespictogramas/25%.png"),
      );
    } else if (porcentaje <= 35) {
      return SizedBox(
        height: 300,
        child: Image.asset("assets/imagenes/cantidadespictogramas/35%.png"),
      );
    } else if (porcentaje <= 50) {
      return SizedBox(
        height: 300,
        child: Image.asset("assets/imagenes/cantidadespictogramas/50%.png"),
      );
    } else if (porcentaje <= 65) {
      return SizedBox(
        height: 300,
        child: Image.asset("assets/imagenes/cantidadespictogramas/65%.png"),
      );
    } else if (porcentaje <= 85) {
      return SizedBox(
        height: 300,
        child: Image.asset("assets/imagenes/cantidadespictogramas/85%.png"),
      );
    } else if (porcentaje <= 95) {
      return SizedBox(
        height: 300,
        child: Image.asset("assets/imagenes/cantidadespictogramas/95%.png"),
      );
    } else {
      return SizedBox(
        height: 300,
        child: Image.asset("assets/imagenes/cantidadespictogramas/100%.png"),
      );
    }


  }

  Widget MostrarEvaluacion() {
    if (estudiante!.accesibilidad == "ninguna")
      return Container(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 300,
                    child: Image.asset("assets/imagenes/evaluacion/evaluacionMedia.png"),
                  ),
                  Icon(Icons.arrow_forward, size: 200),
                  EvaluacionMedia(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 300,
                    child: Image.asset("assets/imagenes/evaluacion/tareasCompletadas.png"),
                  ),
                  Icon(Icons.arrow_forward, size: 200),
                  TareasCompletadas(),
                ],
              ),
            ),
          ],
        ),
      );
    else {
      int numTareasCompletadas = 0;
      int numTareasNoCompletadas = 0;
      int numBien = 0;
      int numMuyBien = 0;
      int numExcelente = 0;

      for (TareaAsignada ta in listaTareasAsignadas) {
        if (ta.idEstudiante == estudiante!.idEstudiante) {
          if (ta.completada == "1") {
            numTareasCompletadas++;
            if (ta.calificacion == "Bien")
              numBien++;
            else if (ta.calificacion == "Muy Bien")
              numMuyBien++;
            else if (ta.calificacion == "Excelente")
              numExcelente++;
          }
          else
            numTareasNoCompletadas++;
        }

      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Contenedor para tareas asignadas y completadas
          Container(
            padding: EdgeInsets.fromLTRB(
                separacionElementos, separacionElementos, separacionElementos,
                0.0),
            child: Text("Tareas asignadas completadas: " +
                numTareasCompletadas.toString(), style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold)),
          ),

          Container(
            padding: EdgeInsets.fromLTRB(
                separacionElementos, separacionElementos, separacionElementos,
                0.0),
            child: Text("Tareas asignadas no completadas: " +
                numTareasNoCompletadas.toString(),
                style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold)),
          ),

          Container(
            padding: EdgeInsets.fromLTRB(
                separacionElementos, separacionElementos, separacionElementos,
                0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Tareas \"Bien\" realizadas: " + numBien.toString(),
                    style: TextStyle(fontSize: 30)),
                Text("Tareas \"Muy Bien\" realizadas: " +
                    numMuyBien.toString(),
                    style: TextStyle(fontSize: 30)),
                Text("Tareas \"Excelente\" realizadas: " +
                    numExcelente.toString(),
                    style: TextStyle(fontSize: 30)),
              ],
            ),
          ),
        ],
      );
    }
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xffffff50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MostrarEvaluacion(),
            MostrarBotones(),
          ],
        ),
      )
    );
  }
}