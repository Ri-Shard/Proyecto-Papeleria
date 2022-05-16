import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/product_model.dart';

class ProductController extends GetxController {
  RxList<ProductoModel> products = RxList<ProductoModel>([]);

  guardarProducto(ProductoModel producto) {
    FirebaseFirestore.instance
        .collection("Papeleria")
        .doc("productos")
        .set({producto.id: producto.toJSONEncodable()}, SetOptions(merge: true));
  }

  Stream<List<ProductoModel>> mostrarProducto() {
    return FirebaseFirestore.instance
        .collection("Papeleria")
        .doc("productos")
        .get()
        .asStream()
        .map((event) {
      List<ProductoModel> productAux = [];
      for (var item in event.data()!.values) {
        productAux.add(ProductoModel(
            name: item["name"],
            id: item["id"],
            category: item["category"],
            quantity: item["quantity"],
            image: item["image"],
            price: item["price"],
            ));
      }
      return productAux;
    });
  }
  List<ProductoModel> checkProduct() {
    products.bindStream(mostrarProducto());
    return products;
  }

  List<ProductoModel> productoporCategoria(String categoria){
    List<ProductoModel> categorias =[];
    checkProduct().forEach((pro) {if (pro.category == categoria){categorias.add(pro);} });
    return categorias;
  }
     }
 
 