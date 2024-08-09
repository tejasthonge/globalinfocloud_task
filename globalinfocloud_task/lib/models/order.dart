import 'package:globalinfocloud_task/models/product.dart';

class Order {
  String customerName;
  String shippingAddress;
  String contactNumber;
  DateTime deliveryDateTime;
  List<Product> products;
  Map<String, int> quantities;

  Order({
    required this.customerName,
    required this.shippingAddress,
    required this.contactNumber,
    required this.deliveryDateTime,
    required this.products,
    required this.quantities,
  });
}
