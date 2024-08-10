import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:globalinfocloud_task/models/customer.dart';
import 'package:globalinfocloud_task/services/firebase_auth_service.dart';
import 'package:globalinfocloud_task/utils/constants.dart';
import 'package:globalinfocloud_task/utils/widget_comman.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  final Customer customer;
  const OTPVerificationScreen({
    Key? key,
    required this.verificationId,
    required this.phoneNumber,
    required this.customer,
  }) : super(key: key);

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();

  Future storeUsersDataInFirebaseFirestore(
      {required Customer customer, required BuildContext context}) async {
    try {
      await firestore.collection("users").doc(auth.currentUser!.uid).set({
        "uid": auth.currentUser!.uid,
        "name": customer.name,
        "contactNumber": customer.contactNumber,
        "email": customer.email,
        'pinCode': customer.pinCode,
        'state': customer.state,
        'city': customer.city,
        'address': customer.address,
        'password': customer.password,
      });
    } catch (e) {
      getMySnakBar(context: context, masage: e.toString());
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Enter the OTP sent to ${widget.phoneNumber}',
              style: const TextStyle(fontSize: 16.0),
            ),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'OTP'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {

               
                  

                  try {
                  

                  final phoneAuthCredential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: _otpController.text);
                  UserCredential cred =
                      await auth.signInWithCredential(phoneAuthCredential);
                  await storeUsersDataInFirebaseFirestore(
                      customer: widget.customer, context: context);
                  getMySnakBar(
                      context: context,
                      masage: "Account Created Successfully!");

                  Navigator.pushNamed(context, "/login");
                } on FirebaseAuthException catch (e) {
                  getMySnakBar(context: context, masage: e.code);
                  log(e.toString());
                }


                
              },
              child: Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
