import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:globalinfocloud_task/views/customer/nav/account_screen.dart';
import 'package:globalinfocloud_task/views/customer/nav/cart_screen.dart';
import 'package:globalinfocloud_task/views/customer/nav/customer_home_screen.dart';

class CustomerMainScreen extends StatefulWidget {
  const CustomerMainScreen({super.key});

  @override
  State<CustomerMainScreen> createState() => _CustomerMainScreenState();
}

class _CustomerMainScreenState extends State<CustomerMainScreen> {
   int _pageIndex =0;

   List<Widget> _pages = [
    CousomerHomeScreen(),
    CartScreen(),
    AccountScreen(),
    // CategoryScreen(),
    // StoreScreen(),
    // CartScreen(),
    // SearchScreen(),
    // AccountScreen()
   ];
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
     
      body: _pages[_pageIndex],
     bottomNavigationBar: BottomNavigationBar( 
      type: BottomNavigationBarType.fixed,
      currentIndex: _pageIndex,
      onTap: (value) {
       setState(() {
          _pageIndex = value;
       });
      },
      selectedItemColor: Colors.yellow.shade900,
      unselectedItemColor: Colors.black,
      items: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          label: "HOME"),
        
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/icons/cart.svg"

          ),
          label: "CART"),
       
        
       
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/icons/account.svg"
          ),
          label: "ACCOUNT"),
       


      ],
     ),
    );
  }
}

