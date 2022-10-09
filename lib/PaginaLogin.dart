import 'package:flutter/material.dart';

int NumeroPagina = 0;
int NumeroFilas = 4;
int NumeroColumnas = 2;
int NumeroCasillasTotales = 0;

class PaginaLogin extends StatefulWidget {
  @override
  _PaginaLoginState createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {
  List<String> Usuarios = ['José', 'María', 'Paco', 'Laura', 'Alex', 'Marta', 'Antonio', 'Pablo', 'Inés', 'Jorge', 'David', 'Ana', 'Lucía'];

  @override
  Widget build(BuildContext context) {
    double EscalaTexto = MediaQuery.of(context).textScaleFactor;
    double TamanioLetra = EscalaTexto * 20;
    NumeroCasillasTotales = NumeroFilas * NumeroColumnas;

    void RealizarAccion(String value) {
      switch (value) {
        case "Ajustes":
          showDialog(
              context: context,
              builder: (BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Página Login", style: TextStyle(fontSize: TamanioLetra)),
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
      body: Column(
        children: <Widget>[
          Container(
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
                  return Container(color: Colors.red,
                      margin: EdgeInsets.all(2),
                      child: Center(
                        child: Text(Usuarios[index],
                            style: TextStyle(fontSize: TamanioLetra)),
                      )
                  );
                }
              },
            ),
          ),
          Expanded(
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
          ),
        ],
      ),
    );
  }
}