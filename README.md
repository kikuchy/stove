# Stove 🔥🍳

*Stove* is the thin, but strongly typed wrapper library for [cloud_firestore](https://pub.dev/packages/cloud_firestore).

Now you can,

* take advantages of the type checker of Dart language
* avoid runtime errors due to `dynamic` arguments of `cloud_firestore`
* avoid typos due to using raw String literals for the name of document's fields

Stove provides you a happy yummy Firestore life for you! 🔥🍳

## Using

### Define the document class

 ```dart
/// User document
class User {}
```

That's it!

Also, you can add fields for this class if you want.

### Define fields of the document

```dart
// The document `User` has fields named `name` and `gender`.
class UserField<FT, LT> implements Field<User, FT, LT> {
  final String name;
  final Converter<FT, LT> storeToLocal;
  final Converter<LT, FT> localToStore;

  const UserField._(this.name, this.storeToLocal, this.localToStore);

  static const name$ = UserField<String, String>._("name", identity, identity);
  static final gender = UserField._(
        "gender",
            (f) => Gender.values.where((g) => g.toString().contains(f)).first,
            (l) => l.toString().split(".")[1]);
}
```

The class represents the field of the document should extend `Field<T, FT, LT>`.
`T` should be unique by each document.
`FT` means "Type in Firesore".
`LT` means "Type in the local environment".

You can define your own converters that converts `FT` and `LT`.
You can use all type of instance if you write converters.
If you don't want to convert the value, put `identity` converter (it through arguments).

### Define children of the document

```dart
// The document `User` has a child (sub collection) named `friends`.
class UserChildren<C> implements SubCollection<User, C> {
  final String name;

  const UserChildren._(this.name);

  static const friends = UserChildren<Friend>._("friends");
}
```

The class represents the child (sub collection) should extend `SubCollection<C>`.
`C` is the class represents the document of the element of that collection. 



### Using document reference

```dart
// Create the reference of new document
final userReference = Stove.instance.collection<User>("/users").document();

// Save data
await userReference.setData(DocumentDifference()
  ..set(UserFields.name$, "Bob")
  ..set(UserFields.gender, Gender.male)
);

// Update data
await userReference.updateData(DocumentDifference()
  ..set(UserFields.name$, "John")
  ..delete(UserFields.gender)
);
// Delete data

await userReference.delete();

// Get the snapshot
final userSnapshot = await userReference.get();
final name = userSnapshot.data.get(UserFields.name$);    // name: String
final gender = userSnapshot.data.get(UserFields.gender); // gender: Gender (automatically converted!)
switch (gender) {
  case Gender.male:
    ......
}

// Access sub collection
final friendsReference = userReference.SubCollection(UserChildren.friends);
```

### Using sub collection reference

```dart
final usersReference = Stove.instance.collection<User>("/users");

// Get all documents
final snapshots = usersReference.documents();

// Listen all documents
usersReference.snapshots()
  .listen((/*List<DocumentSnapshot<User>>*/ snapshots) {
    doYourStuff(snapshots)
});

// Query documents
usersReference
  .where(UserFields.gender, isEqualTo: Gender.female)
  .order(UserFields.name$)
  .documents();
```