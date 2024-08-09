// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../providers/customer_provider.dart';

// class CheckoutScreen extends StatefulWidget {
//   @override
//   _CheckoutScreenState createState() => _CheckoutScreenState();
// }

// class _CheckoutScreenState extends State<CheckoutScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _shippingAddressController = TextEditingController();
//   final _contactNumberController = TextEditingController();
//   DateTime? _deliveryDateTime;
//   String _paymentMethod = 'Online';

//   @override
//   void initState() {
//     super.initState();
//     final customerProvider = Provider.of<CustomerProvider>(context, listen: false);
//     _shippingAddressController.text = customerProvider.customer.address;
//     _contactNumberController.text = customerProvider.customer.contactNumber;
//   }

//   Future<void> _selectDeliveryDate() async {
//     final selectedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(Duration(days: 365)),
//     );
//     if (selectedDate != null) {
//       final selectedTime = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//       );
//       if (selectedTime != null) {
//         setState(() {
//           _deliveryDateTime = DateTime(
//             selectedDate.year,
//             selectedDate.month,
//             selectedDate.day,
//             selectedTime.hour,
//             selectedTime.minute,
//           );
//         });
//       }
//     }
//   }

//   Future<void> _placeOrder() async {
//     if (_formKey.currentState!.validate() && _deliveryDateTime != null) {
//       final shippingAddress = _shippingAddressController.text;
//       final contactNumber = _contactNumberController.text;

//       Provider.of<CustomerProvider>(context, listen: false)
//           .checkout(shippingAddress, contactNumber, _deliveryDateTime!);

//       // Navigate to order confirmation screen or show success message
//     } else {
//       // Show error message
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Checkout'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _shippingAddressController,
//                 decoration: InputDecoration(labelText: 'Shipping Address'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter shipping address';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _contactNumberController,
//                 decoration: InputDecoration(labelText: 'Contact Number'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter contact number';
//                   }
//                   return null;
//                 },
//               ),
//               ListTile(
//                 title: Text('Delivery Date and Time'),
//                 subtitle: Text(
//                   _deliveryDateTime == null
//                       ? 'Select date and time'
//                       : _deliveryDateTime.toString(),
//                 ),
//                 onTap: _selectDeliveryDate,
//               ),
//               DropdownButtonFormField<String>(
//                 value: _paymentMethod,
//                 items: ['Online', 'Pay on Delivery']
//                     .map((method) => DropdownMenuItem(
//                           value: method,
//                           child: Text(method),
//                         ))
//                     .toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _paymentMethod = value!;
//                   });
//                 },
//                 decoration: InputDecoration(labelText: 'Payment Method'),
//               ),
//               ElevatedButton(
//                 onPressed: _placeOrder,
//                 child: Text('Place Order'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
