part of stove;

typedef Future<dynamic> TransactionHandler(Transaction transaction);

class Transaction {
  Transaction(this._delegate);

  final fs.Transaction _delegate;

  Future<DocumentSnapshot<T>> get<T>(DocumentReference<T> reference) {
    return _delegate
        .get(reference.reference)
        .then((snapshot) => DocumentSnapshot(snapshot));
  }

  Future<void> set<T>(
      DocumentReference<T> reference, DocumentDifference<T> newData) {
    return _delegate.set(reference.reference, newData.toMap());
  }

  Future<void> update<T>(
      DocumentReference<T> reference, DocumentDifference<T> diff) {
    return _delegate.update(reference.reference, diff.toMap());
  }

  Future<void> delete<T>(DocumentReference<T> reference) {
    return _delegate.delete(reference.reference);
  }
}
