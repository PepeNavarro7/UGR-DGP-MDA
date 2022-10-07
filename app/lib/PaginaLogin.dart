import 'package:app/PaginaAjustes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/Globales.dart' as Globales;

class PaginaLogin extends StatefulWidget {
  @override
  _PaginaLoginState createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {
  @override
  Widget build(BuildContext context) {
    final EscalaTexto = MediaQuery.of(context).textScaleFactor;
    double TamanioLetra = EscalaTexto * 30;

    void RealizarAccion(String value) {
      switch (value) {
        case 'Ajustes':
          print('Click en Ajustes');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaginaAjustes()),
          );
          break;
      }
    }

    return Scaffold(
      backgroundColor: Globales.ColorFondo,
      appBar: AppBar(
        backgroundColor: Globales.ColorBarraApp,
        title: Text("Página Login"),
        actions: <Widget>[
          PopupMenuButton <String>(
            onSelected: RealizarAccion,
            itemBuilder: (BuildContext context) {
              return {'Ajustes'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: Globales.AlturaBoton,
                  width: Globales.AnchuraBoton,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Globales.ColorTexto,
                      backgroundColor: Globales.ColorBotones,
                      padding: const EdgeInsets.all(16.0),
                      textStyle: TextStyle(fontSize: TamanioLetra),
                    ),
                    onPressed: () {},
                    child: const Text('1'),
                  ),
                ),
                SizedBox(
                  height: Globales.AlturaBoton,
                  width: Globales.AnchuraBoton,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Globales.ColorTexto,
                      backgroundColor: Globales.ColorBotones,
                      padding: const EdgeInsets.all(16.0),
                      textStyle: TextStyle(fontSize: TamanioLetra),
                    ),
                    onPressed: () {},
                    child: const Text('2'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: Globales.AlturaBoton,
                  width: Globales.AnchuraBoton,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Globales.ColorTexto,
                      backgroundColor: Globales.ColorBotones,
                      padding: const EdgeInsets.all(16.0),
                      textStyle: TextStyle(fontSize: TamanioLetra),
                    ),
                    onPressed: () {},
                    child: const Text('3'),
                  ),
                ),
                SizedBox(
                  height: Globales.AlturaBoton,
                  width: Globales.AnchuraBoton,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Globales.ColorTexto,
                      backgroundColor: Globales.ColorBotones,
                      padding: const EdgeInsets.all(16.0),
                      textStyle: TextStyle(fontSize: TamanioLetra),
                    ),
                    onPressed: () {},
                    child: const Text('4'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}