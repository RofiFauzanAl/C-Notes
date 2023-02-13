import 'package:flutter/material.dart';
import 'package:class_notes/inherited_widgets/note_inherited_widget.dart';
import 'package:class_notes/views/note_list.dart';
// import 'dart:html';

void main() => runApp(App());

class App extends  StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NoteInheritedWidget(
      MaterialApp(
      title: 'C-Notes',
      home: NoteList(),
      ),
    );
  }
}