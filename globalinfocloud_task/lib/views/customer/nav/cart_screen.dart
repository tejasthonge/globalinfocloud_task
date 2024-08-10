import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:globalinfocloud_task/utils/constants.dart';
import 'package:globalinfocloud_task/views/customer/nav/nested_home_product/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  // final String userId = auth.currentUser!.uid; // Replace with actual user ID from authentication

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .doc("2l5KPbYazgf5BvOeMkb5vLf4sRe2")
            .collection('items')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No items in the cart'));
          }

          List<QueryDocumentSnapshot> cartItems = snapshot.data!.docs;
          double totalAmount = cartItems.fold(0, (sum, doc) {
            return sum + doc['productPrice'] * doc['quantity'];
          });

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    var cartItem = cartItems[index];
                    return ListTile(
                      leading: Image.network(cartItem['imagUrlList'][0]),
                      title: Text(cartItem['productName']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('\$${cartItem['productPrice'].toStringAsFixed(2)}'),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  updateCartQuantity(cartItem.id, cartItem['quantity'] - 1);
                                },
                              ),
                              Text('${cartItem['quantity']}'),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  updateCartQuantity(cartItem.id, cartItem['quantity'] + 1);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Text('Total: \$${(cartItem['productPrice'] * cartItem['quantity']).toStringAsFixed(2)}'),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('Total: \$${totalAmount.toStringAsFixed(2)}'),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_)=>CheckoutScreen())
                        );
                      },
                      child: Text('Proceed to Checkout'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void updateCartQuantity(String productId, int quantity) {
    if (quantity > 0) {
      FirebaseFirestore.instance
          .collection('cart')
          .doc("2l5KPbYazgf5BvOeMkb5vLf4sRe2")
          .collection('items')
          .doc(productId)
          .update({'quantity': quantity});
    } else {
      FirebaseFirestore.instance
          .collection('cart')
          .doc("2l5KPbYazgf5BvOeMkb5vLf4sRe2")
          .collection('items')
          .doc(productId)
          .delete();
    }
  }
}
