import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:stove/src/document_difference.dart';
import 'package:stove/src/document_reference.dart';

class WriteBatch {
  WriteBatch(this._delegate) : assert(_delegate != null);
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
