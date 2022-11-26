import 'package:app/vistas/estudiante/inicio_estudiante.dart';
import 'package:app/vistas/estudiante/pagina_login_estudiante.dart';
import 'package:app/vistas/profesor/inicio_profesor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app/clases/estudiante.dart';


class ElegirUsuario extends StatefulWidget {

  @override
  _ElegirUsuarioState createState() => _ElegirUsuarioState();
}

class _ElegirUsuarioState extends State<ElegirUsuario> {
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
        title: Text("Elegir usuario"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push( context, MaterialPageRoute(builder: (context) => InicioProfesor()), );
                },
                child: Text("Profesor"),
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0.0),
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () async {
                  List<Estudiante> listaEstudiantes = [];

                  try {
                    String uri = "http://10.0.2.2/dgp_php_scripts/obtener_estudiantes.php";
                    final response = await http.get(Uri.parse(uri));

                    if (response.statusCode == 200) {
                      var estudiantesJSON = json.decode(response.body);
                      for (var estudiante in estudiantesJSON) {
                        String foto = "http://10.0.2.2/" + estudiante['foto'].substring(3);
                        Estudiante estudianteAux = new Estudiante(estudiante['id_estudiante'], estudiante['nombre'], estudiante['apellidos'], estudiante['email'], estudiante['acceso'], estudiante['accesibilidad'], estudiante['password_usuario'], foto);
                        listaEstudiantes.add(estudianteAux);
                      }
                    }
                  } catch (e) {
                    print("Exception: $e");
                  }

                  Navigator.push( context, MaterialPageRoute(builder: (context) =>PaginaLoginEstudiante(listaEstudiantes)));
                },
                child: Text("Estudiante"),
              ),
            ),
          ],
        ),
      )
    );
  }
}
