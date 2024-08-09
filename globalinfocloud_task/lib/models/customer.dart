import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String name;
  String contactNumber;
  String email;
  String pinCode;
  String state;
  String city;
  String address;
  String password;
  String addressProofPath;

  Customer({
    required this.name,
    required this.contactNumber,
    required this.email,
    required this.pinCode,
    required this.state,
    required this.city,
    required this.address,
    required this.password,
    required this.addressProofPath,
  });

  // Convert a Customer object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'contactNumber': contactNumber,
      'email': email,
      'pinCode': pinCode,
      'state': state,
      'city': city,
      'address': address,
      'password': password,
      'addressProofPath': addressProofPath,
    };
  }

  // Create a Customer object from a Firestore DocumentSnapshot
  factory Customer.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Customer(
      name: data['name'] ?? '',
      contactNumber: data['contactNumber'] ?? '',
      email: data['email'] ?? '',
      pinCode: data['pinCode'] ?? '',
      state: data['state'] ?? '',
      city: data['city'] ?? '',
      address: data['address'] ?? '',
      password: data['password'] ?? '',
      addressProofPath: data['addressProofPath'] ?? '',
    );
  }
}
