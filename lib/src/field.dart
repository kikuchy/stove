import 'package:stove/src/type_converter.dart';

abstract class Field<D, FT, LT> {
  const Field();
  String get name;
  Converter<FT, LT> get storeToLocal;
  Converter<LT, FT> get localToStore;
}