import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class VendorLogotScreen extends StatelessWidget {
  const VendorLogotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( 

      body: Center(
        child: TextButton( 

          onPressed: ()async{
            EasyLoading.show();
            await FirebaseAuth.instance.signOut()
             .whenComplete(() {
                EasyLoading.dismiss();
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              });
          },
          child: Text( 
            "Logout"
          ),
        )
      ),
    );
  }
}