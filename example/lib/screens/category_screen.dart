import 'package:example/data/category.dart';
import 'package:example/data/repository.dart';
import 'package:example/screens/todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODOs"),
      ),
      body: StreamBuilder<List<Category>>(
          stream: Provider.of<Repository>(context, listen: false)
              .subscribeCategories(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final categories = snapshot.data;
            if (categories.isEmpty) {
              return Center(
                child: Text("No category"),
              );
            }
            return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, i) {
                  final category = categories[i];
                  return ListTile(
                    title: Text(category.name),
                    trailing: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: category.color),
                      child: Text("${category.count}"),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TodoScreen(category)));
                    },
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            AddCategoryDialog.show(context);
          }),
    );
  }
}

class AddCategoryDialog extends StatefulWidget {
  static Future<void> show(BuildContext context) {
    return showDialog(
        context: context, builder: (context) => AddCategoryDialog());
  }

  @override
  _AddCategoryDialogState createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  Color _selected;
  String _name;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("New Category"),
      content: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: "Category name"),
            onChanged: (v) {
              setState(() {
                _name = v;
              });
            },
          ),
          DropdownButton<Color>(
              value: _selected,
              items: Colors.primaries
                  .map((c) => DropdownMenuItem(
                      value: c,
                      child: Container(
                        height: 24,
                        width: 24,
                        color: c,
                      )))
                  .toList(),
              onChanged: (c) {
                setState(() {
                  _selected = c;
                });
              }),
        ],
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel")),
        RaisedButton(
          onPressed: () {
            Provider.of<Repository>(context, listen: false)
                .addCategory(Category()
                  ..name = _name
                  ..color = _selected);
            Navigator.pop(context);
          },
          child: Text("OK"),
        ),
      ],
    );
  }
}
