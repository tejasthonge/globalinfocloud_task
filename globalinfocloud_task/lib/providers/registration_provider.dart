import 'package:flutter/material.dart';
import '../controllers/registration_controller.dart';
import '../models/customer.dart';

class RegistrationProvider with ChangeNotifier {
  final RegistrationController _controller = RegistrationController();
  Future<void> registerCustomer(BuildContext context ,Customer customer) async {
    try {
      await _controller.registerCustomer(context ,customer);
      // Notify listeners on success
      notifyListeners();
    } catch (e) {
      // Handle error
      print(e);
    }
  }
}
