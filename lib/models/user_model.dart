import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? id;
  final String nic;
  final String name;
  final String password;
  final String role;
  final String? contactNumber;
  User({
    this.id,
    required this.nic,
    required this.name,
    required this.password,
    required this.role,
    this.contactNumber,
  });

  factory User.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return User(
        id: snapshot.id,
        nic: data['nic'] ?? '',
        name: data['name'] ?? '',
        password: data['password'] ?? '',
        role: data['role'] ?? '',
        contactNumber: data['contactNumber']);
  }

  factory User.fromMap(Map<String, dynamic> map, String? id) {
    return User(
        id: id,
        nic: map['nic'] ?? '',
        name: map['name'] ?? '',
        password: map['password'] ?? '',
        role: map['role'] ?? '',
        contactNumber: map['contactNumber']);
  }

  Map<String, dynamic> toMap() {
    return {
      'nic': nic,
      'name': name,
      'password': password,
      'role': role,
    };
  }
}
