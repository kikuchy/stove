import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:flutter/foundation.dart';
import 'package:stove/src/document_difference.dart';
import 'package:stove/src/document_reference.dart';
import 'package:stove/src/query.dart';

class CollectionReference<T> extends Query<T> {
  CollectionReference({@required this.reference}) : super(reference);
  final fs.CollectionReference reference;

  DocumentReference<T> document(String id) {
    return DocumentReference(id: id, collectionReference: reference);
  }

  Future<DocumentReference<T>> add<FT, LT>(DocumentDifference<T> newData) {
    return reference
        .add(newData.toMap())
        .then((reference) => DocumentReference.fromReference(reference));
  }

  DocumentReference<U> parent<U>() {
    final parentRef = reference.parent();
    return DocumentReference.fromReference(parentRef);
  }
}
