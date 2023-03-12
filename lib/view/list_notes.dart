import 'dart:html';

import 'package:class_notes/models/create_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:class_notes/view/category_notes.dart';

class ListNotes extends StatefulWidget {
  const ListNotes({super.key});

  @override
  _ListNotesState createState() {
    return _ListNotesState();
  }
}

class _ListNotesState extends State<ListNotes>{
  @override
  void initState(){
    super.initState();
  }

  final TextEditingController _titleController = TextEditingController(text: '');
  final TextEditingController _contentController = TextEditingController(text: '');
  final TextEditingController _priorityController = TextEditingController(text: '');


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        
      ),
    );
  }
}