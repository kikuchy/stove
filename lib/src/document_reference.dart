import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:stove/src/collection_reference.dart';
import 'package:stove/src/document_snapshot.dart';
import 'package:stove/src/sub_collection.dart';

import 'document_difference.dart';

class DocumentReference<T> {
  DocumentReference({
    String id,
    fs.CollectionReference collectionReference,
    CollectionReference collection,
  }) : assert(collectionReference != null || collection != null) {
    if (collectionReference != null) {
      _reference = collectionReference.document(id);
    }
    if (collection != null) {
      _reference = collection.reference.document(id);
    }
  }

  DocumentReference.fromReference(fs.DocumentReference reference)
      : assert(reference != null) {
    _reference = reference;
  }

  fs.DocumentReference _reference;

  fs.DocumentReference get reference => _reference;

  Future<DocumentSnapshot<T>> get({
    fs.Source source = fs.Source.serverAndCache,
  }) {
    return _reference
        .get(source: source)
        .then((snapshot) => DocumentSnapshot(snapshot));
  }

  Future<void> setData(DocumentDifference<T> newData, {bool merge = false}) {
    return _reference.setData(newData.toMap(), merge: merge);
  }

  Future<void> updateData(DocumentDifference<T> diff) {
    return _reference.updateData(diff.toMap());
  }

  Future<void> delete() {
    return _reference.delete();
  }

  CollectionReference<C> subCollection<C>(SubCollection<T, C> subCollection) {
    return CollectionReference(reference: _reference.collection(subCollection.name));
  }
}
