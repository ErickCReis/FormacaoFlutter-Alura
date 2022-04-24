import 'package:intl/intl.dart';

final _currenyFormatter = NumberFormat.simpleCurrency(
  locale: 'en_US',
  decimalDigits: 2,
);

final _dateFormatter = DateFormat('yyyy-MM-dd HH:mm');

String formatCurrency(double value) => _currenyFormatter.format(value);
double parseCurrency(String value) => _currenyFormatter.parse(value).toDouble();

String formatDate(DateTime? date) {
  if (date == null) {
    return '';
  }

  return _dateFormatter.format(date);
}
