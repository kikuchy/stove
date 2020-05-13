import 'package:flutter_test/flutter_test.dart';
import 'package:stove/stove.dart';

import 'user_document.dart';

void main() {
  test('can get and set String value', () {
    final user = MutableDocumentData<User>();
    user.set(UserField.name$, "taro");

    expect(user.get(UserField.name$), "taro");
  });

  test('can get and set int value', () {
    final user = MutableDocumentData<User>();
    user.set(UserField.age, 23);

    expect(user.get(UserField.age), 23);
  });

  test('can get and set DateTime', () {
    final user = MutableDocumentData<User>();
    final now = DateTime.now();
    user.set(UserField.birthDate, now);

    expect(user.get(UserField.birthDate), now);
  });

  test('can get and set enum value', () {
    final user = MutableDocumentData<User>();
    user.set(UserField.gender, Gender.female);

    expect(user.get(UserField.gender), Gender.female);
  });

  test('can get and set struct', () {
    final user = MutableDocumentData<User>();
    user.set(UserField.profile, Profile(school: "Somewhere"));

    expect(user.get(UserField.profile)?.school, "Somewhere");
  });
}
