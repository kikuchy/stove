part of stove;

abstract class Field<D, FT, LT> {
  const Field();
  String get name;
  Converter<FT, LT> get storeToLocal;
  Converter<LT, FT> get localToStore;
}