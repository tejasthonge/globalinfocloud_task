import 'package:flutter/material.dart';
import '../controllers/login_controller.dart';

class LoginProvider with ChangeNotifier {
  final LoginController _controller = LoginController();

  Future<void> loginCustomer(String contactNumber, String password ,BuildContext context) async {
    try {
      await _controller.loginCustomer(contactNumber: contactNumber,password: password ,context: context);
      // Notify listeners on success
      notifyListeners();
    } catch (e) {
      // Handle error
      print(e);
    }
  }
}
