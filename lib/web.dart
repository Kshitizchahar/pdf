import 'package:universal_html/html.dart';
import 'dart:convert';

Future<void> saveAndLaunchFile(List<int> bytes,String filename) async{
  AnchorElement(
    href:"data: application/octet-stream; charset=utf-161e;base64, ${base64.encode (bytes)}")
    ..setAttribute("download", filename)
    ..click();
  
}