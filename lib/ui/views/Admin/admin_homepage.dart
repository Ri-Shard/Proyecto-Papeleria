// // ignore_for_file: unnecessary_const

// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:proyecto_papeleria/controller/product_controller.dart';
// import 'package:proyecto_papeleria/ui/widgets/cardproduct_widget.dart';
// import 'package:proyecto_papeleria/ui/widgets/searchBox_widget.dart';



// // values
// int indexCategory = 0;
// String categoria = "Cuadernos";

// class AdminHomepage extends StatefulWidget {
//   const AdminHomepage({Key? key}) : super(key: key);

//   @override
//   State<AdminHomepage> createState() => AdminHomepageState();
// }


// class AdminHomepageState extends State<AdminHomepage> {
//     ProductController productController  = ProductController();
//   Color colorIcon = Colors.white;
//   Color colorIconText = Colors.black;
//   Color colorText = Colors.black;
//   final MaterialColor colorCanvas = Colors.grey;
//   Color colorAccent = Colors.purple;
//   late MaterialColor colorFond;


//   @override
//   Widget build(BuildContext context) {
//     colorAccent = Colors.cyan;
//     colorText = Colors.black;
//     colorIcon = Colors.black;
//     colorIconText = Colors.grey.shade100;
//     return  Scaffold(
//       body: CustomScrollView(
//             slivers: [
//               sliverAppBar(context: context),
//               SliverToBoxAdapter(
//                   child: FadeInLeft(
//                       child: _buildTitleBubble(),
//                       delay: const Duration(milliseconds: 500))),
//               SliverToBoxAdapter(
//                   child: FadeInLeft(
//                       child: const SearchBox(),
//                       delay: const Duration(milliseconds: 1000))),
//              _gridViewProducts(context: context),
//              _sliverContentInfo()
//             ],
//           ),
//     );
//   }

//   SliverAppBar sliverAppBar({required BuildContext context}) {
//     return SliverAppBar(
//       backgroundColor: colorAccent,
//       primary: true,
//       pinned: true,
//       expandedHeight: 150,
//       flexibleSpace: FlexibleSpaceBar(
//         collapseMode: CollapseMode.pin,
//         centerTitle: false,
//         title: 
//         Text("PAPELERIA",
//             style: GoogleFonts.poppins(
//               decorationColor:colorText,
//               decorationStyle: TextDecorationStyle.wavy,
//                 fontSize: 30.0,
//                 fontWeight: FontWeight.bold,
//                 color: colorIconText)),
//         background: CachedNetworkImage(
//             width: double.infinity*0.5,
//             height: double.infinity,
//             imageUrl: 'https://firebasestorage.googleapis.com/v0/b/proyectopapeleria-aacff.appspot.com/o/kisspng-paper-office-supplies-stationery-business-learning-tools-5aa23cf830d090.7861987015205818802-removebg-preview%20(1).png?alt=media&token=331e161b-2551-43d8-9990-4dbd5ea8724f',
//             fadeInDuration: const Duration(milliseconds: 500),
//             fit: BoxFit.cover,
//             progressIndicatorBuilder: (context, url, downloadProgress) =>
//                 Container(color: Colors.grey[300]),
//             errorWidget: (context, url, error) =>
//                 const Center(child: Icon(Icons.error))),
//       ),
//       leading: buttonRoundAppBar(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           context: context,
//           icon: Icons.arrow_back,
//           edgeInsets: const EdgeInsets.all(8.0)),
//       actions: [
//         buttonRoundAppBar(
//             onPressed: () {},
//             context: context,
//             icon: Icons.shopping_bag_outlined,
//             edgeInsets:
//                 const EdgeInsets.only(right: 2.0, top: 8.0, bottom: 8.0)),
//       ],
//     );
//   }

