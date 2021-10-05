class Contact {
  final int id;
  final String? contactName;
  final int? contactAccountNumber;

  Contact(
    this.id,
    this.contactName,
    this.contactAccountNumber,
  );

  @override
  String toString() {
    return 'Contact{id: $id, contactName: $contactName, contactAccountNumber: $contactAccountNumber}';
  }
}
