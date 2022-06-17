import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:proyecto_papeleria/model/order_model.dart';

import '../model/product_model.dart';

class OrderController extends GetxController {
  RxList<OrderModel> orders = RxList<OrderModel>([]);
  RxList<ProductoModel> preorders = RxList<ProductoModel>([]);

  guardarOrden(OrderModel order) {
    FirebaseFirestore.instance
        .collection("Papeleria")
        .doc("ventas")
        .set({order.dateid: order.toJSONEncodable()}, SetOptions(merge: true));
  }

  Stream<List<OrderModel>> mostrarOrden() {
    return FirebaseFirestore.instance
        .collection("Papeleria")
        .doc("ventas")
        .get()
        .asStream()
        .map((event) {
      List<OrderModel> orderAux = [];
      for (var item in event.data()!.values) {
        List<ProductoModel> productsAux = [];
        for (var product in item["products"]) {
          productsAux.add(ProductoModel(
            name: product["name"],
            id: product["id"],
            category: product["category"],
            image: product["image"],
            price: product["price"],
            quantity: product["quantity"],
          ));
        }
        orderAux.add(OrderModel(
            date: item["date"],
            dateid: item["dateid"],
            price: item["price"],
            products: productsAux));
      }
      return orderAux;
    });
  }

  List<OrderModel> checkOrder() {
    orders.bindStream(mostrarOrden());
    return orders;
  }


}
