part of stove;

class WriteBatch {
  WriteBatch(this._delegate);

  final fs.WriteBatch _delegate;

  void delete<T>(DocumentReference<T> reference) {
    _delegate.delete(reference.reference);
  }

  void setData<T>(DocumentReference<T> reference, DocumentDifference<T> diff,
      {bool merge = false}) {
    _delegate.setData(reference.reference, diff.toMap(), merge: merge);
  }

  void updateData<T>(
      DocumentReference<T> reference, DocumentDifference<T> diff) {
    _delegate.updateData(reference.reference, diff.toMap());
  }

  Future<void> commit() {
    return _delegate.commit();
  }
}
