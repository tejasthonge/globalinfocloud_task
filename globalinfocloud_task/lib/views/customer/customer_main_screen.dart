import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomerMainScreen extends StatefulWidget {
  const CustomerMainScreen({super.key});

  @override
  State<CustomerMainScreen> createState() => _CustomerMainScreenState();
}

class _CustomerMainScreenState extends State<CustomerMainScreen> {
   int _pageIndex =0;

   List<Widget> _pages = [
    // HomeScreen(),
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
            "assets/icons/explore.svg",
            // width: 20,

          ),
          label: "CATEGORIES"),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/icons/shop.svg"
          ),
          label: "STORE"),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/icons/cart.svg"
          ),
          label: "CART"),
       
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/icons/search.svg"
          ),
          label: "SEARCH"),
       
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