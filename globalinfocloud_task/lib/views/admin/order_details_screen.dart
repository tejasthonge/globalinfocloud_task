// import 'package:flutter/material.dart';
// import '../../models/order.dart';

// class OrderDetailsScreen extends StatelessWidget {
//   final Order order;

//   OrderDetailsScreen({required this.order});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order Details'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Customer Name: ${order.customerName}'),
//             Text('Shipping Address: ${order.shippingAddress}'),
//             Text('Contact Number: ${order.contactNumber}'),
//             Text('Delivery Date: ${order.deliveryDateTime}'),
//             SizedBox(height: 16.0),
//             Text('Products:'),
//             // ...order.products.entries.map((entry) {
//             //   return Text(
//             //       '${entry.key.name} x ${entry.value} = \$${(entry.key.rate * entry.value).toStringAsFixed(2)}');
//             // }),
//             SizedBox(height: 16.0),
//             // Text('Total Amount: \$${order.products[i}'),
//             SizedBox(height: 16.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     // Implement accept order logic
//                   },
//                   child: Text('Accept'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Implement reject order logic
//                   },
//                   child: Text('Reject'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
