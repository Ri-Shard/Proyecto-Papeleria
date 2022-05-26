import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_papeleria/controller/auth_controller.dart';
import 'package:proyecto_papeleria/services/navigator_services.dart';

class AdminDashBoard extends StatelessWidget {
  AdminDashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController controller = AuthController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {controller.signOut();}, icon: const Icon(Icons.do_disturb_on_rounded)),
        elevation: 0,
        title: Column(
          children: [
            Text("PAPELERIA",
                style: GoogleFonts.poppins(
                    decorationColor: Colors.black,
                    decorationStyle: TextDecorationStyle.wavy,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade100)),
            Text("Opciones de Administrador",
                style: GoogleFonts.actor(
                    decorationColor: Colors.black,
                    decorationStyle: TextDecorationStyle.wavy,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade100))
          ],
        ),
      ),
      body: Stack(
        children: [dashBg, content],
      ),
    );
  }

  get dashBg => Column(
        children: [
          Expanded(
            child: Container(color: Colors.cyan),
            flex: 2,
          ),
          Expanded(
            child: Container(color: Colors.transparent),
            flex: 5,
          ),
        ],
      );

  get content => (Padding(padding:const EdgeInsets.only(top: 80) , child: gridv));
  final List gridItems = [
    {
      "name": "Agregar Producto",
      "route": "/addproduct",
      "url_image":
          "https://firebasestorage.googleapis.com/v0/b/proyectopapeleria-aacff.appspot.com/o/anadir.png?alt=media&token=f8af3f7f-445a-4dc8-8472-b9079f4c8407",
    },
    {
      "name": "Nueva Venta",
      "route": "/addsale",
      "url_image":
          "https://firebasestorage.googleapis.com/v0/b/proyectopapeleria-aacff.appspot.com/o/ventas.png?alt=media&token=59d2d25d-5e9b-4f0c-b26f-09dc1ef8c434",
    },
    {
      "name": "Listado De Productos",
      "route": "/productlist",
      "url_image":
          "https://firebasestorage.googleapis.com/v0/b/proyectopapeleria-aacff.appspot.com/o/prueba.png?alt=media&token=f61a96c4-c1f4-4b1c-8198-36cc583ff76f",
    },
    {
      "name": "Registro Ventas",
      "route": "/addproduct",
      "url_image":
          "https://firebasestorage.googleapis.com/v0/b/proyectopapeleria-aacff.appspot.com/o/negocios-y-finanzas.png?alt=media&token=86660917-03cb-4a8b-83e1-b27c0c542a81",
    },
  ];
  get gridv => GridView.count(
        crossAxisCount: 2,
        children: List.generate(gridItems.length, (index) {
          return _card(gridItems[index]["url_image"], gridItems[index]["name"],
              gridItems[index]["route"]);
        }),
      );

  Widget _card(String urel, String text, String page) {
    return GestureDetector(
      onTap: () {
        navigationService.navigateTo(page);
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                image: NetworkImage(urel),
                height: 150,
                width: 115,
              ),
              Text(
                text,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
