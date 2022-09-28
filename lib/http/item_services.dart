import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopping_list/model/item.dart';

class ItemServices {
  final String _servicesUrl = "http://kesali-shopping.herokuapp.com/item/";

  Future<List<Item>> fetchtems() async {
    final response = await http.get(Uri.parse(_servicesUrl));
    if (response.statusCode == 200) {
      Iterable items = json.decode(response.body);
      return items.map((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<Item> addItem(String itemJson) async {
    final response = await http.post(
      Uri.parse(_servicesUrl),
      headers: {'content-type': 'application/json'},
      body: itemJson,
    );

    if (response.statusCode == 201) {
      Map item = json.decode(response.body);

      return Item.fromJson(item);
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<Item> editItem(Item item) async {
    final response = await http.patch(
      Uri.parse("$_servicesUrl${item.id}"),
      headers: {'content-type': 'application/json'},
      body: item.toJson(),
    );

    if (response.statusCode == 200) {
      Map item = json.decode(response.body);

      return Item.fromJson(item);
    } else {
      throw Exception("Something went wrong");
    }
  }
}
