import 'package:app/clases/tarea_asignada.dart';
import 'package:flutter/material.dart';
import 'package:app/clases/tarea.dart';
import 'package:app/clases/estudiante.dart';
import 'package:http/http.dart' as http;

/*
 * Clase Marcar Tarea Completada hereda de StatefulWidget para que los distintos
 * elementos sean dinámicos, es decir, pueden cambiar los distintos widgets en
 * función del tipo de tarea a modificar (normal, comanda, menú)
 */

TareaAsignada? tareaAsignada;
Tarea? tarea;
Estudiante? estudiante;

List<String> calificaciones = ["Normal", "Bien", "Muy bien"];
String calificacion = "";


class MarcarTareaCompletada extends StatefulWidget {
  MarcarTareaCompletada(TareaAsignada ta, Tarea t, Estudiante e) {
    tareaAsignada = ta;
    tarea = t;
    estudiante = e;
    calificacion = calificaciones.first;
  }

  @override
  _MarcarTareaCompletadaState createState() => _MarcarTareaCompletadaState();
}

class _MarcarTareaCompletadaState extends State<MarcarTareaCompletada> {
  // Color de la AppBar
  final colorAppBar = Colors.blue;

// Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

  Future<void> tareaCompletada() async {
    if (calificacion != "") {
      try {
        String uri = "http://10.0.2.2/dgp_php_scripts/modificar_tarea_asignada.php";

        final response = await http.post(Uri.parse(uri), body: {
          "id_tarea": tarea!.idTarea,
          "id_estudiante": estudiante!.idEstudiante,
          "fecha_inicio": tareaAsignada!.fechaInicio,
          "fecha_fin": tareaAsignada!.fechaFin,
          "completada": "1",
          "calificacion": calificacion
        });

        print("Tarea completada");
      } catch (e) {
        print("Exception: $e");
      }

      Navigator.pop(context);
    } else {
      print("Tarea no completada (falta calificación)");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorAppBar,
        title: Text("Marcar tarea como completada", style: TextStyle(fontSize: 30)),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Estudiante: ", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  Text(estudiante!.nombre + " " + estudiante!.apellidos, style: TextStyle(fontSize: 30)),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tarea: ", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  Text(tarea!.nombre, style: TextStyle(fontSize: 30)),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Descripcion: ", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  Text(tarea!.descripcion, style: TextStyle(fontSize: 30)),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Fecha final:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                  Text(tareaAsignada!.fechaFin, style: TextStyle(fontSize: 30)),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Lugar:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                  Text(tarea!.lugar, style: TextStyle(fontSize: 30)),
                ],
              ),
            ),

            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
                  child: Text("Pasos:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                ),

                Container(
                  width: MediaQuery.of(context).size.width - separacionElementos,
                  padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
                  child: Column(
                    children: tarea!.pasos.map((pasoAux) {
                      return Card(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(separacionElementos),
                            child: Text((tarea!.pasos.indexOf(pasoAux) + 1).toString() + ". " + pasoAux, style: TextStyle(fontSize: 30)),
                          )
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Calificación:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),

                  DropdownButton(
                    value: calificacion,
                    isExpanded: true,
                    items: calificaciones.map<DropdownMenuItem<String>>((String valor) {
                      return DropdownMenuItem<String>(
                        value: valor,
                        child: Text(valor, style: TextStyle(fontSize: 30)),
                      );
                    }).toList(),
                    onChanged: (String? valor) {
                      setState(() {
                        calificacion = valor!;
                      });
                    },
                  )
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(separacionElementos),
              child: ElevatedButton(
                onPressed: tareaCompletada,
                child: Text("Marcar tarea como completada"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
