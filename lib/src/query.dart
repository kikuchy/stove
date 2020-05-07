import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:stove/src/document_snapshot.dart';
import 'package:stove/src/field.dart';

class Query<T> {
  Query(this._query) : assert(_query != null);

  final fs.Query _query;

  Query<T> limit(int length) {
    return Query(_query.limit(length));
  }

  Query<T> orderBy<FT, LT>(Field<T, FT, LT> field, {bool descending = false}) {
    return Query(_query.orderBy(field.name, descending: descending));
  }

  Query<T> where<FT, LT>(
    Field<T, FT, LT> field, {
    LT isEqualTo,
    LT isLessThan,
    LT isLessThanOrEqualTo,
    LT isGreaterThan,
    LT isGreaterThanOrEqualTo,
    dynamic arrayContains,
    List<dynamic> arrayContainsAny,
    List<dynamic> whereIn,
    bool isNull,
  }) {
    return Query(_query.where(
      field.name,
      isEqualTo: (isEqualTo != null) ? field.localToStore(isEqualTo) : null,
      isLessThan: (isLessThan != null) ? field.localToStore(isLessThan) : null,
      isLessThanOrEqualTo: (isLessThanOrEqualTo != null)
          ? field.localToStore(isLessThanOrEqualTo)
          : null,
      isGreaterThan:
          (isGreaterThan != null) ? field.localToStore(isGreaterThan) : null,
      isGreaterThanOrEqualTo: (isGreaterThanOrEqualTo != null)
          ? field.localToStore(isGreaterThanOrEqualTo)
          : null,
      arrayContains: arrayContains,
      arrayContainsAny: arrayContainsAny,
      whereIn: whereIn,
      isNull: isNull,
    ));
  }

  Query<T> startAfterDocument(fs.DocumentSnapshot documentSnapshot) {
    return Query(_query.startAfterDocument(documentSnapshot));
  }

  Query<T> startAtDocument(fs.DocumentSnapshot documentSnapshot) {
    return Query(_query.startAtDocument(documentSnapshot));
  }

  Query<T> startAfter(List<dynamic> values) {
    return Query(_query.startAfter(values));
  }

  Query<T> startAt(List<dynamic> values) {
    return Query(_query.startAt(values));
  }

  Query<T> endAtDocument(fs.DocumentSnapshot documentSnapshot) {
    return Query(_query.endAtDocument(documentSnapshot));
  }

  Query<T> endBeforeDocument(fs.DocumentSnapshot documentSnapshot) {
    return Query(_query.endBeforeDocument(documentSnapshot));
  }

  Query<T> endAt(List<dynamic> values) {
    return Query(_query.endAt(values));
  }

  Query<T> endBefore(List<dynamic> values) {
    return Query(_query.endBefore(values));
  }

  Future<List<DocumentSnapshot<T>>> getDocuments(
      {fs.Source source = fs.Source.serverAndCache}) {
    return _query.getDocuments(source: source).then((snapshot) {
      return snapshot.documents.map((s) => DocumentSnapshot<T>(s)).toList();
    });
  }

  Stream<List<DocumentSnapshot<T>>> snapshots() {
    return _query.snapshots().map((snapshot) {
      return snapshot.documents.map((s) => DocumentSnapshot<T>(s)).toList();
    });
  }
}
