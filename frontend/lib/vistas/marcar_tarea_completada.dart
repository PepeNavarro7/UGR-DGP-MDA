import 'package:flutter/material.dart';

/*
 * Clase Marcar Tarea Completada hereda de StatefulWidget para que los distintos
 * elementos sean dinámicos, es decir, pueden cambiar los distintos widgets en
 * función del tipo de tarea a modificar (normal, comanda, menú)
 */

class MarcarTareaCompletada extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorAppBar,
        title: Center(child: Text("Tarea 1")),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisSize:MainAxisSize.min,
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Nombre: ",
                          style: TextStyle(color: Colors.black87, fontSize: 24,fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        Text("Lorem ipsum dolor sit amet",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                            textAlign: TextAlign.left),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                        'assets/imagenes/sin_foto_perfil.jpg',
                        height: 100,
                        width: 100),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                   Column(
                      mainAxisSize:MainAxisSize.min,
                      crossAxisAlignment:CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: [
                            Icon(Icons.timer,color: Colors.blue,),
                            Text(
                              "Tiempo: ",
                              style: TextStyle(color: Colors.black87, fontSize: 20,fontWeight: FontWeight.bold),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        Card(
                          child: Row(
                            children: <Widget> [
                              Column(
                                children: [
                                  Text(
                                    "Quedan",
                                    style: TextStyle(color: Colors.black87, fontSize: 20,fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.justify,

                                  ),
                                  Text(
                                    "5 horas",
                                    style: TextStyle(color: Colors.black87, fontSize: 20,fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.justify,

                                  ),
                                ],

                              ),
                              Image.asset(
                                  'assets/imagenes/sin_foto_perfil.jpg',
                                  height: 80,
                                  width: 80
                              ),

                            ],
                          ),

                        ),
                      ],

                    ),
                  Column(
                    mainAxisSize:MainAxisSize.min,
                    crossAxisAlignment:CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,color: Colors.blue,),
                          Text(
                            "Ubicación: ",
                            style: TextStyle(color: Colors.black87, fontSize: 20,fontWeight: FontWeight.bold),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                      Card(
                        child: Row(
                          children: <Widget> [
                            Column(
                              children: [
                                Text(
                                   "Colegio",
                                   style: TextStyle(color: Colors.black87, fontSize: 20,fontWeight: FontWeight.bold),
                                   textAlign: TextAlign.justify,

                                ),
                                Text(
                                  "San Rafael",
                                  style: TextStyle(color: Colors.black87, fontSize: 20,fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.justify,

                                ),
                              ],

                            ),
                            Image.asset(
                                'assets/imagenes/sin_foto_perfil.jpg',
                                height: 80,
                                width: 80
                            ),

                          ],
                        ),

                      ),
                    ],

                  ),

                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisSize:MainAxisSize.min,
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Pasos: ",
                          style: TextStyle(color: Colors.black87, fontSize: 24,fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "Aqui irian los pasos ",
                          style: TextStyle(color: Colors.black87, fontSize: 24),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Text("DESCRIPCION"),

                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("PRUEBA2"),
                        Image.asset(
                            'assets/imagenes/sin_foto_perfil.jpg',
                            height: 80,
                            width: 80
                        ),

                      ],
                    ),
                  )

                ],

              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0),
              child: ElevatedButton(
                onPressed: (){
                  showDialog(
                      context: context, builder: (BuildContext context){
                        return AlertDialog(
                          content: Container(
                            height: 150,
                            padding: EdgeInsets.fromLTRB(separacionElementos, separacionElementos, separacionElementos, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "¿Has completado la tarea?",
                                  style: TextStyle(color: Colors.black87, fontSize: 20,fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(onPressed: (){}, child: Text("SI", style: TextStyle(fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(primary: Colors.green),),
                                    ElevatedButton(onPressed: (){}, child: Text("NO", style: TextStyle(fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(primary: Colors.red),)
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                    }
                  );
                  },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("COMPLETAR TAREA"),
                    Icon(Icons.check_box,color: Colors.white,),
                    Icon(Icons.emoji_emotions,color: Colors.white,)
                  ],

                ),

              ),
            )
          ],
        ),
      ),
    );
  }
}