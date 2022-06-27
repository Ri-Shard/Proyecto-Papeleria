import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:proyecto_papeleria/controller/order_controller.dart';

import '../../model/product_model.dart';

class CardProduct extends StatefulWidget {
  final ProductoModel product;
  final Color colorAccent;
  final OrderController controller;
  const CardProduct(
      {Key? key,
      required this.product,
      this.colorAccent = Colors.deepPurple,
      required this.controller})
      : super(key: key);

  @override
  _CardProductState createState() => _CardProductState();
}
  final _formKey = GlobalKey<FormState>();

class _CardProductState extends State<CardProduct>
    with SingleTickerProviderStateMixin {
  Color colorFond = Colors.cyan.shade100.withOpacity(0.1);

  late double _scale;

  late AnimationController _controller;

  /// FUNCTION
  void _tapDown(TapDownDetails details) => _controller.forward();
  void _tapUp(TapUpDetails details) => _controller.reverse();

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController cantidad = TextEditingController();
    _scale = 1 - _controller.value;

    return Transform.scale(
      scale: _scale,
              child: Card(
          elevation: 10.0,
          clipBehavior: Clip.antiAlias,
          color: colorFond.withOpacity(0.5),
          margin: const EdgeInsets.all(12.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: GestureDetector(
            onTapDown: _tapDown,
            onTapUp: _tapUp,
            onTap: () {

              bool repetido = false;
              for (var item in widget.controller.preorders) {
                if (item.id == widget.product.id) {
                  repetido = true;
                } else {
                  repetido = false;
                }
              }
              if (!repetido) {
                
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Form(
                        key: _formKey,
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(20),
                          child: Card(
                            child: Container(
                              width: 300,
                              height: 220,
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [

                                 const Text("Cantidad de productos en Inventario: "),
                                 Text(widget.product.quantity),
                                                                 const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "Cantidad para Agregar a la Preorden",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black87),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextFormField(
                                    controller: cantidad,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'La cantidad es Requerida';
                                      } else if (int.parse(value) < 1) {
                                        return 'Valor incorrecto';
                                      } else if (int.parse(value) >
                                          int.parse(widget.product.quantity)) {
                                        return 'Producto Insuficiente';
                                      }
                                      return null;
                                    },
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    obscureText: false,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState?.validate() ==
                                          true) {
                                        final producto = ProductoModel(
                                            id: widget.product.id,
                                            name: widget.product.name,
                                            quantity: cantidad.text,
                                            category: widget.product.category,
                                            image: widget.product.image,
                                            price: widget.product.price);
                                        widget.controller.preorders.add(producto);
                                        Navigator.pop(context);
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                title: const Text("ERROR"),
                                                content: const Text(
                                                    "Error, Campos vacios"),
                                              );
                                            });
                                      }
                                    },
                                    child: const Text('Ok'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          title: const Text("ERROR"),
                          content: const Text(
                              "El producto ya se encuentra Agregado a la Preorden"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Ok'),
                            ),
                          ]);
                    });
              }
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: widget.product.image,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                  placeholder: (context, url) => Container(
                    color: Colors.grey,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Container()),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Icon(Icons.star,
                                  size: 16,
                                  color: widget.colorAccent.withOpacity(0.7)),
                              Text(widget.product.name,
                                  style: TextStyle(
                                      color:
                                          widget.colorAccent.withOpacity(0.5),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    _buildContentInfo(obj: widget.product),
                  ],
                ),
              ],
            ),
          ),
        ),
      
    );
  }

  Card _buildContentInfo({required var obj}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            width: double.infinity,
            decoration:
                BoxDecoration(color: Colors.grey.shade200.withOpacity(0.3)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text("\$" + widget.product.price,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
