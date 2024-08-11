

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:globalinfocloud_task/views/admin/views/screens/nav_screens/edit_screen.dart';
import 'package:globalinfocloud_task/views/admin/views/screens/nav_screens/upload_screen.dart';
import 'package:globalinfocloud_task/views/admin/views/screens/nav_screens/vendor_logout_screen.dart';
import 'package:globalinfocloud_task/views/admin/views/screens/nav_screens/vendors_orders_screen.dart';

class MainVendorScreen extends StatefulWidget {
   const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
    int _pageIndex =0;

   final List<Widget> _pages = [
    VendorUploadScreen(),
    const VendorEditScreen(),
    const OrdersScreen(),
    const VendorLogotScreen(),

   ];

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
     
      body: _pages[_pageIndex],
     bottomNavigationBar: BottomNavigationBar( 
      currentIndex: _pageIndex,
      onTap: (value) {
       setState(() {
          _pageIndex = value;
       });
      },
      selectedItemColor: Colors.yellow.shade900,
      unselectedItemColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.money_dollar),
          label: "EARNINGS",),
        BottomNavigationBarItem(
          icon: Icon(Icons.upload),
          label: "UPLOAD"),
      
       
      
        BottomNavigationBarItem(
          icon: Icon(Icons.edit),
          label: "EDIT"),
      
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.shopping_cart), 
          label: "ORDERS"),
      
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: "LOGOUT"),
      
        
       
       
      ],
     ),
    );
  }
}