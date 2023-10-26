import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sachintha_uee/models/user_model.dart';

const String collectionName = 'users';

class AuthService {
  final _firebase = FirebaseFirestore.instance;
  Future<User?> login(String nic, String password) async {
    try {
      return await _firebase
          .collection(collectionName)
          .where("nic", isEqualTo: nic)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          if ((value.docs.first.data())['password'] == password) {
            return User.fromMap(value.docs.first.data(), value.docs.first.id);
          }
          throw Error.safeToString('User not found');
        } else {
          return null;
        }
      });
    } catch (e) {
      throw Error.safeToString(e.toString());
    }
  }
}
