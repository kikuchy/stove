part of stove;

class DocumentDifference<T>  {
  DocumentDifference([Map<String, dynamic> initialData]) : _data = {if (initialData != null) ...initialData};

  final Map<String, dynamic> _data;

  void set<FT, LT>(Field<T, FT, LT> field, LT value) {
    _data[field.name] = (value != null) ? field.localToStore(value) : null;
  }

  void delete<FT, LT>(Field<T, FT, LT> field) {
    _data[field.name] = fs.FieldValue.delete();
  }

  void serverTimestamp<LT>(Field<T, fs.Timestamp, LT> field) {
    _data[field.name] = fs.FieldValue.serverTimestamp();
  }

  void increment<FT extends num, LT extends num>(Field<T, FT, LT> field, FT value) {
    _data[field.name] = fs.FieldValue.increment(value);
  }

  void arrayUnion<FT, LT>(Field<T, List<FT>, List<LT>> field, List<LT> elements) {
    assert(elements != null);
    _data[field.name] =  fs.FieldValue.arrayUnion(field.localToStore(elements));
  }

  void arrayRemove<FT, LT>(Field<T, List<FT>, List<LT>> field, List<LT> elements) {
    assert(elements != null);
    _data[field.name] = fs.FieldValue.arrayRemove(field.localToStore(elements));
  }

  Map<String, dynamic> toMap() => _data;
}