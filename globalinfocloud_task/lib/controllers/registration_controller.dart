import 'dart:developer';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:globalinfocloud_task/utils/widget_comman.dart';
import 'package:globalinfocloud_task/views/registration/otp_reg_screen.dart';
import '../models/customer.dart';
import '../services/api_service.dart';



class RegistrationController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerCustomer(BuildContext context, Customer customer) async {

    if(await isAlreadyRegistered(phoneNumber: customer.contactNumber)){
      // ignore: use_build_context_synchronously
      getMySnakBar(context: context, masage: "Your Mobile Number already registered");
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, "/login");
    }else{
        var cityState = await ApiService.getCityState(customer.pinCode);
    if (cityState['city']!.toLowerCase() != customer.city.toLowerCase() && cityState['state']!.toLowerCase() != customer.state.toLowerCase()) {
      log("City and State do not match with pin code");
      // ignore: use_build_context_synchronously
      getMySnakBar(context: context, masage: "City and State do not match with pin code");
      throw Exception('City and State do not match with pin code');
    }


      _auth.verifyPhoneNumber(
        phoneNumber: customer.contactNumber,
        verificationCompleted:(phoneAuthCredential){

        } , 
        verificationFailed: (error){

          log(error.toString());
          getMySnakBar(context: context, masage: error.toString());
        },
         codeSent: (verificationId, forceResendingToken) {
           
           Navigator.of(context).push(
             MaterialPageRoute(
               builder: (context) => OTPVerificationScreen(
                verificationId: verificationId,
                phoneNumber: customer.contactNumber,
                customer: customer,
               ),
             ),
           );
         },
          codeAutoRetrievalTimeout: (
            verificationId
          ){
            // getMySnakBar(context: context, masage: "Auto retrieval timeout");
          },
          );
    }
  }

Future<bool> isAlreadyRegistered({required String phoneNumber}) async {

    try {

      QuerySnapshot querySnapshot = await _firestore
          .collection("users")
          .where("contactNumber", isEqualTo: phoneNumber)
          .get();


      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      log("Error checking registration status: $e");
      return false;
    }
  }


}
