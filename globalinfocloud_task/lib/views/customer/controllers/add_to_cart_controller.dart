


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:globalinfocloud_task/models/product.dart';
import 'package:globalinfocloud_task/utils/constants.dart';

class AddToCartController extends ChangeNotifier{

  void addToCart(Product product) async {
  EasyLoading.show(status: "Adding to cart please Wait...");


 try {
    final cartItem = FirebaseFirestore.instance
      .collection('cart')
      .doc("2l5KPbYazgf5BvOeMkb5vLf4sRe2")
      .collection('items')
      .doc(product.id);

  await cartItem.set({
    'productId': product.id,
    'productName': product.name,
    'productDescription': product.description,
    'productPrice': product.price,
    'imagUrlList': product.imageUrlList,
    'quantity': 1, 
  });
  EasyLoading.showSuccess("Product Added To The Cart");
 } catch (e) {
   EasyLoading.showError("Gotted Error");
 }
  EasyLoading.dismiss();


}

}