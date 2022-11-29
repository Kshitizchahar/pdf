import 'dart:typed_data';
import 'package:flutter/services.dart'show rootBundle;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'mobile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 @override
 Widget build(BuildContext context){
  return Scaffold(
    body: Center(child: ElevatedButton(
      child: Text('Create PDF'),
      onPressed: _createPDF,
      ),
    ),
  );
 }
 Future<void> _createPDF() async{
  PdfDocument document = PdfDocument();
  final page = document.pages.add();

  page.graphics.drawString('Welcome to PDF Successfully', 
  PdfStandardFont(PdfFontFamily.helvetica,30 ));

  page.graphics.drawImage(
    PdfBitmap(await _readImageData('pic1.jpg')),
    Rect.fromLTWH(0, 100, 440, 550));
  
  List<int> bytes = await document.save();
  document.dispose();

  saveAndLaunchFile(bytes, 'Output.pdf');
  
 }
}

Future<Uint8List> _readImageData(String name) async{
  final data = await rootBundle.load('image/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
