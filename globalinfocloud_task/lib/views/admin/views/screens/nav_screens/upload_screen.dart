import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:globalinfocloud_task/utils/widget_comman.dart';
import 'package:globalinfocloud_task/views/admin/controllers/vendor_product_conttroller.dart';
import 'package:globalinfocloud_task/views/admin/views/screens/nav_screens/upload_tab_screens/genaral_tab.dart';
import 'package:globalinfocloud_task/views/admin/views/screens/nav_screens/upload_tab_screens/images_tab.dart';


import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class VendorUploadScreen extends StatelessWidget {
  VendorUploadScreen({super.key});

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  GlobalKey<FormState> _globalFormKey = new GlobalKey<FormState>();
  List<Widget> _tabsList = <Widget>[
    //bellow are screen of respective tabs
    GeneralTab(),
    ImageTab()
  ];

  @override
  Widget build(BuildContext context) {
    VendorProductController _vendorProductController =
        Provider.of<VendorProductController>(context);
    return DefaultTabController(
      length: 2,
      child: Form(
        key: _globalFormKey,
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.yellow.shade900,
            foregroundColor: Colors.white,
            title: Text("Upload Product"),
            bottom: TabBar(
              unselectedLabelColor: Colors.white38,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.white,
              tabs: [
                Tab(
                  child: Text(
                    "General",
                    style: TextStyle(
                        // color: Color.fromARGB(255, 255, 222, 222)
                        ),
                  ),
                ),
                
              
                Tab(
                  child: Text(
                    "Images",
                    style: TextStyle(
                        // color: Colors.white
                        ),
                  ),
                ),
              ],
              onTap: (value) {},
            ),
          ),
          body: TabBarView(children: _tabsList),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: GestureDetector(
            onTap: () async {
              if (_globalFormKey.currentState!.validate() ) {
                EasyLoading.show();
                final productId = Uuid().v4();
                _vendorProductController.getFormData(productId: productId);
                await _firebaseFirestore
                    .collection('Products')
                    .doc(productId)
                    .set(_vendorProductController.productData);
                    
                   print(_vendorProductController.productData.toString());

                    _vendorProductController.productData.clear();
                  EasyLoading.showSuccess("Product is added successfully!");
                  EasyLoading.dismiss();

              }else{
                getMySnakBar(context: context, masage: "Please add the product details");
              }
              print(_vendorProductController.productData.toString());
            },
            child: Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width - 30,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.yellow.shade900,
                  borderRadius: BorderRadius.circular(6)),
              child: true
                  ? Text(
                      "Save",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
