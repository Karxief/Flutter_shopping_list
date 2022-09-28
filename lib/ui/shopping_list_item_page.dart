import 'package:flutter/material.dart';
import 'package:shopping_list/http/item_services.dart';
import 'package:shopping_list/model/item.dart';
import 'package:shopping_list/ui/dialog/confirm_dialog.dart';

class ShoppingListItemPage extends StatefulWidget {
  const ShoppingListItemPage({Key? key}) : super(key: key);

  @override
  _ShoppingListItemPageState createState() => _ShoppingListItemPageState();
}

class _ShoppingListItemPageState extends State<ShoppingListItemPage> {
  late ItemServices _itemServices;

  @override
  void initState() {
    _itemServices = ItemServices();
    super.initState();
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _itemServices.fetchtems(),
      builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                Item item = snapshot.data![index];
                return GestureDetector(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          ConfirmDialog(item: item),
                    );
                  },
                  child: CheckboxListTile(
                    title: Text(item.name.toString()),
                    onChanged: (value) async {
                      item.isCompleted = item.isCompleted;
                      await _itemServices.editItem(item);
                      setState(() {});
                    },
                    value: item.isCompleted,
                  ),
                );
              },
              itemCount: snapshot.data!.length);
        }
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
