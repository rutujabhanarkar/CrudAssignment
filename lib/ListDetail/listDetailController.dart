import 'package:flutterfirestore/model/ListItem.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

class ListDetailController extends GetxController{
  late ListItem listItem;


  String convertToDate(double datetime){
    var dt = DateTime.fromMillisecondsSinceEpoch(datetime.toInt());

    var date = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);
    print(date);
    return date;
  }

}