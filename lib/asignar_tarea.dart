import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        title: Center(child: Text("Modificar Tarea")),
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
                ),
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

            // Fecha
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: TextField(
                  controller: controladorFecha,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Fecha de la tarea",
                    fillColor: Colors.green,
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? fechaSeleccionada = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:DateTime.now(),
                      lastDate: DateTime(2050),
                    );

                    if (fechaSeleccionada != null) {
                      setState(() {
                        String fechaConFormato = DateFormat("dd/MM/yyyy").format(fechaSeleccionada);
                        controladorFecha.text = fechaConFormato.toString();
                        fecha = controladorFecha.text;
                      });
                    }
                  }
              ),
            ),

            // Lugar
            Container(
                width: MediaQuery.of(context).size.width - separacionElementos,
                padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
                margin: EdgeInsets.all(10),
                child: DropdownButton(
                  value: lugar,
                  isExpanded: true,
                  items: listaLugares.map<DropdownMenuItem<String>>((String valor) {
                    return DropdownMenuItem<String>(
                      value: valor,
                      child: Text(valor),
                    );
                  }).toList(),
                  onChanged: (String? valor) {
                    setState(() {
                      lugar = valor!;
                    });
                  },
                )
            ),

            // Pasos
            Container(
              width: MediaQuery.of(context).size.width - separacionElementos,
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
            ),

            // Botones Cancelar y Modificar
            Container(
              width: MediaQuery.of(context).size.width - separacionElementos,
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: Row(
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
                    child: Text("Modificar"),
                    style: ElevatedButton.styleFrom(
                      primary: colorBotones,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
