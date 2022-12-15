import 'package:app/vistas/estudiante/inicio_sesion_estudiante.dart';
import 'package:app/vistas/profesor/inicio_profesor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/clases/estudiante.dart';

List<Estudiante> listaEstudiantes = [];

int NumeroPagina = 0;
int NumeroFilas = 2;
int NumeroColumnas = 2;
int NumeroCasillasTotales = 0;

class PaginaLoginEstudiante extends StatefulWidget {
  PaginaLoginEstudiante(List<Estudiante> lista) {
    listaEstudiantes.clear();
    listaEstudiantes.addAll(lista);
  }

  @override
  _PaginaLoginEstudianteState createState() => _PaginaLoginEstudianteState();
}

class _PaginaLoginEstudianteState extends State<PaginaLoginEstudiante> {

  @override
  Widget build(BuildContext context) {
    double EscalaTexto = MediaQuery.of(context).textScaleFactor;
    double TamanioLetra = EscalaTexto * 20;
    NumeroCasillasTotales = NumeroFilas * NumeroColumnas;

    AlertDialog MenuAjustes() {
      return AlertDialog(
        content: Container(
          height: 150,
          child: Column(
            children: [
              Text('Tamaño iconos:', style: TextStyle(fontSize: TamanioLetra)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      child: Text("2x1", style: TextStyle(fontSize: TamanioLetra, color: Colors.black)),
                      onPressed: () {
                        setState(() {
                          NumeroPagina = 0;
                          NumeroFilas = 2;
                          NumeroColumnas = 1;
                          NumeroCasillasTotales = NumeroFilas * NumeroColumnas;
                        });
                      }
                  ),
                  TextButton(
                      child: Text("4x2", style: TextStyle(fontSize: TamanioLetra, color: Colors.black)),
                      onPressed: () {
                        setState(() {
                          NumeroPagina = 0;
                          NumeroFilas = 4;
                          NumeroColumnas = 2;
                          NumeroCasillasTotales = NumeroFilas * NumeroColumnas;
                        });
                      }
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    void RealizarAccionPopupMenu(String value) {
      switch (value) {
        case "Ajustes":
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return MenuAjustes();
              }
          );
          break;
      }
    }

    void PaginaAnterior() {
      setState(() {
        if(NumeroPagina > 0)
          NumeroPagina--;
      });
    }

    void PaginaSiguiente() {
      setState(() {
        if(NumeroPagina < (listaEstudiantes.length / NumeroCasillasTotales - 1))
          NumeroPagina++;
      });
    }

    Widget PopupMenu () {
      return PopupMenuButton <String>(
        onSelected: RealizarAccionPopupMenu,
        itemBuilder: (BuildContext context) {
          return {'Ajustes'}.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList();
        },
      );
    }

    Widget IconosUsuarios() {
      return Container(
        height: MediaQuery.of(context).size.height * 0.75,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: GridView.builder(
          itemCount: NumeroCasillasTotales,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: NumeroColumnas,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              childAspectRatio: 1.2
          ),
          itemBuilder: (BuildContext context, int index){
            index += NumeroPagina * NumeroCasillasTotales;
            if(index >= listaEstudiantes.length) {
              return Container();
            } else {
              return Container(
                margin: EdgeInsets.all(5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push( context, MaterialPageRoute(builder: (context) =>InicioSesionEstudiante(listaEstudiantes[index])));
                  },
                  child: Image.network(listaEstudiantes[index].foto, fit: BoxFit.cover)
                ),
              );
            }
          },
        ),
      );
    }

    Widget Flechas() {
      return Expanded(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                  visible: NumeroPagina > 0,
                  child: GestureDetector(
                    onTap: PaginaAnterior,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.height * 0.2,
                      child: Icon(Icons.arrow_back, size: MediaQuery.of(context).size.height * 0.2,),
                    ),
                  )
              ),

              Visibility(
                visible: NumeroPagina < (listaEstudiantes.length / NumeroCasillasTotales - 1),
                child: GestureDetector(
                  onTap: PaginaSiguiente,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.height * 0.2,
                    child: Icon(Icons.arrow_forward, size: MediaQuery.of(context).size.height * 0.2),
                  ),
                )
              ),

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
        ),
      );
    }

    return Container(
      color: Color(0xffffff50),
      child: Column(
        children: [
          IconosUsuarios(),
          Flechas()
        ],
      ),
    );

    /*
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Página Login", style: TextStyle(fontSize: TamanioLetra)),
        actions: <Widget>[
          PopupMenu(),
        ],
      ),
      body: Column(
        children: <Widget>[
          IconosUsuarios(),
          Flechas(),
        ],
      ),
    );
     */
  }
}