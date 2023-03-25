import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirestore/model/ListItem.dart';
import 'package:get/get.dart';


class UpdateCrudController extends GetxController{

  var textEditController = TextEditingController().obs;
  var textChange = RxString("");
  var list = RxList<ListItem>();

  void clearTextField(){
    textEditController.value.clear();
  }
  void updateTextValue(String stringValue){
    textChange.value = stringValue;
  }

void insertIntoDB(){
    var db = FirebaseFirestore.instance;
    var docList = db.collection("List").doc();

    var listItem = ListItem(
      id: docList.id,
      listName: textChange.value,
      strike: false,
      date: DateTime.now().millisecondsSinceEpoch.toDouble()
    );

    docList.set(listItem.toJson());
}

  Stream<List<ListItem>> readList() => FirebaseFirestore.instance.collection("List").orderBy('date',descending: true).snapshots().map((event) =>
      event.docs.map((e) => ListItem.fromJson(e.data())).toList()
  );

  void updateDB(ListItem listItem,bool value){
    var db = FirebaseFirestore.instance;
    var docList = db.collection("List").doc(listItem.id);
    docList.update({
      "strike":value
    });

  }



}