import 'package:chatapp/const/extentions.dart';
import 'package:get/get.dart';

class Helper{
  static String getFirstValue(String value){
    return value.nullSafe.substring(0,1).toUpperCase();
  }
}