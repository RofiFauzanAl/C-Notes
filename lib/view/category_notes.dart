import 'package:flutter/material.dart';
import 'package:note_keeper/models/categories_model.dart';
import 'package:note_keeper/models/database_intances.dart';

class CategoryNotes extends StatefulWidget {
  @override
  _CategoryNotesState createState(){
    return _CategoryNotesState();
  }
}

class _CategoryNotesState extends State<CategoryNotes> {
  DatabaseInstances databaseInstances = DatabaseInstances();
  TextEditingController nameCategoryNotes = TextEditingController();


  @override
  void initState(){
    databaseInstances.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Notes'),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<CategoryModel>>(
          future: databaseInstances.all(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              if(snapshot.data!.isEmpty){
                return const Center(
                  child: Text('No Data'),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(snapshot.data![index].name ?? ''),
                  );
                },
              );
            }else{
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue.shade300,
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          openDialog(nameCategoryNotes);
        },
        child: const Icon(Icons.add),
      ),
    );
  }


  Future openDialog(nameCategoryNotes) => showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text('Add Category'),
        content: TextField(
            decoration: const InputDecoration(
            hintText: 'Category Name',
            ),
            controller: nameCategoryNotes,
        ),
        actions: [
          TextButton(
            onPressed: () async{
              print('test');
              await databaseInstances.insertCategory({
                'categoryName': nameCategoryNotes.text,
                'createAt': DateTime.now().toString(),
                'updateAt': DateTime.now().toString(),
              });
              Navigator.pop(context);
              setState(() {});
            }, 
            child: const Text('Submit')
          ),
        ],
      )
  );

  Future _refresh() async{
    setState(() {

    });
  }

  

}


