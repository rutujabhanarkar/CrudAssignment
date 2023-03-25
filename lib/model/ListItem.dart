

import 'dart:convert';

ListItem listItemFromJson(String str) => ListItem.fromJson(json.decode(str));

String listItemToJson(ListItem data) => json.encode(data.toJson());

class ListItem {
  ListItem({
    this.id,
    this.listName,
    this.strike,
    this.date,
    this.description,
    this.image,
  });

  String? id;
  String? listName;
  bool? strike;
  double? date;
  String? description;
  String? image;

  factory ListItem.fromJson(Map<String, dynamic> json) => ListItem(
    id: json["id"],
    listName: json["listName"],
    strike: json["strike"],
    date: json["date"]?.toDouble(),
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "listName": listName,
    "strike": strike,
    "date": date,
    "description": description,
    "image": image,
  };
}

