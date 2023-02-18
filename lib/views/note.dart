import 'package:class_notes/inherited_widgets/note_inherited_widget.dart';
import 'package:flutter/material.dart';
// import 'dart:html';

enum NoteMode { editingNote, 
                addingNote }

class Note extends StatefulWidget{
  
  final NoteMode noteMode;
  final int index;

  Note(this.noteMode, this.index);

   @override
  _NoteState createState() {
    return new _NoteState();
  }
}

class _NoteState extends State<Note> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  List<Map<String, String>>get _notes => NoteInheritedWidget.of(context).notes;

  @override
  void didChangeDependencies() {
    if (widget.noteMode == NoteMode.editingNote) {
      _titleController.text = _notes[widget.index]['title']!;
      _textController.text = _notes[widget.index]['text']!;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.noteMode == NoteMode.addingNote ? 'Add Note' : 'Edit Note',
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
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Title'
                ),
              ),
              Container(height: 8,),
              TextField(
                controller: _textController,
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
                    
                    final title = _titleController.text;
                    final text = _textController.text;

                    if (widget.noteMode == NoteMode.addingNote){
                        _notes.add({'title': title, 'text': text});
                    }else if (widget.noteMode == NoteMode.editingNote){
                        _notes[widget.index]={
                          'title': title,
                          'text': text,
                        };
                    }
                    Navigator.pop(context);
                  }),
                  noteButton('Discard', Colors.grey, () {
                    Navigator.pop(context);
                  }),
                  widget.noteMode == NoteMode.editingNote ?
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: noteButton('Delete', Colors.red, () { 
                        _notes.removeAt(widget.index);
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

  final String _text;
  final Color _color;
  final Function() _onPressed;
  final color = Colors.white;

  noteButton(this._text, this._color, this._onPressed);

  @override
  Widget build(BuildContext context){
    return MaterialButton(
      onPressed: _onPressed,child: Text(
        _text,
        style: TextStyle(color: Colors.white),
      ),
      height: 40,
      minWidth: 100,
      color: _color,
    );
  }
}