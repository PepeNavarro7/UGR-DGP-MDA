import 'package:flutter/material.dart';

class PaginaAjustes extends StatefulWidget {

  PaginaAjustes();

  @override
  _PaginaAjustesState createState() => _PaginaAjustesState();
}

class _PaginaAjustesState extends State<PaginaAjustes> {
  @override
  Widget build(BuildContext context) {
    double EscalaTexto = MediaQuery.of(context).textScaleFactor;
    double TamanioLetra = EscalaTexto * 20;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Ajustes', style: TextStyle(fontSize: TamanioLetra)),
      ),
      body: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      content: Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text('Tamaño de iconos', style: TextStyle(fontSize: TamanioLetra)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    setState(() {

                                    });
                                  },
                                  child: Text('2x1', style: TextStyle(fontSize: TamanioLetra, color: Colors.black)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {

                                    });
                                  },
                                  child: Text('4x2', style: TextStyle(fontSize: TamanioLetra, color: Colors.black)),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                  );
                },
              );
            },
            child: Card(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Numero Iconos:', style: TextStyle(fontSize: TamanioLetra)),
                      Text('8', style: TextStyle(fontSize: TamanioLetra))
                    ],
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}