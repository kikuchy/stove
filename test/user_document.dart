import 'package:stove/stove.dart';

class User {}

class UserField<FT, LT> implements Field<User, FT, LT> {
  final String name;
  final Converter<FT, LT> storeToLocal;
  final Converter<LT, FT> localToStore;

  const UserField._(this.name, this.storeToLocal, this.localToStore);

  static const name$ = UserField<String, String>._("name", identity, identity);
  static const age =
  UserField<num, int>._("age", numIntConverter, intNumConverter);
  static const birthDate = UserField._(
      "birthDate", timestampDateTimeConverter, dateTimeTimestampConverter);
  static final gender = UserField._(
      "gender",
          (f) => Gender.values.where((g) => g.toString().contains(f)).first,
          (l) => l.toString().split(".")[1]);
  static final profile = UserField._("profile",
          (f) => Profile(school: f["school"]), (l) => {"school": l.school});
  static final tags = UserField<List<String>, List<String>>._("tags", identity, identity);
}

class UserChildren<C> implements SubCollection<User, C> {
  final String name;

  const UserChildren._(this.name);

  static const friends = UserChildren<Friend>._("friends");
}

enum Gender {
  male,
  female,
  other,
}

class Profile {
  const Profile({required this.school});

  final String school;
}

class Friend {}