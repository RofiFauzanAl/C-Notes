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
      final existingCategory =
          _categories.firstWhere((element) => element['id_category'] == id);
      _titleControllerCategory.text = existingCategory['name_category'];
    }

    await showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                  // Close the dialog
                  Navigator.of(context).pop();
                },
                child: Text(id == null ? 'Create New' : 'Update'),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Insert a new journal to the database
  Future<void> _addCategory() async {
    await CreateDatabase.createCategory(
        _titleControllerCategory.text, DateFormat('dd/MM/yyyy').format(now));
    _loadCategories();
  }

  // Update an existing category
  Future<void> _updateCategory(int id) async {
    await CreateDatabase.updateCategory(
        id, _titleControllerCategory.text, DateFormat('dd/MM/yyyy').format(now));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully updated category!'),
    ));
    _loadCategories();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await CreateDatabase.deleteCategory(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted category!'),
    ));
    _loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('\n\nClass Notes'),
        backgroundColor: Color.fromARGB(255, 230, 228, 228),
      ),
      body: _isLoading
        ? const Center(
          child: CircularProgressIndicator(),
        )
        : Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
            ),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              return Card(
                color: Color.fromARGB(255, 26, 100, 161),
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PopupMenuButton(
                        onSelected: (value) {
                          switch (value) {
                            case 'edit':
                              _showForm(_categories[index]['id_category']);
                              break;
                            case 'delete':
                              _deleteItem(_categories[index]['id_category']);
                              break;
                            default:
                              break;
                          }
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'edit',
                            child: ListTile(
                              leading: Icon(Icons.edit, size: 20),
                              title: Text('Edit', style: TextStyle(fontSize: 15), textAlign: TextAlign.left,),
                            ),
                          ),
                          const PopupMenuItem<String>(
                            value: 'delete',
                            child: ListTile(
                              leading: Icon(Icons.delete, size: 20),
                              title: Text('Delete', style: TextStyle(fontSize: 15), textAlign: TextAlign.left,),
                            ),
                          ),
                        ],
                        icon: const Icon(Icons.more_vert, size: 18),
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(
                        height: 65,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left : 8.0),
                          child: Text(
                            _categories[index]['name_category'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left : 8.0, bottom: 5.0),
                        child: Text(
                          // _categories[index]['createCategoryAt'],
                          "Create At: ${_categories[index]['createCategoryAt']}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => _showForm(null)),
        child: const Icon(Icons.add),
      ),
    );
  }

}


