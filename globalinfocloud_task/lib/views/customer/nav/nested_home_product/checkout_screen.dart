// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:globalinfocloud_task/views/admin/models/orders_model.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController deliveryDateController = TextEditingController();
  final TextEditingController deliveryTimeController = TextEditingController();

  String paymentMethod = 'Online';
  String userId = 'user123'; // Replace with actual user ID
  String orderId = FirebaseFirestore.instance.collection('orders').doc().id; // Generate a unique order ID

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Shipping Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your shipping address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: contactController,
                decoration: const InputDecoration(labelText: 'Contact Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your contact number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: deliveryDateController,
                decoration: const InputDecoration(labelText: 'Delivery Date'),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      deliveryDateController.text =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a delivery date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: deliveryTimeController,
                decoration: const InputDecoration(labelText: 'Delivery Time'),
                readOnly: true,
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      deliveryTimeController.text = pickedTime.format(context);
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a delivery time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: paymentMethod,
                decoration: const InputDecoration(labelText: 'Payment Method'),
                items: ['Online', 'Pay on Delivery'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    paymentMethod = value!;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (paymentMethod == 'Online') {
                      _processPayment();
                    } else {
                      _placeOrder();
                    }
                  }
                },
                child: const Text('Place Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _processPayment() {
    // Simulating a payment process with a simple dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Payment'),
          content: const Text('Processing payment...'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _placeOrder();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _placeOrder() async {
    // Create an OrderModel instance
    OrderModel order = OrderModel(
      orderId: orderId,
      customerId: userId,
      productId: "productId", // Replace with actual product ID
      productName: "productName", // Replace with actual product name
      quantity: 1, // Replace with actual quantity
      totalPrice: 100.0, // Replace with actual total price
      status: "Pending",
      address: addressController.text,
      contactNumber: contactController.text,
      deliveryDate: deliveryDateController.text,
      deliveryTime: deliveryTimeController.text,
      orderPlacedAt: Timestamp.now(),
      paymentMethod: paymentMethod,
      userId: userId,
    );

    // Add the order to Firebase
    await FirebaseFirestore.instance.collection('orders').doc(order.orderId).set({
      'orderId': order.orderId,
      'customerId': order.customerId,
      'productId': order.productId,
      'productName': order.productName,
      'quantity': order.quantity,
      'totalPrice': order.totalPrice,
      'status': order.status,
      'address': order.address,
      'contactNumber': order.contactNumber,
      'deliveryDate': order.deliveryDate,
      'deliveryTime': order.deliveryTime,
      'orderPlacedAt': order.orderPlacedAt,
      'paymentMethod': order.paymentMethod,
      'userId': order.userId,
    });


    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Order Placed'),
          content: const Text('Your order has been placed successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
