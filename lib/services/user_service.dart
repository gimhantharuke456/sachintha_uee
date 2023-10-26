import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sachintha_uee/models/user_model.dart';

class UserService {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser(
    String nic,
    String name,
    String password,
    String role,
    String? contactNumber,
  ) {
    return _usersCollection.add({
      'nic': nic,
      'name': name,
      'password': password,
      'role': role,
      'contactNumber': contactNumber,
    });
  }

  Future<User> getUserById(String userId) async {
    DocumentSnapshot snapshot = await _usersCollection.doc(userId).get();

    return User.fromDocumentSnapshot(snapshot);
  }

  Future<List<User>> getAllUsers() async {
    QuerySnapshot querySnapshot = await _usersCollection.get();

    return querySnapshot.docs
        .map((doc) => User.fromDocumentSnapshot(doc))
        .toList();
  }

  Future<void> updateUser(
      String userId, String nic, String name, String password, String role) {
    return _usersCollection.doc(userId).update({
      'nic': nic,
      'name': name,
      'password': password,
      'role': role,
    });
  }

  Future<void> deleteUser(String userId) {
    return _usersCollection.doc(userId).delete();
  }
}
