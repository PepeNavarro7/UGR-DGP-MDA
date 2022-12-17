import 'package:app/clases/estudiante.dart';
import 'package:app/vistas/elegir_usuario.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Escolar'
      ),
      home: ElegirUsuario(),
    );
  }
}