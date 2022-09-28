import 'dart:convert';

class Item {
  int? id;
  String? name;
  bool? isCompleted;
  bool? isArchived;

  Item({this.id, this.name, this.isCompleted, this.isArchived});

  factory Item.fromJson(Map<dynamic, dynamic> map) => Item(
      id: map["id"],
      name: map["name"],
      isCompleted: map["isCompleted"],
      isArchived: map["isArchived"]);

  String toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["isCompleted"] = isCompleted;
    map["isArchived"] = isArchived;
    return json.encode(map);
  }
}
