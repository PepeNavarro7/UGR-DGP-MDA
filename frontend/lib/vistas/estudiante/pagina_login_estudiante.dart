import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

int NumeroPagina = 0;
int NumeroFilas = 4;
int NumeroColumnas = 2;
int NumeroCasillasTotales = 0;

class PaginaLoginEstudiante extends StatefulWidget {
  @override
  _PaginaLoginEstudianteState createState() => _PaginaLoginEstudianteState();
}

class _PaginaLoginEstudianteState extends State<PaginaLoginEstudiante> {
  List<String> Usuarios = ['José', 'María', 'Paco', 'Laura', 'Alex', 'Marta', 'Antonio', 'Pablo', 'Inés', 'Jorge', 'David', 'Ana', 'Lucía'];

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
        if(NumeroPagina < (Usuarios.length / NumeroCasillasTotales - 1))
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

    Widget Autenticacion() {
      return Scaffold(
        appBar: AppBar(
          title: Text("Página Login", style: TextStyle(fontSize: TamanioLetra)),
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
        ),
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
            if(index >= Usuarios.length) {
              return Container();
            } else {
              return Container(color: Colors.greenAccent,
                  margin: EdgeInsets.all(2),
                  child: Center(
                    child: TextButton(
                      child: Text(Usuarios[index], style: TextStyle(fontSize: TamanioLetra, color: Colors.black)),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Autenticacion()));
                      },
                    ),
                  )
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
              SizedBox(
                  height: 100,
                  width: 100,
                  child: Visibility(
                    visible: NumeroPagina > 0,
                    child: IconButton(
                      icon: new Icon(Icons.arrow_back, size: 70.0),
                      onPressed: PaginaAnterior,
                    ),
                  )
              ),
              SizedBox(
                  height: 100,
                  width: 100,
                  child: Visibility(
                    visible: NumeroPagina < (Usuarios.length / NumeroCasillasTotales - 1),
                    child: IconButton(
                      icon: new Icon(Icons.arrow_forward, size: 70.0),
                      onPressed: PaginaSiguiente,
                    ),
                  )
              ),
            ],
          ),
        ),
      );
    }

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
  }
}