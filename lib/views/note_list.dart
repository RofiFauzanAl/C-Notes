import 'package:class_notes/views/note.dart';
import 'package:flutter/material.dart';
// import 'dart:html';

class NoteList extends StatelessWidget {
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
                MaterialPageRoute(builder: (context) => Note(NoteMode.editingNote)),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30, left: 13, right: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  NoteTitle(),
                  Container(height: 3,),
                  NoteText(),
                ],
              ),
            )
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Note(NoteMode.addingNote)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


class NoteTitle extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Text(
      'Notes Title',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class NoteText extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Text(
      'Some text here. Example Lorem ipsum sit dolor amet, bla bla bla what ever you want to write here.',
      style: TextStyle(
        fontSize: 15,
        color: Colors.grey.shade600
      ),
    );
  }
}