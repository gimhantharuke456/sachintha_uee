import 'package:flutter/material.dart';
import 'package:sachintha_uee/models/user_model.dart';

class UserProvider with ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  void setCurrentUser(User newUser) {
    _currentUser = newUser;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
