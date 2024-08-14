import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:globalinfocloud_task/models/product.dart';
import 'package:globalinfocloud_task/utils/constants.dart';
import 'package:globalinfocloud_task/views/customer/controllers/add_to_cart_controller.dart';
import 'package:globalinfocloud_task/views/customer/nav/nested_home_product/orders.dart';
import 'package:globalinfocloud_task/views/customer/nav/nested_home_product/product_details_screen.dart';
import 'package:provider/provider.dart';

class CousomerHomeScreen extends StatefulWidget {
  const CousomerHomeScreen({super.key});

  @override
  State<CousomerHomeScreen> createState() => _CousomerHomeScreenState();
}

class _CousomerHomeScreenState extends State<CousomerHomeScreen> {
  int notificationCount = 0;

  @override
  void initState() {
    super.initState();
    _listenToOrderStatus();
  }

  void _listenToOrderStatus() {
    FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: auth.currentUser!.uid)
        .snapshots()
        .listen((snapshot) {
      int newNotificationCount = 0;
      for (var doc in snapshot.docs) {
        if (doc['status'] != 'Pending') {
          newNotificationCount++;
        }
      }
      setState(() {
        notificationCount = newNotificationCount;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final addToCartController = Provider.of<AddToCartController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products List'),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  Navigator.of(context).push(
                
                    MaterialPageRoute(builder: (_)=>    UserOrdersScreen())
                  );
                },

              ),
              if (notificationCount > 0)
                Positioned(
                  right: 11,
                  top: 11,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$notificationCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No products available'));
          }

          List<Product> products = snapshot.data!.docs.map((doc) => Product.fromFirestore(doc)).toList();

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              Product product = products[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(product: product),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 252, 243, 243),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        fit: BoxFit.cover,
                        product.imageUrlList[0],
                      ),
                    ),
                    title: Text(product.name),
                    subtitle: Text(product.description),
                    trailing: InkWell(
                      onTap: () {
                        addToCartController.addToCart(product);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text('Add to Cart'),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
