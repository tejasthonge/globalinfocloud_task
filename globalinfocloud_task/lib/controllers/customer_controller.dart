// import '../models/product.dart';

// class CustomerController {
//   List<Product> _cart = [];
//   Map<Product, int> _quantities = {};

//   void addToCart(Product product) {
//     _cart.add(product);
//     _quantities[product] = 1;
//   }

//   void editQuantity(Product product, int quantity) {
//     if (_quantities.containsKey(product)) {
//       _quantities[product] = quantity;
//     }
//   }

//   double getTotalAmount() {
//     double total = 0;
//     _quantities.forEach((product, quantity) {
//       total += product.rate * quantity;
//     });
//     return total;
//   }

//   void checkout(String shippingAddress, String contactNumber, DateTime deliveryDateTime) {
//     // Implement checkout logic
//   }

//   List<Product> getCart() {
//     return _cart;
//   }

//   Map<Product, int> getQuantities() {
//     return _quantities;
//   }
// }
