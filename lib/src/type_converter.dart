import 'package:cloud_firestore/cloud_firestore.dart';

typedef Converter<T, U> = U Function(T);

T identity<T>(T v) => v;
int numIntConverter(num v) => v.toInt();
num intNumConverter(int v) => v;
double numDoubleConverter(num v) => v.toDouble();
num doubleNumConverter(double v) => v;
DateTime timestampDateTimeConverter(Timestamp v) => v.toDate();
Timestamp dateTimeTimestampConverter(DateTime v) => Timestamp.fromDate(v);
