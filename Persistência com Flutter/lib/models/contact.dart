class Contact {
  final int id;
  final String name;
  final int accountNumber;

  Contact(
    this.id,
    this.name,
    this.accountNumber,
  );

  @override
  String toString() {
    return 'Contact(id: $id, name: $name, accountNumber: $accountNumber)';
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      map['id'],
      map['name'],
      map['account_number'],
    );
  }

  Map<String, dynamic> toMap({ignoreId = false}) {
    return {
      'id': ignoreId ? null : id,
      'name': name,
      'account_number': accountNumber,
    };
  }
}
