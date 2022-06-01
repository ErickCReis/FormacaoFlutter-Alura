import 'package:bytebank/models/contact.dart';

class Transaction {
  final String id;
  final double value;
  final Contact contact;
  final DateTime? date;

  Transaction(this.id, this.value, this.contact, {this.date})
      : assert(value > 0);

  Transaction.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        value = json['value'],
        date = DateTime.tryParse(json['dateTime']),
        contact = Contact.fromJson(json['contact']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'value': value,
        'dateTime': date?.toString(),
        'contact': contact.toJson(),
      };

  @override
  String toString() {
    return 'Transaction{id: $id, value: $value, date: $date, contact: $contact}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Transaction &&
        runtimeType == other.runtimeType &&
        value == other.value &&
        contact == other.contact &&
        date == other.date;
  }

  @override
  int get hashCode => value.hashCode ^ contact.hashCode ^ date.hashCode;
}
