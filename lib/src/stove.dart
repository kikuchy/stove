part of stove;

class Stove {
  Stove({fs.Firestore firestore})
      : firestore = firestore ?? fs.Firestore.instance;

  static Stove get instance => Stove();

  final fs.Firestore firestore;

  WriteBatch batch() => WriteBatch(firestore.batch());

  Future<void> runTransaction(TransactionHandler transactionHandler,
      {Duration timeout = const Duration(seconds: 5)}) {
    return firestore.runTransaction((fsTransaction) {
      return transactionHandler(Transaction(fsTransaction));
    }, timeout: timeout);
  }

  Query<T> collectionGroup<T>(String path) =>
      Query(firestore.collectionGroup(path));

  CollectionReference<T> collection<T>(String path) =>
      CollectionReference(firestore.collection(path));

  DocumentReference<T> document<T>(String path) =>
      DocumentReference.fromReference(firestore.document(path));
}
