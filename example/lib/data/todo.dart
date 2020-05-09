import 'package:stove/stove.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'data_util.dart';

class Todo {
  String id;
  String name;
  bool done;
  DateTime expires;
  Priority priority;
}

enum Priority {
  high,
  normal,
  low,
}

extension PrioritySerialization on Priority {
  String get value {
    switch (this) {
      case Priority.high:
        return "high";
      case Priority.normal:
        return "normal";
      case Priority.low:
        return "low";
    }
    return null;
  }

  static Priority fromValue(String value) {
    switch (value) {
      case "high":
        return Priority.high;
      case "normal":
        return Priority.normal;
      case "low":
        return Priority.low;
    }
    return null;
  }
}

class TodoField<FT, LT> extends FieldExp<Todo, FT, LT> {
  const TodoField._(String name, LT Function(FT) s, FT Function(LT) l)
      : super(name, s, l);

  static const title = TodoField<String, String>._("title", identity, identity);
  static const done = TodoField<bool, bool>._("done", identity, identity);
  static const expires = TodoField<Timestamp, DateTime>._(
      "expires", timestampDateTimeConverter, dateTimeTimestampConverter);
  static final priority = TodoField<String, Priority>._(
      "priority", PrioritySerialization.fromValue, (p) => p.value);
}
