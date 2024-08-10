import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String orderId;
  final String customerId;
  final String productId;
  final String productName;
  final int quantity;
  final double totalPrice;
  final String status;
  final String address;
  final String contactNumber;
  final String deliveryDate;
  final String deliveryTime;
  final Timestamp orderPlacedAt;
  final String paymentMethod;
  final String userId;

  OrderModel({
    required this.orderId,
    required this.customerId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.totalPrice,
    required this.status,
    required this.address,
    required this.contactNumber,
    required this.deliveryDate,
    required this.deliveryTime,
    required this.orderPlacedAt,
    required this.paymentMethod,
    required this.userId,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return OrderModel(
      orderId: doc.id,
      customerId: data['customerId'] ?? '',
      productId: data['productId'] ?? '',
      productName: data['productName'] ?? '',
      quantity: data['quantity'] ?? 0,
      totalPrice: data['totalPrice']?.toDouble() ?? 0.0,
      status: data['status'] ?? 'Pending',
      address: data['address'] ?? '',
      contactNumber: data['contactNumber'] ?? '',
      deliveryDate: data['deliveryDate'] ?? '',
      deliveryTime: data['deliveryTime'] ?? '',
      orderPlacedAt: data['orderPlacedAt'] ?? Timestamp.now(),
      paymentMethod: data['paymentMethod'] ?? 'Pay on Delivery',
      userId: data['userId'] ?? '',
    );
  }
}
