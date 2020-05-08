import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:flutter_test/flutter_test.dart';
import 'package:stove/stove.dart';

import 'user_document.dart';

void main() {
  test("description", () {
    final diff = DocumentDifference<User>()
      ..set(UserField.name$, "Jiro")
      ..delete(UserField.profile)
      ..serverTimestamp(UserField.birthDate)
      ..increment(UserField.age, 2)
      ..arrayUnion(UserField.tags, ["tag1"])
      ..arrayRemove(UserField.tags, ["tag2"]);
    final ref = DocumentReference<User>(id: "hoge");
    ref.setData(DocumentDifference()..set(UserField.name$, "Saburo"));
    expect(diff.toMap(), {UserField.profile.name: fs.FieldValue.delete()});
  });
}
