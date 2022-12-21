import 'package:app/clases/estudiante.dart';
import 'package:flutter/material.dart';

Estudiante? estudiante;

class VerPerfilEstudiante extends StatefulWidget {
  VerPerfilEstudiante(Estudiante e) {
    estudiante = e;
  }

  @override
  _VerPerfilEstudianteState createState() => _VerPerfilEstudianteState();
}

class _VerPerfilEstudianteState extends State<VerPerfilEstudiante> {
  // Color de la AppBar
  final colorAppBar = Colors.blue;

// Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

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
        padding: EdgeInsets.all(separacionElementos),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xffffff50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.height * 0.15,
              backgroundImage: NetworkImage("http://10.0.2.2/fotos_estudiantes/${estudiante!.nombre}${estudiante!.apellidos.replaceAll(' ', '')}.jpg"),
            ),
            Text("NOMBRE: " + estudiante!.nombre.toUpperCase() + " " + estudiante!.apellidos.toUpperCase(), style: TextStyle(fontSize: 50)),
            Text("ACCESO: " + estudiante!.acceso.toUpperCase(), style: TextStyle(fontSize: 50)),
            if(estudiante!.acceso == "Alfanumerico") Text("CONTRASEÑA: " + estudiante!.password, style: TextStyle(fontSize: 50)),
            MostrarBotones(),
          ],
        ),
      ),
    );
  }
}
