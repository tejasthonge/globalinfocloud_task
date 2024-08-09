import 'package:flutter/material.dart';
import '../controllers/customer_controller.dart';
import '../models/product.dart';

class CustomerProvider with ChangeNotifier {
  final CustomerController _controller = CustomerController();

  void addToCart(Product product) {
    _controller.addToCart(product);
    notifyListeners();
  }

  void editQuantity(Product product, int quantity) {
    _controller.editQuantity(product, quantity);
    notifyListeners();
  }

  double getTotalAmount() {
    return _controller.getTotalAmount();
  }

  void checkout(String shippingAddress, String contactNumber, DateTime deliveryDateTime) {
    _controller.checkout(shippingAddress, contactNumber, deliveryDateTime);
    notifyListeners();
  }

  List<Product> getCart() {
    return _controller.getCart();
  }

  Map<Product, int> getQuantities() {
    return _controller.getQuantities();
  }
}
