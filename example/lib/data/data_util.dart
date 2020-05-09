import 'package:stove/stove.dart';

class FieldExp<T, FT, LT> extends Field<T, FT, LT> {
  @override
  final String name;
  @override
  final Converter<FT, LT> storeToLocal;
  @override
  final Converter<LT, FT> localToStore;

  const FieldExp(this.name, this.storeToLocal, this.localToStore);
}