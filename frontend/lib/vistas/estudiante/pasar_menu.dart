
import 'package:flutter/material.dart';

String nombreClase = "";
List<String> menus = ["bajoColesterol", "basal", "diabetico", "regimen", "sinCarne", "sinCerdo", "triturado"];
List<int> cantidades = [];
int NumeroPagina = 0;

class PasarMenu extends StatefulWidget {
  PasarMenu(String nombre) {
    nombreClase = nombre;

    menus.forEach((element) {
      cantidades.add(0);
    });
  }

  @override
  _PasarMenuState createState() => _PasarMenuState();
}

class _PasarMenuState extends State<PasarMenu> {
  // Color de la AppBar
  final colorAppBar = Colors.blue;

// Color de los ElevatedButton
  final colorBotones = Colors.blue;

  // Distancia en píxeles que estará separados los elementos unos de otros
  final double separacionElementos = 20.0;

  void PaginaAnterior() {
    setState(() {
      NumeroPagina--;
    });
  }

  void PaginaSiguiente() {
    setState(() {
      NumeroPagina++;
    });
  }

  Widget MostrarMenus() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: GridView.builder(
        itemCount: 4,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            childAspectRatio: 1.2
        ),
        itemBuilder: (BuildContext context, int index){
          index += NumeroPagina * 4;
          if(index >= menus.length) {
            return Container();
          } else {
            return Container(
              margin: EdgeInsets.all(5),
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      child: Image.asset("assets/imagenes/menus/${menus[index]}.png"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (cantidades[index] > 0)
                                cantidades[index]--;
                            });
                          },
                          icon: Icon(Icons.remove, size: 80, color: Colors.red),
                        ),
                        Text(cantidades[index].toString(), style: TextStyle(fontSize: 70)),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              cantidades[index]++;
                            });
                          },
                          icon: Icon(Icons.add, size: 80, color: Colors.green),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget MostrarBotones() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Visibility(
              visible: NumeroPagina > 0,
              child: GestureDetector(
                onTap: PaginaAnterior,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.height * 0.2,
                  child: Icon(Icons.arrow_back, size: MediaQuery.of(context).size.height * 0.2),
                ),
              )
          ),
          Visibility(
              visible: NumeroPagina < menus.length / 4 - 1,
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
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Image.asset("assets/imagenes/correcto.png"),
            ),
          ),
          GestureDetector(
            onTap: () {
              for (int i = 0; i < cantidades.length; i++)
                cantidades[i] = 0;

              Navigator.pop(context);
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Image.asset("assets/imagenes/salir.png"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(separacionElementos),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xffffff50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MostrarMenus(),
            MostrarBotones(),
          ],
        ),
      ),
    );
  }
}
