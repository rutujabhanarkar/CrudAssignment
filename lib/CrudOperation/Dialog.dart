

import 'package:flutter/material.dart';
import 'package:flutterfirestore/CrudOperation/updateCrudController.dart';
import 'package:flutterfirestore/model/ListItem.dart';
import 'package:get/get.dart';

Future<dynamic> dialogWidget(BuildContext context, UpdateCrudController controller, ListItem listItem) async{
  return await Get.dialog(
      Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                       Text(
                        "${listItem.listName}",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        child: TextField(
                          onChanged: (stringValue) {
                                controller.descriptionChange.value = stringValue;
                          },
                          decoration:  InputDecoration(
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)),
                              hintText: listItem.description == null ? "" : "${listItem.description}"),
                        ),
                      ),
                      const SizedBox(height: 20),

                      InkWell(
                        onTap: ()=>{
                          controller.pickImageFromGallery()
                          //controller.detailPageRoute(listItem)
                        },
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            margin: const EdgeInsets.all(5),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Obx(() =>
                                    Image.file(controller.photoFile.value,
                                      fit: BoxFit.fill,
                                    )

                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      //Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                'NO',
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                controller.updateDBDescription(listItem);
                                if(controller.photoFile.value != null){
                                  controller.uploadFile(controller.platformFile, listItem);
                                }
                                Get.back();
                              },
                              child: const Text(
                                'YES',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],),
      )
  );

}