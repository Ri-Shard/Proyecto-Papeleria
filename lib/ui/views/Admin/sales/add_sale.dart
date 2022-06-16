
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_papeleria/model/product_model.dart';
import 'package:proyecto_papeleria/ui/widgets/cardproduct_widget.dart';

import '../../../../controller/product_controller.dart';

class AddSalePage extends StatefulWidget {
  const AddSalePage({Key? key}) : super(key: key);

  @override
  _AddSalePageState createState() => _AddSalePageState();
}

class _AddSalePageState extends State<AddSalePage> {
    ProductController productController = ProductController();
  late double height, width;
  @override
  void initState() {
    super.initState();
  }

// preorders
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text("NUEVA VENTA",
                style: GoogleFonts.poppins(
                    decorationColor: Colors.black,
                    decorationStyle: TextDecorationStyle.wavy,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade100)),
            Text("Seleccione los productos",
                style: GoogleFonts.actor(
                    decorationColor: Colors.black,
                    decorationStyle: TextDecorationStyle.wavy,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade100))
          ],
        ),        
      ),
      body: body(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.shopify),
        label: const Text('Realizar venta'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  body(){
  return StreamBuilder<List<ProductoModel>>(
        stream: productController.mostrarProducto(),
        builder: (context, snapshot) {
          return snapshot.data == null
              ? const Center(
                  child: Text("No hay Productos Agregados"),
                )
              : GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20),
                itemCount: snapshot.data!.length,
                 itemBuilder: (BuildContext context, int i) {
                  return CardProduct(product: snapshot.data![i]);
                 } ,
              );
               }
  );
  }
}
