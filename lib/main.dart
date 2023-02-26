import 'package:flutter/material.dart';
import 'package:class_notes/view/category_notes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Class Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: CategoryNotes(),
    );
  }

}