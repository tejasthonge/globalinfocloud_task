
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:globalinfocloud_task/firebase_options.dart';
import 'package:globalinfocloud_task/views/admin/controllers/vendor_product_conttroller.dart';

import 'package:globalinfocloud_task/views/customer/controllers/add_to_cart_controller.dart';


import 'package:provider/provider.dart';
import 'providers/registration_provider.dart';
import 'providers/login_provider.dart';
import 'providers/admin_provider.dart';

import 'views/registration/registration_screen.dart';
import 'views/login/login_screen.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( 
    options: DefaultFirebaseOptions.currentPlatform
  );
  

  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegistrationProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
        // ChangeNotifierProvider(create: (_) => CustomerProvider()),
        ChangeNotifierProvider(create: (_) => VendorProductController()),
        ChangeNotifierProvider(create: (_) => VendorProductController()),
        ChangeNotifierProvider(create: (_)=>AddToCartController())
      ],
      child: MaterialApp(
        title: 'Customer App',
        theme: ThemeData.light(
           useMaterial3: true,).copyWith(
            textTheme: ThemeData.light().textTheme.apply(
              fontFamily: 'Brand-Bold',
            ),
          
          // scaffoldBackgroundColor: Color.fromARGB(155, 100, 100, 100),

          appBarTheme: AppBarTheme( 
          
            backgroundColor: Colors.yellow.shade900,
            centerTitle: true,
            foregroundColor: Colors.white
          )
        ),
      
        initialRoute: '/',
        routes: {
          '/': (context) => const RegistrationScreen(),
          '/login': (context) => const LoginScreen(),

        },
        builder: EasyLoading.init(),
      ),
    );
  }
}
