class Contact {
  final int id;
  final String name;
  final int accountNumber;

  Contact(
    this.id,
    this.name,
    this.accountNumber,
  );

  Contact.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'],
        accountNumber = json['accountNumber'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'accountNumber': accountNumber,
      };

  @override
  String toString() {
    return 'Contact(id: $id, name: $name, accountNumber: $accountNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Contact &&
        runtimeType == other.runtimeType &&
        other.id == id &&
        other.name == name &&
        other.accountNumber == accountNumber;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ accountNumber.hashCode;
}
