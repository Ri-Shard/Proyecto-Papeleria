// ignore: file_names
import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  // var
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.grey.shade400,
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade900
                    : Colors.grey.shade100
              ], begin: Alignment.centerLeft, end: Alignment.centerRight),
              borderRadius: BorderRadius.circular(20)),
          child: ListTile(
            leading: const Icon(Icons.search, color: Colors.white),
            title: TextField(
              controller: textEditingController,
              decoration: const InputDecoration(
                  hintText: 'Buscar',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white)),
              onChanged: (_) {
                setState(() {});
              },
            ),
            trailing: IconButton(
              icon: CircleAvatar(
                  backgroundColor: textEditingController.text != ""
                      ? Colors.grey
                      : Theme.of(context).primaryColor,
                  child: Icon(
                      textEditingController.text != ""
                          ? Icons.clear
                          : Icons.filter_list_outlined,
                      color: Colors.white)),
              onPressed: () {
                setState(() {
                  textEditingController.clear();
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}