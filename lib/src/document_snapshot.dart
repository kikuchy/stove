import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:stove/src/document_data.dart';
import 'package:stove/src/document_reference.dart';

class DocumentSnapshot<T> {
  DocumentSnapshot(this._snapshot):assert(_snapshot != null);
  final fs.DocumentSnapshot _snapshot;

  DocumentData<T> get data => DocumentData(_snapshot.data);

  DocumentReference<T> get reference => DocumentReference.fromReference(_snapshot.reference);

  bool get exists => _snapshot.exists;

  String get documentID => _snapshot.documentID;

  fs.SnapshotMetadata get metadata => _snapshot.metadata;
}