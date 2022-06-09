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
          "assets/images/anadir.png",
    },
    {
      "name": "Nueva Venta",
      "route": "/addsale",
      "url_image":
          "assets/images/NuevaVentaImage.png",
    },
    {
      "name": "Listado De Productos",
      "route": "/productlist",
      "url_image":
          "assets/images/ListadoProductosImage.png",
    },
    {
      "name": "Registro Ventas",
      "route": "/addproduct",
      "url_image":
          "assets/images/ListadoVentasImage.png",
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
                image: AssetImage(urel),
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
