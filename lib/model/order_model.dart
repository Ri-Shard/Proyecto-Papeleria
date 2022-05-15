
import 'package:proyecto_papeleria/model/product_model.dart';

class OrderModel {
  final String date;
  final String dateid;
  final List<ProductoModel> products;
  final String price;

  OrderModel({required this.date, required this.dateid, required this.products,required this.price});  

    toJSONEncodable() {
    Map<String, dynamic> m =  {};

    m['date'] = date;
    m['dateid'] = dateid;
    m['products'] = toJSONEncodableList(products);
    m['price'] = price;

    return m;
  }
      toJSONEncodableList(List<ProductoModel> product) {
    List<Map<String, dynamic>> m =  [];

    for (var item in product) {
     Map<String,dynamic> aux = {};   
    aux['name'] = item.name;
    aux['id'] = item.id;
    aux['category'] = item.category;
    aux['image'] = item.image;
    aux['quantity'] = item.quantity;
    aux['price'] = item.price;
    m.add(aux);
    }
    return m;
  }
}