import 'package:flutter/material.dart';
import '../controllers/admin_controller.dart';
import '../models/product.dart';
import '../models/order.dart';

class AdminProvider with ChangeNotifier {
  final AdminController _controller = AdminController();

  void addProduct(Product product) {
    _controller.addProduct(product);
    notifyListeners();
  }

  void editProduct(Product product) {
    _controller.editProduct(product);
    notifyListeners();
  }

  List<Product> getProducts() {
    return _controller.getProducts();
  }

  List<Order> getOrders() {
    return _controller.getOrders();
  }

  void acceptOrder(Order order) {
    _controller.acceptOrder(order);
    notifyListeners();
  }

  void rejectOrder(Order order) {
    _controller.rejectOrder(order);
    notifyListeners();
  }
}
