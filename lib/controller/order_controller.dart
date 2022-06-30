import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:proyecto_papeleria/model/order_model.dart';

import '../model/product_model.dart';

class OrderController extends GetxController {
  RxList<OrderModel> orders = RxList<OrderModel>([]);
  RxList<ProductoModel> preorders = RxList<ProductoModel>([]);
  String ganancias = "0";
  double  ganancias7dias = 0;
@override
  void onInit() {
    super.onInit();
  checkOrder();
  }
    @override
  void onReady() {
    super.onReady();
    checkOrder();
  }

  guardarOrden(OrderModel order) {
    FirebaseFirestore.instance
        .collection("Papeleria")
        .doc("ventas")
        .set({order.dateid: order.toJSONEncodable()}, SetOptions(merge: true));
  }
  guardarGanancias(String ganancia, String ganancias7dias) {
    FirebaseFirestore.instance
        .collection("Papeleria")
        .doc("ganancias")
        .set({"gananciasTotales": ganancia,
        "ganancias7dias": ganancias7dias}, SetOptions(merge: true));
  }
Stream<List<String>> mostrarGananciasTotales(){
 return FirebaseFirestore.instance
        .collection("Papeleria")
        .doc("ganancias")
        .get()
        .asStream()
        .map((event) {
          List<String> gananciasList= [];
          gananciasList.add(event.data()!.values.last .toString());
          gananciasList.add(event.data()!.values.first .toString());
        return gananciasList;
        });
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

  String totalOrden(){
    int auxtotal =0;
    for (var element in preorders) {
      auxtotal = int.parse(element.price)*int.parse(element.quantity) + auxtotal;
    }
  return auxtotal.toString();
  }

 Future<String> gananciasTotales()async {
  
  int auxtotal = 0;
  for (var element in checkOrder()) {
    auxtotal = int.parse(element.price)+auxtotal;
  }
  ganancias = auxtotal.toString();
  return auxtotal.toString();
}
  Future<String> calcularGananciasLast7days() async{
    String dateorder = "";
    double myDouble = 0;
    ganancias7dias = 0;
     checkOrder().forEach((element) {
        dateorder = element.date.toString();
        var parsedDate = DateTime.parse(dateorder);
        Duration _diastotales = DateTime.now().difference(parsedDate);
        if (int.parse(_diastotales.inDays.toString()) < 7) {
          myDouble = double.parse(element.price.toString());
          ganancias7dias = ganancias7dias + myDouble;
        
      }
    });
    return ganancias.toString();
  }
}
