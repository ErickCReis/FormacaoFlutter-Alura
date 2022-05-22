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
}
