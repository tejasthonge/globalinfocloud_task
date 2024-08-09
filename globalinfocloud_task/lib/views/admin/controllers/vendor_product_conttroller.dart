



import 'package:flutter/material.dart';

class VendorProductController extends ChangeNotifier{

   



  Map<String ,dynamic> productData = {};

  getFormData( {
    String? productName,
    double? productPrice,
    String? productDescription,
    List<String>? imagUrlList ,
    String? productId,
  }){


    if (productName!=null) {
      productData["productName"] =productName;
    }
    if (productPrice!=null) {
      productData["productPrice"] =productPrice;
    }
 

    if (productDescription!=null) {
      productData["productDescription"] =productDescription;
    }

    if(imagUrlList!=null){
      productData["imagUrlList"] =imagUrlList;
    }
  
 
    if (productId !=null) {
      productData["productId"] =productId;
    }
    notifyListeners();
  }
}
