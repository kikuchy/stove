import 'package:example/data/category.dart';
import 'package:example/data/repository.dart';
import 'package:example/data/todo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatelessWidget {
  final Category category;

  TodoScreen(this.category);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: category.color),
      child: Scaffold(
        appBar: AppBar(
          title: Text(category.name),
        ),
        body: StreamBuilder<List<Todo>>(
            stream: Provider.of<Repository>(context, listen: false)
                .subscribeUndoneTodos(category.id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final todos = snapshot.data;
              if (todos.isEmpty) {
                return Center(
                  child: Text("Complete tasks!"),
                );
              }
              return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, i) =>
                    TodoListTile(todos[i], category.id),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AddTodoDialog.show(context, category.id);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class TodoListTile extends StatelessWidget {
  final Todo todo;
  final String categoryId;

  TodoListTile(this.todo, this.categoryId);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(todo.name),
      value: todo.done,
      subtitle: Text("priority: ${todo.priority.value}"),
      onChanged: (done) {
        Provider.of<Repository>(context, listen: false)
            .doneTodo(categoryId, todo.id);
      },
    );
  }
}

class AddTodoDialog extends StatefulWidget {
  static Future<void> show(BuildContext context, String categoryId) {
    return showDialog(
        context: context, builder: (context) => AddTodoDialog(categoryId));
  }

  final String categoryId;

  AddTodoDialog(this.categoryId);

  @override
  _AddTodoDialogState createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  String _title;
  DateTime _expiresAt;
  Priority _priority = Priority.normal;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("New TODO"),
      content: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: "title"),
            onChanged: (v) {
              setState(() {
                _title = v;
              });
            },
          ),
          DropdownButton<Priority>(
              value: _priority,
              items: Priority.values
                  .map((p) => DropdownMenuItem(
                        child: Text(p.value),
                        value: p,
                      ))
                  .toList(),
              onChanged: (p) {
                setState(() {
                  _priority = p;
                });
              }),
          Row(
            children: <Widget>[
              Text("Expires at:"),
              FlatButton(
                  onPressed: () async {
                    final exp = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year),
                        lastDate: DateTime(3000));
                    setState(() {
                      _expiresAt = exp;
                    });
                  },
                  child: null)
            ],
          )
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
            Provider.of<Repository>(context, listen: false).addTodo(
                widget.categoryId,
                Todo()
                  ..name = _title
                  ..expires = _expiresAt
                  ..priority = _priority);
            Navigator.pop(context);
          },
          child: Text("OK"),
        ),
      ],
    );
  }
}
