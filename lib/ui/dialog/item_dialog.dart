import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ItemDialog extends StatefulWidget {
  const ItemDialog({Key? key}) : super(key: key);

  @override
  State<ItemDialog> createState() => _ItemDialogState();
}

class _ItemDialogState extends State<ItemDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _itemName;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Add your Shopping List."),
      children: [
        Container(
          padding: EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              Form(
                  key: _formKey,
                  child: TextFormField(
                    maxLength: 31,
                    onSaved: (newValue) => _itemName = newValue,
                    autofocus: true, // Klavyenin otomatik açılması için
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Validation error.";
                      }
                    },
                  )),
              SizedBox(height: 18),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.lightGreen[100],
                  textStyle: const TextStyle(
                      fontSize: 16, fontStyle: FontStyle.italic),
                ),
                onPressed: _saveForm,
                child: const Text('Save item to shopping list.'),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _saveForm() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, _itemName);
    }
  }
}
