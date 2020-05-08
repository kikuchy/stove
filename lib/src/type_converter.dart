part of stove;

typedef Converter<T, U> = U Function(T);

T identity<T>(T v) => v;
int numIntConverter(num v) => v.toInt();
num intNumConverter(int v) => v;
double numDoubleConverter(num v) => v.toDouble();
num doubleNumConverter(double v) => v;
DateTime timestampDateTimeConverter(fs.Timestamp v) => v.toDate();
fs.Timestamp dateTimeTimestampConverter(DateTime v) => fs.Timestamp.fromDate(v);
