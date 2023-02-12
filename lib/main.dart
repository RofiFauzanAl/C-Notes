import 'package:flutter/material.dart';
import 'package:class_notes/views/note_list.dart';
// import 'dart:html';

void main() {
  runApp(App());
}

class App extends  StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'C-Notes',
      home: NoteList(),
    );
  }
}