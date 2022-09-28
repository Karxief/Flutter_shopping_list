import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_list/model/item.dart';

class ConfirmDialog extends StatelessWidget {
  final Item item;

  const ConfirmDialog({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(item.name.toString()),
      actions: <Widget>[
        TextButton(onPressed: () {}, child: Text("Cancel")),
        TextButton(
            onPressed: () {},
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.black),
            ),
            style: TextButton.styleFrom(backgroundColor: Colors.green))
      ],
    );
  }
}
