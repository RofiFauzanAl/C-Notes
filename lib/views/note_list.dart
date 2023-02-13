import 'package:class_notes/inherited_widgets/note_inherited_widget.dart';
import 'package:class_notes/views/note.dart';
import 'package:flutter/material.dart';
// import 'dart:html';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState(){
    return new _NoteListState();
  }
}

class _NoteListState extends State<NoteList> {
  List<Map<String, String>> get _notes => NoteInheritedWidget.of(context).notes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('C-Notes'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Note(NoteMode.editingNote, index))
              );
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30, left: 13, right: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _NoteTitle(_notes[index]['title']!),
                    Container(height: 3,),
                    _NoteText(_notes[index]['text']!),
                  ],
                ),
              ),
            ),  
          );
        },
        itemCount: _notes.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Note(NoteMode.addingNote, 0))
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


class _NoteTitle extends StatelessWidget{
  final String _title;

  _NoteTitle(this._title);
  
  @override
  Widget build(BuildContext context){
    return Text(
      _title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _NoteText extends StatelessWidget{
  final String _text;

  _NoteText(this._text);

  @override
  Widget build(BuildContext context){
    return Text(
        _text,
        style: TextStyle(
        fontSize: 15,
        color: Colors.grey.shade600
      ),
    );
  }
}