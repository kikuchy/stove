import 'package:example/data/category.dart';
import 'package:example/data/todo.dart';
import 'package:stove/stove.dart';

class Repository {
  Repository() : _root = Stove();
  final Stove _root;

  CollectionReference<Category> get _categoryRoot =>
      _root.collection<Category>(Category.rootPath);

  CollectionReference<Todo> _todosReference(String categoryId) =>
      _categoryRoot.document(categoryId).subCollection(CategoryChildren.todo());

  Stream<List<Category>> subscribeCategories() {
    return _categoryRoot.snapshots().map((d) => d
        .map((s) => Category()
          ..name = s.data.get(CategoryField.name$)
          ..color = s.data.get(CategoryField.color)
          ..count = s.data.get(CategoryField.count)
          ..id = s.documentID)
        .toList());
  }

  Future<void> addCategory(Category draft) {
    return _categoryRoot.add(DocumentDifference()
      ..set(CategoryField.name$, draft.name)
      ..set(CategoryField.color, draft.color)
      ..set(CategoryField.count, 0));
  }

  Stream<List<Todo>> subscribeUndoneTodos(String categoryId) {
    return _categoryRoot
        .document(categoryId)
        .subCollection(CategoryChildren.todo())
        .where(TodoField.done, isEqualTo: false)
        .snapshots()
        .map((d) => d
            .map((s) => Todo()
              ..id = s.documentID
              ..name = s.data.get(TodoField.title)
              ..done = s.data.get(TodoField.done)
              ..priority = s.data.get(TodoField.priority)
              ..expires = s.data.get(TodoField.expires))
            .toList());
  }

  Future<void> addTodo(String categoryId, Todo draft) {
    return (_root.batch()
          ..setData(
              _todosReference(categoryId).document(),
              DocumentDifference()
                ..set(TodoField.title, draft.name)
                ..set(TodoField.priority, draft.priority)
                ..set(TodoField.expires, draft.expires)
                ..set(TodoField.done, false))
          ..updateData(_categoryRoot.document(categoryId),
              DocumentDifference()..increment(CategoryField.count, 1)))
        .commit();
  }

  Future<void> doneTodo(String categoryId, String todoId) {
    return _todosReference(categoryId)
        .document(todoId)
        .updateData(DocumentDifference()..set(TodoField.done, true));
  }
}
