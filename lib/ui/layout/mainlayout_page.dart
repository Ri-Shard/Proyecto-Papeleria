import 'package:flutter/material.dart';
import 'package:proyecto_papeleria/ui/widgets/bottomNavigatorbar_widget.dart';

  class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color colorAccent =Colors.cyan;
    return Scaffold(
      body: Stack(
        children: [
          child,
          Column(children: [
            Expanded(child: Container()),
            BottomNavigatorBar(colorAccent: colorAccent)
          ]),
        ],
      ),
    );
  }
}
