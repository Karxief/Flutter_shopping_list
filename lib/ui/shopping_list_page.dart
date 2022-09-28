import 'package:flutter/material.dart';
import 'package:shopping_list/http/item_services.dart';
import 'package:shopping_list/model/item.dart';
import 'package:shopping_list/ui/shopping_list_item_page.dart';
import 'dialog/item_dialog.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({Key? key}) : super(key: key);

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  late ItemServices _itemServices;
  @override
  void initState() {
    _itemServices = ItemServices();
    _pageController.addListener(() {
      int currentIndex = _pageController.page!.round();
      if (currentIndex != _selectedIndex) {
        _selectedIndex = currentIndex;
      }
      setState(() {});
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var itemName = await showDialog(
            context: context,
            builder: (BuildContext context) => ItemDialog(),
          );
          if (itemName.isNotEmpty) {
            var item =
                Item(name: itemName, isCompleted: false, isArchived: false);
            setState(() {
              _itemServices.addItem(item.toJson());
            });
          }
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              label: "Shopping List", icon: Icon(Icons.list)),
          BottomNavigationBarItem(label: "History", icon: Icon(Icons.history)),
        ],
        currentIndex: _selectedIndex,
      ),
      body: PageView(controller: _pageController, children: [
        Container(
          color: Colors.white,
        ),
        const ShoppingListItemPage(),
        Container(color: Colors.red)
      ]),
    );
  }

  _onTap(int value) {
    setState(() {
      _selectedIndex = value;
    });
    _pageController.jumpToPage(value);
  }
}
