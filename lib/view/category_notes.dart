import 'package:class_notes/models/create_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CategoryNotes extends StatefulWidget {
  @override
  _CategoryNotesState createState(){
    return _CategoryNotesState();
  }
}

class _CategoryNotesState extends State<CategoryNotes> {
  List<Map<String, dynamic>> _categories = [];

  bool _isLoading = true;
  void _loadCategories() async {
    final dbCreate = CreateDatabase();
    final categories = await dbCreate.queryAllCategory();
    setState(() {
      _categories = categories;
      _isLoading = false;
    });
  }

  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  final TextEditingController _titleControllerCategory = TextEditingController(text: '');

  // // This function will be triggered when the floating button is pressed
  // // It will also be triggered when you want to update an item
  void _showForm(int? id) async {
    _titleControllerCategory.text = '';
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingCategory =
      _categories.firstWhere((element) => element['id_category'] == id);
      _titleControllerCategory.text = existingCategory['name_category'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            // this will prevent the soft keyboard from covering the text fields
            bottom: MediaQuery.of(context).viewInsets.bottom + 120,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _titleControllerCategory,
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  // Save new journal
                  if (id == null) {
                    await _addCategory();
                  }
                  if (id != null) {
                    await _updateCategory(id);
                  }
                  // Clear the text fields
                  _titleControllerCategory.text = '';
                  // Close the bottom sheet
                  Navigator.of(context).pop();
                },
                child: Text(id == null ? 'Create New' : 'Update'),
              )
            ],
          ),
        )
    );
  }

  // Insert a new journal to the database
  Future<void> _addCategory() async {
    await CreateDatabase.createCategory(
        _titleControllerCategory.text, DateFormat('dd/MM/yyyy').format(now));
    _loadCategories();
  }

  // Update an existing journal
  Future<void> _updateCategory(int id) async {
    await CreateDatabase.updateCategory(
        id, _titleControllerCategory.text);
    _loadCategories();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await CreateDatabase.deleteCategory(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));
    _loadCategories();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Notes'),
        backgroundColor: Colors.white12,
      ),
      body: _isLoading
            ? const Center(
                        child: CircularProgressIndicator(),
                        )
          : ListView.builder(
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              return Card(
              color: Color.fromARGB(255, 26, 100, 161),
              margin: EdgeInsets.all(15),
              child: ListTile(
                title: Text(_categories[index]['name_category']),
                subtitle: Text(_categories[index]['createCategoryAt']),
                textColor: Colors.white,
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(onPressed: ()=>_showForm(_categories[index]['id_category']), icon: const Icon(Icons.edit)),
                      IconButton(onPressed: ()=>_deleteItem(_categories[index]['id_category']), icon: const Icon(Icons.delete)),
                    ],
                  ),
                ),
              ),
            );
            },
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => _showForm(null)),
        child: const Icon(Icons.add),
      )
    );
  }

}


