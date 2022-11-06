import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Lista de tipo String que contiene todos los lugares de una tarea
final List<String> listaLugares = ["Lugar 1", "Lugar 2", "Lugar 3"];

/*
 * Clase Crear Tarea hereda de StatefulWidget para que los distintos elementos
 * sean dinámicos, es decir, pueden cambiar los distintos widgets en función del
 * tipo de tarea a crear (normal, comanda, menú)
 */

class CrearTarea extends StatefulWidget {
  @override
  _CrearTareaState createState() => _CrearTareaState();
}

class _CrearTareaState extends State<CrearTarea> {
  // Color de la AppBar
  final colorAppBar = Colors.blue;

// Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

  // Datos de la tarea
  String nombre = "";
  String descripcion = "";
  String fecha = "";
  String lugar = listaLugares.first;
  String paso = "";
  List<String> listaPasos = [];

  // Cotrolador del campo fecha
  TextEditingController controladorFecha = TextEditingController();

  // Función que añade un paso a la lista de pasos, solo añade si no es null, el texto
  // no son solo espacio y no esta repetido el paso
  void aniadirPaso(String paso) {
    setState(() {
      if (paso != null && paso.trim().length != 0 && !listaPasos.contains(paso)) {
        listaPasos.add(paso);
        print(listaPasos.length);
      }
    });
  }

  // Función que borrar todos los pasos de una lista
  void borrarPasos() {
    setState(() {
      listaPasos.clear();
    });
  }

  /*
   * Devuelve un Widget para mostrar el menú de Crear Tarea, con todos
   * sus elementos. Los elementos que lo conforman son:
   *    1. Nombre (TextField)
   *    2. Descripción (TextField)
   *    3. Fecha (DatePicker)
   *    4. Lugar (Dropdown)
   *    5. Pasos (ListView)
   *    8. Botones Cancelar y Crear (ElevatedButtons en un Row)
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorAppBar,
        title: Text("Crear Tarea"),
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
            
            // TextField para escribir el paso a añadir
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: TextField(
                onChanged: (text) {
                  paso = text;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Paso",
                ),
              ),
            ),

            // Botones para añadir y quitar pasos
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: borrarPasos,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: Text("Borrar pasos"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      aniadirPaso(paso);
                    },
                    child: Text("Añadir pasos"),
                  )
                ],
              ),
            ),

            // Pasos
            Visibility(
              visible: listaPasos.isNotEmpty,
              child: Container(
                height: MediaQuery.of(context).size.width / 2,
                width: MediaQuery.of(context).size.width - separacionElementos,
                padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
                child: ListView(
                  children: listaPasos.map((pasoAux) {
                    return Card(
                      child: Container(
                        padding: EdgeInsets.all(separacionElementos),
                        child: Text((listaPasos.indexOf(pasoAux) + 1).toString() + ". " + pasoAux),
                      )
                    );
                  }).toList(),
                ),
              ),
            ),

            // Botón Crear
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width - separacionElementos,
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Crear"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


