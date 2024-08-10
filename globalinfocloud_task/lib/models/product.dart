import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final List<String> imageUrlList;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrlList,
  });

  // Factory method to create a Product from a Firestore document
  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Product(
      id: data['productId'],
      name: data['productName'],
      description: data['productDescription'],
      price: (data['productPrice'] as num).toDouble(),
      imageUrlList: List<String>.from(data['imagUrlList']),
    );
  }
}
