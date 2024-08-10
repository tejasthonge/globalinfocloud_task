
import 'package:flutter/material.dart';
import 'package:globalinfocloud_task/utils/constants.dart';
import 'package:globalinfocloud_task/utils/widget_comman.dart';



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:globalinfocloud_task/views/login/choose_user_type_screen.dart';

class LoginController {


  Future<void> loginCustomer({required String contactNumber, required String password ,required BuildContext context}) async {
    try {
      // Look up the customer by contact number
      QuerySnapshot querySnapshot = await firestore
          .collection("users")
          .where("contactNumber", isEqualTo: contactNumber)
          .get();

      if (querySnapshot.docs.isEmpty) {
        getMySnakBar(context:context , masage: "Customer not registered.");
        print("Customer not registered.");
        return;
      }


      DocumentSnapshot customerDoc = querySnapshot.docs.first;
      Map<String, dynamic> customerData = customerDoc.data() as Map<String, dynamic>;


      if (customerData['password'] == password) {
        getMySnakBar(context: context, masage: "Login Successfully.");
        print("Login successful.");
        // Navigator.pushNamedAndRemoveUntil(context, "/admin", (route) => false);
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_)=>ChooseUserScreen())
        );

      } else {
        getMySnakBar(context: context, masage: "Invalid password.");

        print("Invalid password.");
      }
    } catch (e) {
      print("Error during login: $e");
    }
  }
}

