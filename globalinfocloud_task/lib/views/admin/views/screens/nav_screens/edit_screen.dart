import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendorEditScreen extends StatelessWidget {
  const VendorEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No products available'));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return ListTile(
                title: Text(doc['productName']),
                subtitle: Text('Price: \$${doc['productPrice']}'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditProductScreen(productId: doc.id),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class EditProductScreen extends StatefulWidget {
  final String productId;

  EditProductScreen({required this.productId});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProductDetails();
  }

  void _loadProductDetails() async {
    DocumentSnapshot productDoc = await FirebaseFirestore.instance
        .collection('products')
        .doc(widget.productId)
        .get();

    if (productDoc.exists) {
      Map<String, dynamic> productData =
          productDoc.data() as Map<String, dynamic>;
      setState(() {
        nameController.text = productData['productName'] ?? '';
        descriptionController.text = productData['productDescription'] ?? '';
        priceController.text = productData['productPrice'].toString();
        imageUrlController.text =
            (productData['imageUrlList'] as List<dynamic>).isNotEmpty
                ? productData['imageUrlList'][0]
                : '';
      });
    }
  }

  void _saveProductDetails() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.productId)
          .update({
        'productName': nameController.text,
        'productDescription': descriptionController.text,
        'productPrice': double.tryParse(priceController.text) ?? 0.0,
        'imageUrlList': [imageUrlController.text], // Assuming one image
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product updated successfully!')),
      );

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Product Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Product Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: imageUrlController,
                decoration: InputDecoration(labelText: 'Product Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product image URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveProductDetails,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
