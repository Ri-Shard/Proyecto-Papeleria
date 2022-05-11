import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_papeleria/services/navigator_services.dart';

class AdminDashBoard extends StatelessWidget {
  const AdminDashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  get content => Column(
        children: [
          header,
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: _card(
                "https://firebasestorage.googleapis.com/v0/b/proyectopapeleria-aacff.appspot.com/o/anadir.png?alt=media&token=f8af3f7f-445a-4dc8-8472-b9079f4c8407",
                "Agregar Producto","/addproduct"),
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: _card(
                "https://firebasestorage.googleapis.com/v0/b/proyectopapeleria-aacff.appspot.com/o/prueba.png?alt=media&token=f61a96c4-c1f4-4b1c-8198-36cc583ff76f",
                "Listado De Productos","/productlist"),
          ),
        ],
      );

  get header => ListTile(
        contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 50),
        title: Text("PAPELERIA",
            style: GoogleFonts.poppins(
                decorationColor: Colors.black,
                decorationStyle: TextDecorationStyle.wavy,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade100)),
        subtitle: Text("Opciones de Administrador",
            style: GoogleFonts.actor(
                decorationColor: Colors.black,
                decorationStyle: TextDecorationStyle.wavy,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade100)),
      );

  // get grid => Expanded(
  //       child: Container(
  //         padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
  //         child: GridView.count(
  //           crossAxisSpacing: 16,
  //           mainAxisSpacing: 16,
  //           crossAxisCount: 2,
  //           childAspectRatio: .90,
  //           children: List.generate(4, (index) {
  //             return Column(
  //               children:[
  //               _card("https://firebasestorage.googleapis.com/v0/b/proyectopapeleria-aacff.appspot.com/o/anadir.png?alt=media&token=f8af3f7f-445a-4dc8-8472-b9079f4c8407",index),
  //             ]);
  //           }),
  //         ),
  //       ),
  //     );

  Widget _card(String urel, String text,String page) {
    return GestureDetector(
      onTap: (){navigationService.navigateTo(page);},
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
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
