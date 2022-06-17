import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_papeleria/services/navigator_services.dart';
import 'package:proyecto_papeleria/ui/views/Admin/admin_dashboard.dart';
import 'package:proyecto_papeleria/ui/views/Admin/admin_homepage.dart';
import 'package:proyecto_papeleria/ui/views/Admin/product/add_product.dart';
import 'package:proyecto_papeleria/ui/views/Admin/product/list_product.dart';
import 'package:proyecto_papeleria/ui/views/Auth/login_page.dart';
import 'package:proyecto_papeleria/ui/views/Admin/sales/add_sale.dart';

// import 'package:proyecto_papeleria/ui/views/Admin/product/update_product.dart';

import 'controller/auth_controller.dart';
import 'controller/product_controller.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Future<FirebaseApp> initialization = Firebase.initializeApp();
  await initialization.then((value){
    Get.put(ProductController());
    Get.put(AuthController());

  });
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
            return GetMaterialApp(
              title: 'Papeleria',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.cyan,
              ),
                                initialRoute: '/',
                              
                  routes: {
                    //Admin
                   // '/adminhome': (context) => const AdminHomepage(),
                    '/admindash': (context) =>   AdminDashBoard(),
                    //Products
                    '/addproduct': (context) =>  const AddProductsPage(),
                    '/productlist': (context) =>  const ProductListPage(),
                    //Order
                      '/addsale': (context) =>   AddSalePage(),
                    // '/productlist': (context) =>  const ProductListPage(),
                  },
                  navigatorKey: navigationService.navigatorKey,
                  	  home: 
                           LoginPage()
                        
                      );
        
  }                     
 }
      





