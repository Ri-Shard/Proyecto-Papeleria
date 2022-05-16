
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_papeleria/controller/order_controller.dart';
import 'package:proyecto_papeleria/services/navigator_services.dart';

class AddSalePage extends StatefulWidget {
  const AddSalePage({Key? key}) : super(key: key);

  @override
  _AddSalePageState createState() => _AddSalePageState();
}

class _AddSalePageState extends State<AddSalePage> {
  OrderController orderController = OrderController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  final idValidator = MultiValidator([
    RequiredValidator(errorText: 'La identificacion es Requerida'),
    MaxLengthValidator(10,
        errorText: 'identificacion muy larga, pruebe una mas corta'),
    MinLengthValidator(4, errorText: 'Minimo 4 Digitos')
  ]);
  final quantityValidator = MultiValidator([
    RequiredValidator(errorText: 'La cantidad es Requerida'),
    MaxLengthValidator(3, errorText: 'Cantidad Exhorbitante a agregar'),
    MinLengthValidator(1, errorText: 'No se puede añadir Menos de 1 producto'),
  ]);

  late double height, width;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      height = constraints.maxHeight;
      width = constraints.maxWidth;
      return Scaffold(
        appBar: AppBar(),
        body: body(),
      );
    });
  }

  Widget body() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 120,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text("AGREGAR VENTA",
                      style: GoogleFonts.poppins(
                          decorationColor: Colors.black,
                          decorationStyle: TextDecorationStyle.wavy,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))
                ],
              ),

              Container(
                padding: const EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: const Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                    )),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () async {
                    if (_formKey.currentState?.validate() == true) {
                      // final producto = ProductoModel(
                      //     id: _idController.text,
                      //     name: _nameController.text,
                      //     quantity: _quantityController.text,
                      //     category: _categoryController.toString(),
                      //     image: url,
                      //     price: _priceController.text);
                      // productController.guardarProducto(producto);
                      Get.back();
                      Get.snackbar("Guardado con exito",
                          "El producto fue guardado con Exito");
                      Get.clearRouteTree();
                    }
                  },
                  color: Colors.cyan.shade300,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: const Text(
                    "Agregar",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInputId() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Id Del Producto',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: _idController,
          validator: idValidator,
          keyboardType: TextInputType.number,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: false,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget makeInputCantidad() {
    return SizedBox(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Cantidad",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: _quantityController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Campo Requerido';
              } else if (int.parse(value) < 1) {
                return 'Cantidad Erronea';
              } else if (int.parse(value) > 999) {
                return 'Valor Exhorbitante';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.number,
            obscureText: false,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
