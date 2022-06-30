import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_papeleria/model/order_model.dart';
import 'package:proyecto_papeleria/model/product_model.dart';
import 'package:proyecto_papeleria/ui/widgets/cardproduct_widget.dart';

import '../../../../controller/order_controller.dart';
import '../../../../controller/product_controller.dart';

class AddSalePage extends StatefulWidget {
  const AddSalePage({Key? key}) : super(key: key);

  @override
  _AddSalePageState createState() => _AddSalePageState();
}

class _AddSalePageState extends State<AddSalePage> {
  ProductController productController = ProductController();
  OrderController orderController = OrderController();

  late double height, width;
  @override
  void initState() {
    productController.checkProduct();
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
        onPressed: () {
          if (orderController.preorders.isEmpty) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: const Text("ERROR"),
                    content: const Text("Seleccione al menos 1 producto"),
                  );
                });
          } else {
            showModalBottomSheet(
                context: context,
                builder: (context) =>
                    Scaffold(body: Builder(builder: (context) {
                      return ListView(
                        children: <Widget>[
                          createHeader(),
                          createSubTitle(),
                          createCartList(),
                          footer(context)
                        ],
                      );
                    })));
          }
        },
        icon: const Icon(Icons.shopify),
        label: const Text('Realizar venta'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  body() {
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
                    return CardProduct(
                      product: snapshot.data![i],
                      controller: orderController,
                    );
                  },
                );
        });
  }

  createHeader() {
    return Container(
      alignment: Alignment.topLeft,
      child: const Text(
        "CONFIRMAR VENTA",
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      margin: const EdgeInsets.only(left: 12, top: 12),
    );
  }

  footer(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: const Text(
                  "Total",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 30),
                child: Text(
                  "\$" " " + moneyFormat(orderController.totalOrden()),
                  style: const TextStyle(color: Colors.cyan, fontSize: 14),
                ),
              ),
            ],
          ),
          MaterialButton(
            onPressed: () async{
              OrderModel order = OrderModel(
                  date: DateTime.now().toString(),
                  dateid: DateTime.now().millisecond.toString(),
                  products: orderController.preorders,
                  price: orderController.totalOrden());

              int auxcantidad = 0;
              for (var preorders in orderController.preorders) {
                for (var productoID in productController.products) {
                  if (preorders.id == productoID.id) {
                    auxcantidad = int.parse(productoID.quantity) -
                        int.parse(preorders.quantity);
                  }
                  if (auxcantidad == 0) {
                    productController.eliminarProducto(preorders);
                  } else {
                     ProductoModel producto = ProductoModel(
                        name: preorders.name,
                        id: preorders.id,
                        category: preorders.category,
                        quantity: auxcantidad.toString(),
                        image: preorders.image,
                        price: preorders.price);
                     productController.guardarProducto(producto);
                  }
                }
              }
              orderController.guardarOrden(order);
              orderController.preorders.clear();


              setState(()  {
                 productController.mostrarProducto();
              });

               String auxganancias = await orderController.gananciasTotales();
               String auxganancias7dias = await orderController.calcularGananciasLast7days();
               await orderController.guardarGanancias(auxganancias,auxganancias7dias);
               await Future.delayed(const Duration(seconds: 1));
              Navigator.pop(context);
              
                showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: const Text("ENHORABUENA"),
                    content: const Text("Venta Guardada"),
                  );
                });
            },
            color: Colors.cyan,
            padding:
                const EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: const Text(
              "Confirmar",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      margin: const EdgeInsets.only(top: 16),
    );
  }

  createSubTitle() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        orderController.preorders.length.toString() + " Productos",
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      margin: const EdgeInsets.only(left: 12, top: 4),
    );
  }

  createCartList() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, position) {
        return createCartListItem(position);
      },
      itemCount: orderController.preorders.length,
    );
  }

  createCartListItem(int position) {
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            children: <Widget>[
              Container(
                margin:
                    const EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(14)),
                    color: Colors.blue.shade200,
                    image: DecorationImage(
                        image: NetworkImage(
                            orderController.preorders[position].image),
                        fit: BoxFit.fill)),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(right: 8, top: 4),
                        child: Text(
                          orderController.preorders[position].name,
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Text(
                        orderController.preorders[position].category,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "\$" " " +
                                moneyFormat(
                                    orderController.preorders[position].price),
                            style: const TextStyle(color: Colors.cyan),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  color: Colors.grey.shade200,
                                  padding: const EdgeInsets.only(
                                      bottom: 2, right: 12, left: 12),
                                  child: Text(
                                    orderController
                                        .preorders[position].quantity,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                flex: 100,
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              setState(() {
                orderController.preorders
                    .remove(orderController.preorders[position]);
                Navigator.pop(context);
              });
            },
            child: Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 10, top: 8),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: Colors.cyan),
            ),
          ),
        )
      ],
    );
  }

  String moneyFormat(String price) {
    if (price.length > 2) {
      var value = price;
      value = value.replaceAll(RegExp(r'\D'), '');
      value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
      return value;
    }
    return "";
  }
}
