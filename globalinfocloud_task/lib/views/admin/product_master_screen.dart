// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../models/product.dart';
// import '../../providers/admin_provider.dart';

// class ProductMasterScreen extends StatefulWidget {
//   @override
//   _ProductMasterScreenState createState() => _ProductMasterScreenState();
// }

// class _ProductMasterScreenState extends State<ProductMasterScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _rateController = TextEditingController();
//   List<String> _images = [];

//   Future<void> _addProduct() async {
//     if (_formKey.currentState!.validate()) {
//       final product = Product(
//         name: _nameController.text,
//         images: _images,
//         description: _descriptionController.text,
//         rate: double.parse(_rateController.text),
//       );

//       Provider.of<AdminProvider>(context, listen: false).addProduct(product);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Product Master'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(labelText: 'Product Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter product name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _descriptionController,
//                 decoration: InputDecoration(labelText: 'Description'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter description';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _rateController,
//                 decoration: InputDecoration(labelText: 'Rate'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter rate';
//                   }
//                   return null;
//                 },
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   // Implement file picker for product images
//                   // Set _images
//                 },
//                 child: Text('Upload Images'),
//               ),
//               ElevatedButton(
//                 onPressed: _addProduct,
//                 child: Text('Add Product'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
