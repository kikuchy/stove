part of stove;

class CollectionReference<T> extends Query<T> {
  CollectionReference(this.reference) : super(reference);
  final fs.CollectionReference reference;

  DocumentReference<T> document([String id]) {
    return DocumentReference.fromReference(reference.document(id));
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
