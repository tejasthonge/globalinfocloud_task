import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:globalinfocloud_task/utils/constants.dart';
import 'package:globalinfocloud_task/views/admin/models/orders_model.dart';

class UserOrdersScreen extends StatelessWidget {
  const UserOrdersScreen({super.key});

  Stream<List<OrderModel>> getUserOrdersStream(String userId) {
    return FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => OrderModel.fromFirestore(doc)).toList());
  }

  @override
  Widget build(BuildContext context) {
    final String userId = auth.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: StreamBuilder<List<OrderModel>>(
        stream: getUserOrdersStream(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading orders'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No orders found'));
          }

          final orders = snapshot.data!;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                child: ListTile(
                  title: Text(order.productName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantity: ${order.quantity}'),
                      Text('Total: \$${order.totalPrice.toStringAsFixed(2)}'),
                      Text(
                        'Status: ${order.status}',
                        style: TextStyle(
                          color: order.status == 'Accepted'
                              ? Colors.green
                              : order.status == 'Rejected'
                                  ? Colors.red
                                  : Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    _showOrderDetails(context, order);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showOrderDetails(BuildContext context, OrderModel order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Order Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Product: ${order.productName}'),
              Text('Quantity: ${order.quantity}'),
              Text('Total Price: \$${order.totalPrice.toStringAsFixed(2)}'),
              Text('Status: ${order.status}'),
              Text('Delivery Date: ${order.deliveryDate}'),
              Text('Delivery Time: ${order.deliveryTime}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
