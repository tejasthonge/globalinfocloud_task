import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:globalinfocloud_task/models/product.dart';
import 'package:globalinfocloud_task/views/customer/controllers/add_to_cart_controller.dart';
import 'package:globalinfocloud_task/views/customer/nav/nested_home_product/product_details_screen.dart';
import 'package:provider/provider.dart';

class CousomerHomeScreen extends StatefulWidget {
  const CousomerHomeScreen({super.key});

  @override
  State<CousomerHomeScreen> createState() => _CousomerHomeScreenState();
}

class _CousomerHomeScreenState extends State<CousomerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final addToCartController = Provider.of<AddToCartController>(context,listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('Products List')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No products available'));
          }

          List<Product> products = snapshot.data!.docs.map((doc) => Product.fromFirestore(doc)).toList();

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              Product product = products[index];
              return InkWell(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(product: product),
                    )
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                  decoration: BoxDecoration( 
                    color: Color.fromARGB(255, 252, 243, 243),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: ListTile(
                    
                    leading: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  fit: BoxFit.cover,
                  product.imageUrlList[0])),
                    title: Text(product.name),
                    subtitle: Text(product.description),
                    trailing: InkWell(
                      onTap: () {

                        addToCartController.addToCart(product);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 4,horizontal: 10),
                        decoration: BoxDecoration( 
                  
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(5),
                  
                        ),
                        child: Text('Add to Cart')),
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