import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:globalinfocloud_task/views/admin/controllers/vendor_product_conttroller.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GeneralTab extends StatefulWidget {
  const GeneralTab({super.key});

  @override
  State<GeneralTab> createState() => _GeneralTabState();
}

class _GeneralTabState extends State<GeneralTab> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _productNameTEC = TextEditingController();

  final TextEditingController _productPriseTEC = TextEditingController();

  final TextEditingController _proquctQuantityTEC = TextEditingController();

  String _selectedProductCategory ='';

  final TextEditingController _productDiscriptionTEC = TextEditingController();

   List<String> _productCategoryList = <String>[];
   String? sheduledDate;

   FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  String _formateDate(date){

    final formate= DateFormat('dd/MM/yyyy');
    return formate.format(date);
  }

   _getCategourys()async{

    return _firebaseFirestore.collection("Category").get().then((QuerySnapshot querySnapshot) {

      querySnapshot.docs.forEach((doc) { 

        setState(() {
          _productCategoryList.add(doc["categoryName"]);
        });
      });
    });

   }

   @override
  void initState() {
    _getCategourys().whenComplete((){
      print(_productCategoryList);
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    VendorProductController _vendorProductController = Provider.of<VendorProductController>(context);
    return Padding(
      padding: EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _productNameTEC,
                onChanged: (value) {
                  _vendorProductController.getFormData(productName: value);
                },
                decoration: InputDecoration(labelText: "Enter product name"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter product name";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _productPriseTEC,
                onChanged: (value) {
                  _vendorProductController.getFormData(productPrice: double.parse(value));
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Enter product Price"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter product price";
                  }
                  return null;
                },
              ),
            
              const SizedBox(
                height: 10,
              ),
              
              
              // DropdownButtonFormField(
              //   hint: Text("Select Product Category"),


              //   items:_productCategoryList.map<DropdownMenuItem<String>>((e){
              //     return DropdownMenuItem(
              //       value: e,
              //       child: Text(e),
              //     );
              //   }).toList(),

              // onChanged: ((value){
              //   _vendorProductController.getFormData(productCategory: value);

              //   _selectedProductCategory = value! ;
              // })
              
              // ),

              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _productDiscriptionTEC,
                onChanged: (value) {
                  _vendorProductController.getFormData(productDescription: value); //
                },
                keyboardType: TextInputType.text,
                maxLines: 4,
                maxLength: 800,
                
                decoration:
                    InputDecoration(
                      border: OutlineInputBorder( 
                        borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: "Enter product Discreption"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter product Discreption";
                  }
                  return null;
                },
              ),


             
            ],
          ),
        ),
      ),
    );
  }
}
