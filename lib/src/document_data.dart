import 'package:stove/src/field.dart';

class MutableDocumentData<T> extends DocumentData<T> {
  MutableDocumentData([Map<String, dynamic> initialData]) : super(initialData);

  void set<FT, LT>(Field<T, FT, LT> field, LT value) {
    _data[field.name] = (value != null) ? field.localToStore(value) : null;
  }

  DocumentData<T> immutable() => DocumentData(_data);
}

class DocumentData<T> {
  DocumentData([Map<String, dynamic> initialData])
      : _data = {if (initialData != null) ...initialData};

  final Map<String, dynamic> _data;

  LT get<FT, LT>(Field<T, FT, LT> field) {
    final value = _data[field.name];
    return (value != null) ? field.storeToLocal(value) : null;
  }

  Map<String, dynamic> toMap() => {..._data};
}
