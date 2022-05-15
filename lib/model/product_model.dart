
class ProductoModel {
  final String name;
  final String id;
  final String category;
  final String image;
  final String quantity;
  final String price;

  ProductoModel({required this.name, required this.id, required this.category, required this.quantity,required this.image,required this.price});  

    toJSONEncodable() {
    Map<String, dynamic> m =  {};

    m['name'] = name;
    m['id'] = id;
    m['category'] = category;
    m['image'] = image;
    m['quantity'] = quantity;
    m['price'] = price;

    return m;
  }

}