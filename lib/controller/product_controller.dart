import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../model/product_model.dart';

class ProductController extends GetxController {
  RxList<ProductoModel> products = RxList<ProductoModel>([]);
    List<String> listID =[];

ProductoModel productoModel = ProductoModel(category: '', id: '', image: '', name: '', price: '', quantity: '');
  guardarProducto(ProductoModel producto) {  
      FirebaseFirestore.instance.collection("Papeleria").doc("productos").set(
          {producto.id: producto.toJSONEncodable()}, SetOptions(merge: true));    
  }
  ProductoModel saveProductListTile(ProductoModel producto) {      
    productoModel =  producto;
    return producto;
  }

  Future<String> eliminarProducto(ProductoModel productD) async{

try{
    final docRef = FirebaseFirestore.instance.collection("Papeleria").doc("productos");

final updates = <String, dynamic>{
  productD.id: FieldValue.delete(),
};

_deleteImage(productD.image);
docRef.update(updates);
    Get.snackbar("Alerta", "Eliminado Correctamente");
    return "Eliminado Correctamente";
}catch(e){
      Get.snackbar("Alerta", "Error al Eliminar");
return e.toString();
}
  }

  Stream<List<ProductoModel>> mostrarProducto(){
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

_deleteImage(String image) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  await storage.refFromURL(image).delete();
}
  List<ProductoModel> checkProduct() {
    products.bindStream(mostrarProducto());
    return products;
  }

  List<ProductoModel> productoporCategoria(String categoria) {
    List<ProductoModel> categorias = [];
    checkProduct().forEach((pro) {
      if (pro.category == categoria) {
        categorias.add(pro);
      }
    });
    return categorias;
  }
}
