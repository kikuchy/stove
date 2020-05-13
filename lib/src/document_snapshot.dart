part of stove;

class DocumentSnapshot<T> {
  DocumentSnapshot(this._snapshot);

  final fs.DocumentSnapshot _snapshot;

  DocumentData<T> get data => DocumentData(_snapshot.data);

  DocumentReference<T> get reference =>
      DocumentReference.fromReference(_snapshot.reference);

  bool get exists => _snapshot.exists;

  String get documentID => _snapshot.documentID;

  fs.SnapshotMetadata get metadata => _snapshot.metadata;
}
