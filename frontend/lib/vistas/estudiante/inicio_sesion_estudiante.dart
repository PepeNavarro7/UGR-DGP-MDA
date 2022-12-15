import 'package:app/vistas/estudiante/inicio_estudiante_pictogramas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/clases/estudiante.dart';
import 'package:fluttertoast/fluttertoast.dart';

Estudiante? estudiante;

List<String> listaPictogramasNoClave = [];
List<String> listaPictogramasClave = [];
List<String> listaPictogramas = [];
List<String> listaPictogramasSeleccionados = [];

FToast ventana_mensajes = FToast();

class InicioSesionEstudiante extends StatefulWidget {
  InicioSesionEstudiante(Estudiante e) {
    estudiante = e;

    listaPictogramasNoClave.clear();
    listaPictogramasClave.clear();
    listaPictogramas.clear();
    listaPictogramasSeleccionados.clear();

    String urlPicrogramas = "http://10.0.2.2/pictogramas_password/" + estudiante!.nombre.replaceAll(' ', '') + estudiante!.apellidos.replaceAll(' ', '') + "/";
    listaPictogramasNoClave.add(urlPicrogramas + "pictograma_no_clave_1.jpg");
    listaPictogramasNoClave.add(urlPicrogramas + "pictograma_no_clave_2.jpg");

    listaPictogramasClave.add(urlPicrogramas + "clave/pictograma_clave_1.jpg");
    listaPictogramasClave.add(urlPicrogramas + "clave/pictograma_clave_2.jpg");
    listaPictogramasClave.add(urlPicrogramas + "clave/pictograma_clave_3.jpg");
    listaPictogramasClave.add(urlPicrogramas + "clave/pictograma_clave_4.jpg");

    listaPictogramas.addAll(listaPictogramasClave);
    listaPictogramas.addAll(listaPictogramasNoClave);

    listaPictogramas.shuffle();
  }

  @override
  _InicioSesionEstudianteState createState() => _InicioSesionEstudianteState();
}

class _InicioSesionEstudianteState extends State<InicioSesionEstudiante> {

  // Color de la AppBar
  final colorAppBar = Colors.blue;

// Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

  // Variable donde se almacena la contraseña introducida por el estudiante
  String password = "";

  bool pictogramasClaveSeleccionados() {
    bool resultado = true;

    if (listaPictogramasSeleccionados.length < listaPictogramasClave.length)
      resultado = false;

    for (String pictograma in listaPictogramasSeleccionados)
      if (!listaPictogramasClave.contains(pictograma))
        resultado = false;

    return resultado;
  }

  bool loginCorrecto() {
    bool resultado = false;
    ventana_mensajes.init(context);

    if (estudiante!.acceso == "Alfanumerico") {
      if (estudiante!.password == password)
        resultado = true;
      else
        FToast().showToast(
            child: Text("Contraseña incorrecta",
              style: TextStyle(fontSize: 25, color: Colors.red),
            )
        );
    } else if (estudiante!.acceso == "Pictogramas") {
      if (pictogramasClaveSeleccionados())
        resultado = true;
      else
        FToast().showToast(
            child: Text("Pictogramas incorrectos",
              style: TextStyle(fontSize: 25, color: Colors.red),
            )
        );
    }

    return resultado;
  }

  Widget AccesoAlfanumerico() {
    return Column(
      children: [
        Center(
          child: Text("Hola ${estudiante!.nombre} ${estudiante!.apellidos}", style: TextStyle(color: Colors.blue, fontSize: 50, fontWeight: FontWeight.bold))
        ),

        Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(100, 30, 100, 30),
          child: TextField(

            obscureText: true,
            onChanged: (text) {
              password = text;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Contraseña",
            ),
          ),
        ),
      ],
    );
  }

  Widget AccesoPictogramas() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: GridView.builder(
        itemCount: listaPictogramas.length,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 2.0,
        ),
        itemBuilder: (BuildContext context, int index){
          return Container(
            margin: EdgeInsets.all(2),
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (!listaPictogramasSeleccionados.contains(listaPictogramas[index]))
                      listaPictogramasSeleccionados.add(listaPictogramas[index]);
                    else
                      listaPictogramasSeleccionados.remove(listaPictogramas[index]);
                  });
                },
                child: Image.network(
                  listaPictogramas[index],
                  fit: BoxFit.cover,
                  color: Colors.white.withOpacity(listaPictogramasSeleccionados.contains(listaPictogramas[index]) ? 1.0 : 0.5),
                  colorBlendMode: BlendMode.modulate,)
            ),
          );
        },
      ),
    );
  }

  Widget Botones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.width * 0.4,
            child: Image.asset("assets/imagenes/salir.png"),
          ),
        ),

        GestureDetector(
          onTap: () {
            if(loginCorrecto())
              Navigator.push( context, MaterialPageRoute(builder: (context) =>InicioEstudiantePictograma(estudiante!)));
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.width * 0.4,
            child: Image.asset("assets/imagenes/acceder.png"),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffffff50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            estudiante!.acceso == "Alfanumerico" ? AccesoAlfanumerico() : AccesoPictogramas(),
            Botones(),
          ],
        ),
      )
    );
  }
}