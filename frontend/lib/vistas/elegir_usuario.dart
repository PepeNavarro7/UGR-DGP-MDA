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

    return Container(
      color: Color(0xffffff50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push( context, MaterialPageRoute(builder: (context) => InicioProfesor()));
            },
            child: SizedBox(
              child: Image.asset("assets/imagenes/profesor.png"),
            ),
          ),

          GestureDetector(
            onTap: () async {
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
            child: SizedBox(
              child: Image.asset("assets/imagenes/estudiante.png"),
            ),
          )
        ],
      ),
    );
  }
}
