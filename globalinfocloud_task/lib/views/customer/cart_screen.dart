import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/customer_provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CustomerProvider>(context).getCart();
    final quantities = Provider.of<CustomerProvider>(context).getQuantities();
    final totalAmount = Provider.of<CustomerProvider>(context).getTotalAmount();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final product = cart[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.rate} x ${quantities[product]}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Implement remove from cart logic
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total: \$${totalAmount.toStringAsFixed(2)}'),
              ElevatedButton(
                onPressed: () {
                  // Implement checkout logic
                },
                child: Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
