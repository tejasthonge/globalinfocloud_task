import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:globalinfocloud_task/models/product.dart';
import 'package:globalinfocloud_task/views/customer/controllers/add_to_cart_controller.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    final addToCartController = Provider.of<AddToCartController>(context,listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Product Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  fit: BoxFit.cover,
                  product.imageUrlList[0])),
              SizedBox(height: 16.0),
              Text(product.name, style: TextStyle(fontSize: 24)),
              SizedBox(height: 16.0),
              Text(product.description),
              SizedBox(height: 16.0),
              Text('\$${product.price.toStringAsFixed(2)}'),
              SizedBox(height: 16.0),
              InkWell(
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
            ],
          ),
        ),
      ),
    );
  }
}
