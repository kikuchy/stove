import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:flutter/foundation.dart';
import 'package:stove/src/document_reference.dart';
import 'package:stove/src/field.dart';
import 'package:stove/src/query.dart';

class Collection<T> extends Query<T> {
  Collection({@required this.reference}) : super(reference);
  final fs.CollectionReference reference;

  DocumentReference<T> document(String id) {
    return DocumentReference(id: id, collectionReference: reference);
  }

  Future<DocumentReference<T>> add<FT, LT>(Map<Field<T, FT, LT>, dynamic> data) {
    return reference
        .add(data.map((key, value) => MapEntry(
            key.name, (value != null) ? key.localToStore(value) : null)))
        .then((reference) => DocumentReference.fromReference(reference));
  }

  DocumentReference<U> parent<U>() {
    final parentRef = reference.parent();
    return DocumentReference.fromReference(parentRef);
  }
}
