import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirestore/CrudOperation/Dialog.dart';
import 'package:flutterfirestore/CrudOperation/updateCrudController.dart';
import 'package:flutterfirestore/ListDetail/secondaryBackground.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../model/ListItem.dart';

class CrudOperations extends GetView<UpdateCrudController> {
  const CrudOperations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UpdateCrudController());
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("CRUD Operation"),
        ),
        body: Builder(builder: (context) {
          return Column(
            children: [
              SizedBox(height: 8,),
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
                            return Dismissible(
                              key: Key(snapshot.data![index].date.toString()),
                              confirmDismiss: (direction) async{
                                if(direction == DismissDirection.endToStart){
                                  final bool res = await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Text(
                                              "Are you sure you want to delete ${snapshot.data![index].listName}?"),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              child: const Text(
                                                "Cancel",
                                                style: TextStyle(color: Colors.white),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            ElevatedButton(
                                              child: const Text(
                                                "Yes",
                                                style: TextStyle(color: Colors.white),
                                              ),
                                              onPressed: () {
                                                  controller.deleteListFromDb(snapshot.data![index]);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                  return res;
                                }
                              },
                              background: slideLeftBackground(),
                              secondaryBackground: slideLeftBackground(),
                              child: InkWell(
                                onTap: ()=>{
                                  //  dialogWidget(context, controller ,snapshot.data![index] )
                                  controller.detailPageRoute(snapshot.data![index])
                                },
                                child:
                                ListTile(
                                  leading: Checkbox(onChanged: (value){
                                    controller.updateDB(snapshot.data![index],value!);
                                  },
                                    value: snapshot.data![index].strike,
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: 50,
                                        height: 50,
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
                                              CachedNetworkImage(
                                                  imageUrl: "${snapshot.data![index].image}",
                                                placeholder: (context, url) => const Icon(Icons.error),
                                                errorWidget: (context, url, error) => const Icon(Icons.error),)
                                              // Image.network(
                                              //   IMAGE_LOADING_BASE_URL_342 + value.posterPath.toString(),
                                              //   fit: BoxFit.fill,
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      IconButton(onPressed: ()=>{
                                      dialogWidget(context, controller ,snapshot.data![index])
                                      }, icon: const IconTheme(data: IconThemeData(color: Colors.blue),child: Icon(Icons.edit),))
                                    ],
                                  ),
                                  title: snapshot.data![index].strike == true ? Text("${snapshot.data![index].listName}",style: const TextStyle(decoration: TextDecoration.lineThrough),):Text("${snapshot.data![index].listName}"),
                                  subtitle: snapshot.data![index].description != null ? Text("${snapshot.data![index].description}") : const Text(""),
                                )

                              ),
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
