import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../model/product_model.dart';

class ProductController extends GetxController {
  RxList<Producto> products = RxList<Producto>([]);

  guardarProducto(Producto producto) {
    FirebaseFirestore.instance
        .collection("Producto")
        .doc("productos")
        .set({producto.id: producto.toJSONEncodable()}, SetOptions(merge: true));
  }

  Stream<List<Producto>> mostrarProducto() {
    return FirebaseFirestore.instance
        .collection("Producto")
        .doc("productos")
        .get()
        .asStream()
        .map((event) {
      List<Producto> productAux = [];
      for (var item in event.data()!.values) {
        productAux.add(Producto(
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
  List<Producto> checkProduct() {
    products.bindStream(mostrarProducto());
    return products;
  }

  List<Producto> productoporCategoria(String categoria){
    List<Producto> categorias =[];
    checkProduct().forEach((pro) {if (pro.category == categoria){categorias.add(pro);} });
    return categorias;
  }
     }
 
 