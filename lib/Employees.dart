class Employees {
  final int id;
  final String name;
  final String email;

  Employees({required this.id, required this.name, required this.email});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email};
  }

  @override
  String toString() {
    return 'Employees{id: $id,name: $name, email: $email}';
  }
}