import 'package:flutter/material.dart';

import 'package:app/Globales.dart' as Globales;

class PaginaAjustes extends StatefulWidget {
  @override
  _PaginaAjustesState createState() => _PaginaAjustesState();
}

class _PaginaAjustesState extends State<PaginaAjustes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Globales.ColorFondo,
      appBar: AppBar(
        backgroundColor: Globales.ColorBarraApp,
        title: Text("Ajustes"),
      ),
    );
  }
}