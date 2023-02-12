import 'package:flutter/material.dart';
// import 'dart:html';

enum NoteMode { editingNote, 
                addingNote }

class Note extends StatelessWidget{
  
  final NoteMode noteMode;
  
  Note(this.noteMode);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          noteMode == NoteMode.addingNote ? 'Add Note' : 'Edit Note',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child:SingleChildScrollView(
          reverse: true,
          padding: EdgeInsets.all(2),
          child: Column(
            mainAxisAlignment : MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: 'Note Title'
                ),
              ),
              Container(height: 8,),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Note Text',
                  border: OutlineInputBorder(),
                ),
                maxLines: 20,
              ),
              Container(height: 4,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  noteButton('Save', Colors.blue, () { 
                    Navigator.pop(context);
                  }),
                  noteButton('Discard', Colors.grey, () {
                    Navigator.pop(context);
                  }),
                  noteMode == NoteMode.editingNote ?
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: noteButton('Delete', Colors.red, () { 
                        Navigator.pop(context);
                      }),    
                    )
                  : Container()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


class noteButton extends StatelessWidget{

  final  String _text;
  final Color _color;
  final void Function()? _onPressed;
  final color = Colors.white;

  noteButton(this._text, this._color, this._onPressed);

  @override
  Widget build(BuildContext context){
    return MaterialButton(
      onPressed: _onPressed,
      child: Text(
          _text,
          style: TextStyle(color: color),
        ),
      color: _color,
    );
  }
}