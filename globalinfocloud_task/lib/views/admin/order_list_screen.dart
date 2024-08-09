// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../models/order.dart';
// import '../../providers/admin_provider.dart';

// class OrderListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final orders = Provider.of<AdminProvider>(context).getOrders();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order List'),
//       ),
//       body: ListView.builder(
//         itemCount: orders.length,
//         itemBuilder: (context, index) {
//           final order = orders[index];
//           return ListTile(
//             title: Text(order.customerName),
//             subtitle: Text('Total: \$${order.products[index].rate}'),
//             onTap: () {
//               Navigator.pushNamed(
//                 context,
//                 '/orderDetails',
//                 arguments: order,
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
