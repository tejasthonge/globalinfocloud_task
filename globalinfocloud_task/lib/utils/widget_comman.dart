

import 'package:flutter/material.dart';

 getMySnakBar({required BuildContext context ,required String masage}){
  ScaffoldMessenger.of(context).showSnackBar(
        
        SnackBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 2),
          elevation: 10,
          backgroundColor: Colors.yellow.shade900,
          content: Text(masage)),
      );
}