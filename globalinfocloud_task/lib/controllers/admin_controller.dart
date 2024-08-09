import '../models/product.dart';
import '../models/order.dart';

class AdminController {
  List<Product> _products = [];
  List<Order> _orders = [];

  void addProduct(Product product) {
    _products.add(product);
    // Implement save to database logic
  }

  void editProduct(Product product) {
    // Implement edit product logic
  }

  List<Product> getProducts() {
    return _products;
  }

  List<Order> getOrders() {
    return _orders;
  }

  void acceptOrder(Order order) {
    // Implement accept order logic
  }

  void rejectOrder(Order order) {
    // Implement reject order logic
  }
}
