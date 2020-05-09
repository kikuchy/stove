import 'dart:ui';

import 'package:example/data/data_util.dart';
import 'package:example/data/todo.dart';
import 'package:stove/stove.dart';

class Category {
  static const String rootPath = "/categories";

  String id;
  String name;
  Color color;
  int count;
}

class CategoryField<FT, LT> extends FieldExp<Category, FT, LT> {
  const CategoryField._(String name, LT Function(FT) s, FT Function(LT) l)
      : super(name, s, l);

  static const name$ =
      CategoryField<String, String>._("name", identity, identity);
  static final color = CategoryField<num, Color>._(
      "color", (n) => Color(n.toInt()), (c) => c.value);
  static const count =
      CategoryField<num, int>._("count", numIntConverter, intNumConverter);
}

class CategoryChildren extends SubCollection<Category, Todo> {
  final String name;

  const CategoryChildren.todo() : name = "todos";
}
