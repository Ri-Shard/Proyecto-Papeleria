import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_papeleria/model/order_model.dart';
import 'package:proyecto_papeleria/model/product_model.dart';
import 'package:proyecto_papeleria/services/navigator_services.dart';
import 'package:proyecto_papeleria/ui/widgets/cardproduct_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../controller/order_controller.dart';
import '../../../../controller/product_controller.dart';

class DashboardSalePage extends StatefulWidget {
  const DashboardSalePage({Key? key}) : super(key: key);

  @override
  _DashboardSalePageState createState() => _DashboardSalePageState();
}

class _DashboardSalePageState extends State<DashboardSalePage> {
  OrderController orderController = OrderController();
  @override
  void initState()  {
    orderController.checkOrder();
    orderController.gananciasTotales();
                   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
        stream: orderController.mostrarGananciasTotales(),
        builder: (context, snapshot) {
          return Scaffold(
              floatingActionButton: MaterialButton(
                onPressed: () {
                  navigationService.navigateTo("/orderlist");
                },
                color: Colors.cyan,
                child: const Text(
                  "Consultar Listado Ventas",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
              appBar: AppBar(
                elevation: 2.0,
                backgroundColor: Colors.cyan,
                title: const Text('Tablero de Rendimiento',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0)),
                actions:  [IconButton(onPressed: ()async {
               String auxganancias = await orderController.gananciasTotales();
               String auxganancias7dias = await orderController.calcularGananciasLast7days();
               await orderController.guardarGanancias(auxganancias,auxganancias7dias);
               await Future.delayed(const Duration(seconds: 1));
                }, icon: const Icon(Icons.replay) )],

              ),
              body: snapshot.data == null
                  ? const Center(
                      child: Text("No hay Valores para Mostrar"),
                    )
                  : StaggeredGridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      children: <Widget>[
                        _buildTile(Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Ganancias Totales',
                                        style: TextStyle(
                                            color: Colors.blueAccent)),
                                    Text("\$" " " +moneyFormat(snapshot.data![0]),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 34.0))
                                  ],
                                ),
                                Material(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(24.0),
                                    child: const Center(
                                        child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Icon(Icons.attach_money,
                                          color: Colors.white, size: 30.0),
                                    )))
                              ]),
                        )),
                        _buildTile(
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Ganancias Ultimos 7 dias',
                                          style:
                                              TextStyle(color: Colors.green)),
                                      Text("\$" " " +moneyFormat(snapshot.data![1]),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 34.0))
                                    ],
                                  ),
                                  Material(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(24.0),
                                      child: const Center(
                                          child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Icon(Icons.monetization_on,
                                            color: Colors.white, size: 30.0),
                                      )))
                                ]),
                          ),
                        ),
                      ],
                      staggeredTiles: const [
                        StaggeredTile.extent(2, 110.0),
                        StaggeredTile.extent(2, 110.0),
                      ],
                    ));
        });
  }

  Widget _buildTile(Widget child, {Function()? onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: const Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: (() {
                          showModalBottomSheet(
                context: context,
                builder: (context) =>
                    Scaffold(body: Builder(builder: (context) {
                      return ListView(
                        children: [
                          createCartList(),
                        ],
                      );
                    })));
            }),
            child: child));
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
