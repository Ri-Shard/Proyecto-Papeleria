import 'package:proyecto_papeleria/services/navigator_services.dart';
import 'package:flutter/material.dart';


class BottomNavigatorBar extends StatefulWidget {
  const BottomNavigatorBar({Key? key, this.colorAccent = Colors.purple}) : super(key: key);

   final Color colorAccent;

  @override
  _BottomNavigatorBarState createState() => _BottomNavigatorBarState();
}

class _BottomNavigatorBarState extends State<BottomNavigatorBar> {
  var currentIndex = 1;
  List<IconData> listOfIcons = [
    Icons.shopping_bag ,
    Icons.home_rounded,
    Icons.person_rounded
  ];

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.all(20),
      height: _width * .140,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.15),
                blurRadius: 30,
                offset: const Offset(0, 10))
          ],
          borderRadius: BorderRadius.circular(50)),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: listOfIcons.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: _width * .024),
        itemBuilder: (context, index) => 
        GestureDetector(
          onTap: () {
            setState(() {
              currentIndex = index;
              switch (currentIndex) {
                case 0:navigationService.navigateTo('/adminhome');                  
                  break;
                case 1:navigationService.navigateTo('/');                  
                  break;
                case 2: navigationService.navigateTo('/userhome');                 
                  break;
                default:
              }
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 1500),
                curve: Curves.fastLinearToSlowEaseIn,
                margin: EdgeInsets.only(
                    bottom: index == currentIndex ? 0 : _width * .029,
                    right: _width * .0422,
                    left: _width * .0422),
                width: _width * .128,
                height: index == currentIndex ? _width * .014 : 0,
                decoration: BoxDecoration(
                    color: widget.colorAccent,
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(10))),
              ),
              Icon(listOfIcons[index],
                  size: _width * .076,
                  color: index == currentIndex
                      ? widget.colorAccent
                      : Colors.black38),
              SizedBox(height: _width * .01),
            ],
          ),
        ),
      ),
    );
  }
}