//   Widget _buildTitleBubble() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Categorias de Productos",
//                   style: TextStyle(
//                       fontSize: 20,
//                       color: colorText,
//                       fontWeight: FontWeight.bold)),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 110.0,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: category.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   children: [
//                     InkWell(
//                         onTap: () {
//                           setState(() {
//                             categoria = category[index]["name"];
//                             indexCategory = index;
//                           });
//                         },
//                         child: Card(
//                             clipBehavior: Clip.antiAlias,
//                             shape: const CircleBorder(),
//                             elevation: 10.0,
//                             margin: const EdgeInsets.all(0.0),
//                             child: CircleAvatar(
//                                 radius: 30,
//                                 child: CircleAvatar(
//                                   radius: indexCategory == index ? 28 : 30,
//                                   backgroundImage: NetworkImage(
//                                       category[index]["url_image"]),
//                                   backgroundColor: Colors.grey,
//                                 )))),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: Text(
//                         category[index]["name"],
//                         style: TextStyle(color: colorText,overflow: TextOverflow.fade),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _gridViewProducts({required BuildContext context}) {
//     SliverGridDelegateWithMaxCrossAxisExtent gridDelegate =
//         const SliverGridDelegateWithMaxCrossAxisExtent(
//       maxCrossAxisExtent: 300.0,
//       crossAxisSpacing: 0.0,
//       mainAxisSpacing: 1.0,
//       childAspectRatio: 200 / 290,
//     );
//     return SliverGrid(
//         gridDelegate: gridDelegate,
//         delegate: SliverChildBuilderDelegate(
//           (BuildContext context, int index) {
//             return FadeInUp(
//               key: Key(DateTime.now().toString()),
//               // child: SingleProductWidget(product: productController.productoporCategoria(categoria)[index]),
//               child: //CardProduct(product: productController.productoporCategoria(categoria)[index]),
//               //delay: const Duration(milliseconds: 500),
//             );
//           },
//           childCount: productController.productoporCategoria(categoria).length,
//         ));
//   }



//   Widget buttonRoundAppBar(
//           {required void Function() onPressed,
//           required BuildContext context,
//           Widget? child,
//           required IconData icon,
//           required EdgeInsets edgeInsets}) =>
//       Material(
//           color: Colors.transparent,
//           child: Center(
//               child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Ink(
//                       decoration: ShapeDecoration(
//                           color: Brightness.dark == Theme.of(context).brightness
//                               ? Colors.black
//                               : Colors.white,
//                           shape: const CircleBorder()),
//                       child: child ??
//                           IconButton(
//                               icon: Icon(icon),
//                               color: Brightness.dark ==
//                                       Theme.of(context).brightness
//                                   ? Colors.white
//                                   : Colors.black,
//                               onPressed: onPressed)))));
//   SliverToBoxAdapter _sliverContentInfo() { 
//     return SliverToBoxAdapter(
//       child: SizedBox(
//         height: 300,width: double.infinity,
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("PAPELERIA".toUpperCase(),style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 20),
//                 const Text("Aplicativo diseñado para el manejo de inventario basico de una papeleria",textAlign: TextAlign.center,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.normal)),
//               ],
//             ),
//           ),
//         )
//       )
//     );
//   }
// }

// List category = [
//   {
//     "name": "Cuadernos",
//     "url_image":
//         "https://firebasestorage.googleapis.com/v0/b/proyectopapeleria-aacff.appspot.com/o/depositphotos_11146681-stock-photo-stack-of-ring-binding-book.jpg?alt=media&token=62de5262-6a5b-4ced-be91-78180da59792",    
//   },
//   {
//     "name": "Escritura",
//     "url_image":
//         "https://firebasestorage.googleapis.com/v0/b/proyectopapeleria-aacff.appspot.com/o/8be6d6d1c8e0620d8b0c594a7316c306-product.jpg?alt=media&token=c585a145-61fe-41c6-86fd-5cf6b445ff18",    
//   },
//   {
//     "name": "Libros Escolares",
//     "url_image":
//         "https://firebasestorage.googleapis.com/v0/b/proyectopapeleria-aacff.appspot.com/o/images.jpg?alt=media&token=21c31f3c-9a1d-4c99-829d-0f674ae5c8cc",    
//   },
//   {   
//     "name": "Utiles Escolares",
//     "url_image":
//         "https://firebasestorage.googleapis.com/v0/b/proyectopapeleria-aacff.appspot.com/o/image_2022-05-03_180519299.png?alt=media&token=97513a4b-aaca-4774-ab60-0aa60a237625",    
//   },
//   {
//     "name": "Papeles",    
//     "url_image":
//         "https://firebasestorage.googleapis.com/v0/b/proyectopapeleria-aacff.appspot.com/o/image_2022-05-03_180630964.png?alt=media&token=239bc158-5d01-4ac7-8b6c-ddf03f0e0be8",  
//   },
//   {
//     "name": "Equipos de Oficina",
//     "url_image":
//         "https://firebasestorage.googleapis.com/v0/b/proyectopapeleria-aacff.appspot.com/o/image_2022-05-03_180803249.png?alt=media&token=ebdbb596-5597-4b6a-bdeb-b5b7937949d8",    
//   },
//   {
//     "name": "Archivo",
//     "url_image":
//         "https://firebasestorage.googleapis.com/v0/b/proyectopapeleria-aacff.appspot.com/o/image_2022-05-03_181102872.png?alt=media&token=ec782f51-1a95-4f12-bed4-1b7fcace7887",
//   },

// ];





