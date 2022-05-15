import 'package:flutter/material.dart';
import 'package:proyecto_papeleria/controller/product_controller.dart';
import 'package:proyecto_papeleria/model/product_model.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
ProductController productController = ProductController(); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Listado Productos                          Cantidad"),),
      body: 
          _body(context,productController),
    );
  }
  Widget _body(BuildContext context, ProductController controller) {
  return StreamBuilder<List<ProductoModel>>(
      stream: controller.mostrarProducto(),
      builder: (context, snapshot) {
        return snapshot.data == null
            ? const Center(
                child: Text("No hay Productos Agregados"),
              )
            : ListView.builder(
                itemCount: snapshot.data!.length,
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (BuildContext context, int i) {
                  return ListTile(
                    onTap: () { },
                    leading: CircleAvatar(
                      child: Text(
                        "${i + 1}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.cyan,
                    ),
                    title: Text(snapshot.data![i].name),
                    subtitle: Text(snapshot.data![i].id),
                    trailing: Text(snapshot.data![i].quantity),
                  );
                });
      });
}
}