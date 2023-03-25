import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirestore/model/ListItem.dart';
import 'package:get/get.dart';

import '../ListDetail/listDetail.dart';

class UpdateCrudController extends GetxController {
  var textEditController = TextEditingController().obs;
  var textChange = RxString("");
  var list = RxList<ListItem>();
  var descriptionChange = RxString("");
  var photoFile = File("").obs;
  late PlatformFile platformFile;

  void clearTextField() {
    textEditController.value.clear();
  }

  void updateTextValue(String stringValue) {
    textChange.value = stringValue;
  }

  void insertIntoDB() {
    var db = FirebaseFirestore.instance;
    var docList = db.collection("List").doc();

    var listItem = ListItem(
        id: docList.id,
        listName: textChange.value,
        strike: false,
        date: DateTime.now().millisecondsSinceEpoch.toDouble());

    docList.set(listItem.toJson());
  }

  Stream<List<ListItem>> readList() => FirebaseFirestore.instance
      .collection("List")
      .orderBy('date', descending: true)
      .snapshots()
      .map((event) =>
          event.docs.map((e) => ListItem.fromJson(e.data())).toList());

  void updateDB(ListItem listItem, bool value) {
    var db = FirebaseFirestore.instance;
    var docList = db.collection("List").doc(listItem.id);
    docList.update({"strike": value});
  }

  void updateDBDescription(ListItem listItem) {
    var db = FirebaseFirestore.instance;
    var docList = db.collection("List").doc(listItem.id);
    docList.update({"description": descriptionChange.value});
  }

  void pickImageFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      photoFile.value = File(file.path.toString());
      platformFile = file;
      //uploadFile(file,listItem);
    } else {
      // User canceled the picker
    }
  }

  void uploadFile(PlatformFile platformFile, ListItem listItem) async {
    final path = 'files/${platformFile.name}';
    File file = File(platformFile.path.toString());
    FirebaseStorage.instance.ref().child(path).putFile(file).then((p0) =>
        getImageFromFirebase(platformFile.name).then(
            (value) => updateImageData(platformFile.name, listItem, value)));
  }

  Future<String> getImageFromFirebase(String fileName) async {
    final path = 'files/$fileName';
    var ref = FirebaseStorage.instance.ref().child(path);
    String url = await ref.getDownloadURL();
    print(url);
    return url;
  }

  void updateImageData(String filename, ListItem listItem, String value) {
    var db = FirebaseFirestore.instance;
    var docUser = db.collection("List").doc(listItem.id);
    docUser.update({"image": value});
  }

  void detailPageRoute(ListItem listItem){
    Get.to(const ListDetail(), arguments: listItem,fullscreenDialog: true);
  }

  void deleteListFromDb(ListItem item){
    var db = FirebaseFirestore.instance;
    var docList = db.collection("List").doc(item.id);
    docList.delete();
  }
      }
