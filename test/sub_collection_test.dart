import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:flutter_test/flutter_test.dart';
import 'package:stove/stove.dart';

import 'user_document.dart';

void main() {
  test("can make sub collection reference",  () {
    final user = DocumentReference<User>(id: "hoge", collectionReference: fs.Firestore.instance.collection("/"));
    final friends = user.subCollection(UserChildren.friends);
    expect(friends, isNotNull);
  });
}