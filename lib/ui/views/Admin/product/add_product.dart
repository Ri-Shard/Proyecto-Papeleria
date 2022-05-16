import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_papeleria/controller/product_controller.dart';
import 'package:proyecto_papeleria/model/product_model.dart';
import 'package:image_picker/image_picker.dart';

class AddProductsPage extends StatefulWidget {
  const AddProductsPage({Key? key}) : super(key: key);

  @override
  _AddProductsPageState createState() => _AddProductsPageState();
}

class _AddProductsPageState extends State<AddProductsPage> {
  FirebaseStorage storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  ProductController productController = ProductController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String? _categoryController;
  String _imageController = " ";
  File? _imageFile;
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  bool pick = false;

  final nameValidator = MultiValidator([
    RequiredValidator(errorText: 'El Nombre es Requerido'),
    MaxLengthValidator(20, errorText: 'Nombre muy largo, pruebe uno mas corto'),
    MinLengthValidator(2, errorText: 'Nombre del producto muy corto')
  ]);
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
  final priceValidator = MultiValidator([
    RequiredValidator(errorText: 'El precio es Requerido'),
    MaxLengthValidator(6, errorText: 'Precio Exhorbitante'),
    MinLengthValidator(3, errorText: 'El precio minimo son 100')
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
                  Text("AGREGAR PRODUCTO",
                      style: GoogleFonts.poppins(
                          decorationColor: Colors.black,
                          decorationStyle: TextDecorationStyle.wavy,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))
                ],
              ),
              Column(
                children: [
                  makeInputId(),
                  makeInputName(),
                  makeInputCate(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      makeInputPrecio(),
                      const SizedBox(
                        width: 12,
                      ),
                      makeInputCantidad()
                    ],
                  )
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
                  height: 50,
                  onPressed: () async {
                    if (_formKey.currentState?.validate() == true) {
                      _getFromGallery();
                    } else {}
                  },
                  color: Colors.cyan,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: const Text(
                    "Agregar Imagen",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
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
                      await storage.ref(_imageController).putFile(
                          _imageFile!,
                          SettableMetadata(customMetadata: {
                            'uploaded_by': 'Admin',
                            'description': 'Some description...'
                          }));
                      String url =
                          await storage.ref(_imageController).getDownloadURL();

                      final producto = ProductoModel(
                          id: _idController.text,
                          name: _nameController.text,
                          quantity: _quantityController.text,
                          category: _categoryController.toString(),
                          image: url,
                          price: _priceController.text);
                      productController.guardarProducto(producto);
                      Get.back();
                      Get.snackbar("Guardado con exito", "El producto fue guardado con Exito");
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

  Widget makeInputCate() {
    return DropdownButtonFormField(
        value: _categoryController,
        hint: const Text("Categoria"),
        items: [
          'Cuadernos',
          'Escritura',
          'Libros Escolares',
          'Utiles Escolares',
          'Papeles',
          'Equipos de Oficina',
          'Archivo'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          _categoryController = value.toString();
        });
  }

  Widget makeInputName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Nombre del Producto',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          validator: nameValidator,
          controller: _nameController,
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

  Widget makeInputPrecio() {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Precio",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: _priceController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'El precio es Requerido';
              } else if (int.parse(value) < 500) {
                return 'El Menor precio son 500 Pesos';
              } else if (int.parse(value) > 999999) {
                return 'Precio Exhorbitante';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
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

  _getFromGallery() async {
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery, maxHeight: 1000, maxWidth: 1800);
    File file = File(image!.path);
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Vista Previa"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.file(file),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                        onPressed: () {
                          _imageController = image.name;
                          _imageFile = file;
                          Get.back();
                        },
                        color: Colors.cyan,
                        child: const Text("Aceptar")),
                    const SizedBox(
                      width: 70,
                    ),
                    MaterialButton(
                        onPressed: () {
                          Get.back();
                          _getFromGallery();
                        },
                        color: Colors.red,
                        child: const Text("Elegir Otra")),
                  ],
                )
              ],
            ),
          );
        });
  }
}
