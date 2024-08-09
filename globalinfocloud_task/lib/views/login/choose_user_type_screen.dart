

import 'package:flutter/material.dart';
import 'package:globalinfocloud_task/views/admin/main_vendors_screen.dart';
import 'package:globalinfocloud_task/views/customer/customer_main_screen.dart';

class ChooseUserScreen extends StatelessWidget {
  const ChooseUserScreen({super.key});

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, 
                  MaterialPageRoute(builder: (_)=>MainVendorScreen())
                );
              },
              child: Container(
                  margin: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 30,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.yellow.shade900,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Admin",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        letterSpacing: 4,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CustomerMainScreen()));
              },
              child: Container(
                  margin: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 30,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.yellow.shade900,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Costomer",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        letterSpacing: 4,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            
          ],
        ),
      ),
    );
  }
}