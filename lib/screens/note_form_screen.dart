import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/note_provider.dart';

class NoteFormScreen extends StatefulWidget {
  final Note? note;

  NoteFormScreen({this.note});

  @override
  _NoteFormScreenState createState() => _NoteFormScreenState();
}

class _NoteFormScreenState extends State<NoteFormScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.note == null ? "Add Note" : "Edit Note")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: InputDecoration(labelText: "Title")),
            SizedBox(height: 10),
            TextField(controller: _contentController, decoration: InputDecoration(labelText: "Content"), maxLines: 5),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Save"),
              onPressed: () {
                if (widget.note == null) {
                  noteProvider.addNote(_titleController.text, _contentController.text);
                } else {
                  noteProvider.updateNote(widget.note!.id, _titleController.text, _contentController.text);
                }
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
