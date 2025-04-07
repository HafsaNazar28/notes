import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/note_provider.dart';
import 'main_menu_screen.dart';

class HomeScreen extends StatelessWidget {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  void showNoteDialog(BuildContext context, {String? docId, String? title, String? content}) {
    titleController.text = title ?? '';
    contentController.text = content ?? '';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(docId == null ? 'New Note' : 'Edit Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: "Title")),
            TextField(controller: contentController, decoration: InputDecoration(labelText: "Content")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              final noteProvider = Provider.of<NoteProvider>(context, listen: false);
              if (docId == null) {
                noteProvider.addNote(titleController.text, contentController.text);
              } else {
                noteProvider.updateNote(docId, titleController.text, contentController.text);
              }
              Navigator.pop(context);
            },
            child: Text(docId == null ? "Add" : "Update"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Notes"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              authProvider.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainMenuScreen()));
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: noteProvider.getUserNotes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final notes = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              itemCount: notes.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 1,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 3,
              ),
              itemBuilder: (_, index) {
                final note = notes[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    title: Text(note['title'], style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(note['content']),
                    trailing: Wrap(
                      children: [
                        IconButton(icon: Icon(Icons.edit), onPressed: () {
                          showNoteDialog(context, docId: note.id, title: note['title'], content: note['content']);
                        }),
                        IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: () {
                          noteProvider.deleteNote(note.id);
                        }),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showNoteDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
