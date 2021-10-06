class Contact {
  final int? id;
  final String? contactName;
  final int? contactAccountNumber;

  Contact(
    this.id,
    this.contactName,
    this.contactAccountNumber,
  );

  Contact.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        contactName = json['name'],
        contactAccountNumber = json['accountNumber'];

  Map<String, dynamic> toJson() => {
        'name': contactName,
        'accountNumber': contactAccountNumber,
      };

  @override
  String toString() {
    return 'Contact{id: $id, contactName: $contactName, contactAccountNumber: $contactAccountNumber}';
  }
}
