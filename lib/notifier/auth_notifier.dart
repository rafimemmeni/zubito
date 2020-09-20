import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthNotifier with ChangeNotifier {
  User _user;
  int _totalCart;
  User get user => _user;
  int get totalCart => _totalCart;
  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  set totalCart(int totalCart) {
    _totalCart = totalCart;
    notifyListeners();
  }
}
