import 'package:app/clases/material.dart';

class Tarea {
  String idTarea;
  String nombre;
  String descripcion;
  String lugar;
  String tipo;
  List<MaterialComanda> materiales;
  List<String> pasos;

  Tarea(this.idTarea, this.nombre, this.descripcion, this.lugar, this.tipo, this.materiales, this.pasos);
}