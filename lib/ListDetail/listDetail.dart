import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirestore/ListDetail/listDetailController.dart';
import 'package:get/get.dart';

class ListDetail extends GetView<ListDetailController> {
  const ListDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ListDetailController());
    controller.listItem = Get.arguments;
    return  MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("ListDetail"),),
        body:  Container(
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
                          "${controller.listItem.listName}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 22 ,fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 80,
                          child:  controller.listItem.description == null ?const Text(
                            "No Description Available",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ) :Text(
                            "${controller.listItem.description}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 80,
                          child:  Text(
                            controller.convertToDate(controller.listItem.date!.toDouble()),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 20),

                        InkWell(
                          onTap: ()=>{
                           // controller.pickImageFromGallery()
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
                                      CachedNetworkImage(imageUrl:controller.listItem.image.toString(),
                                        fit: BoxFit.fill,
                                          placeholder: (context, url) => const Icon(Icons.error),
                                          errorWidget: (context, url, error) => const Icon(Icons.error)
                                      )
                                  // Obx(() =>
                                  //     Image.file(controller.photoFile.value,
                                  //       fit: BoxFit.fill,
                                  //     )
                                  //
                                  // )
                                  // Image.network(
                                  //   IMAGE_LOADING_BASE_URL_342 + value.posterPath.toString(),
                                  //   fit: BoxFit.fill,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],),
        )
      )
    );
  }
}
