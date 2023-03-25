/*
import 'package:flutter/material.dart';
import 'package:flutterfirestore/CrudOperation/updateCrudController.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../model/ListItem.dart';

class CrudOperations extends GetView<UpdateCrudController> {
  const CrudOperations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UpdateCrudController());
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("CRUD Operation"),
        ),
        body: Builder(builder: (context) {
          return Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: TextField(
                      controller: controller.textEditController.value,
                      onChanged: (stringValue) {
                        controller.updateTextValue(stringValue);
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          hintText: "Enter List Title"),
                    ),
                  ),
                  Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () =>
                          {
                            controller.clearTextField(),
                            controller.insertIntoDB()
                          },
                          icon: const IconTheme(
                            child: Icon(Icons.send),
                            data: IconThemeData(color: Colors.blue),
                          )))
                ],
              ),

              SingleChildScrollView(
                child: StreamBuilder<List<ListItem>>(
                  stream: controller.readList(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context,index){
                            return InkWell(
                              onTap: ()=>{
                                controller.updateDB(snapshot.data![index])
                              },
                              child: snapshot.data![index].strike == true ?
                              ListTile(
                                title: Text("${snapshot.data![index].listName}",style: TextStyle(decoration: TextDecoration.lineThrough),),
                              ):  ListTile(
                                title: Text("${snapshot.data![index].listName}"),),
                            );
                          });
                    }else{
                      return const CircularProgressIndicator();
                    }

                  },
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
*/
