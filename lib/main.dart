import 'package:flutter/material.dart';
import 'package:shopping_list/ui/shopping_list_page.dart';

void main(List<String> args) => runApp(ShoppingListApp());

class ShoppingListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShoppingListPage(),
      theme: ThemeData(primarySwatch: Colors.green),
    );
  }
}
