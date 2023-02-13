import 'package:flutter/material.dart';

class NoteInheritedWidget extends InheritedWidget {

  final notes = [
    {
      'title': 'Note 1',
      'text': 'Deskripsi satu',
    },
    {
      'title': 'Note 2',
      'text': 'Description 2',
    },
    {
      'title': 'Note 3',
      'text': 'Description 3',
    }
  ];

  NoteInheritedWidget(Widget child) : super(child: child);

  static NoteInheritedWidget of(BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<NoteInheritedWidget>() as NoteInheritedWidget);
  }
  
  @override
  bool updateShouldNotify( NoteInheritedWidget oldWidget){
    return oldWidget.notes != notes;
  }

}
