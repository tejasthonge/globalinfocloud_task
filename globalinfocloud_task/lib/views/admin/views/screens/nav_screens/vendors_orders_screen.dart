import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:globalinfocloud_task/views/admin/models/orders_model.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  Stream<List<OrderModel>> getOrdersStream() {
    return FirebaseFirestore.instance
        .collection('orders')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => OrderModel.fromFirestore(doc)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Orders'),
      ),
      body: StreamBuilder<List<OrderModel>>(
        stream: getOrdersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error loading orders'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No orders found'));
          }

          final orders = snapshot.data!;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                child: ListTile(
                  title: Text(order.productName),
                  subtitle: Text('Total: \$${order.totalPrice}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.check, color: Colors.green),
                        onPressed: () {
                          _updateOrderStatus(order.orderId, 'Accepted');
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.red),
                        onPressed: () {
                          _updateOrderStatus(order.orderId, 'Rejected');
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    _showOrderDetails(context,order );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _updateOrderStatus(String orderId, String status) {
    FirebaseFirestore.instance
        .collection('orders')
        .doc(orderId)
        .update({'status': status});
  }

  void _showOrderDetails(BuildContext context, OrderModel order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Product: ${order.productName}'),
              Text('Quantity: ${order.quantity}'),
              Text('Total Price: \$${order.totalPrice}'),
              Text('Status: ${order.status}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
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
