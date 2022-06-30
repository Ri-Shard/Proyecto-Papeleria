import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_papeleria/controller/order_controller.dart';
import 'package:proyecto_papeleria/controller/product_controller.dart';
import 'package:proyecto_papeleria/model/order_model.dart';
import 'package:proyecto_papeleria/model/product_model.dart';
import 'package:proyecto_papeleria/ui/views/Admin/product/update_product.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  OrderController  orderController = OrderController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Listado Ventas"),
      ),
      body: _body(context, orderController),
    );
  }

  Widget _body(BuildContext context, OrderController controller) {
    return StreamBuilder<List<OrderModel>>(
        stream: controller.mostrarOrden(),
        builder: (context, snapshot) {
          return snapshot.data == null
              ? const Center(
                  child: Text("No hay Ventas Realizadas"),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.length,
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (BuildContext context, int i) {
                    final item = snapshot.data![i];
                    return _buildTile(
                    Padding
                    (
                      padding: const EdgeInsets.all(24.0),
                      child: Row
                      (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>
                        [
                          Column
                          (
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: 
                            [
                               const Text('Precio Venta', style:  TextStyle(color: Colors.cyan)),
                              Text("\$" " " +moneyFormat(snapshot.data![i].price), style:  const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0)),
                               const Text('Fecha Venta', style:  TextStyle(color: Colors.cyan)),
                              Text(snapshot.data![i].date, style:  const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20.0))
                            ],
                          ),
                          Material
                          (
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(24.0),
                            child: const Center
                            (
                              child: Padding
                              (
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.shopping_bag, color: Colors.white, size: 30.0),
                              )
                            )
                          )
                        ]
                      ),
                    ),
                  );
        
                  });
        });
  }
    Widget _buildTile(Widget child, {Function()? onTap}) {
    return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: const Color(0x802196F3),
      child: InkWell
      (
        // Do onTap() if it isn't null, otherwise do print()
        onTap: onTap != null ? () => onTap() : () { print('Not set yet'); },
        child: child
      )
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
