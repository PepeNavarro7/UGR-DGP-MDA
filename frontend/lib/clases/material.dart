class MaterialComanda {
  String nombre;
  String cantidad;

  MaterialComanda(this.nombre, this.cantidad);
  String lista_string(){
    return this.cantidad + " " + this.nombre;
  }
}