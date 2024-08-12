import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:globalinfocloud_task/utils/constants.dart';
import 'package:globalinfocloud_task/views/registration/registration_screen.dart';


class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference userBuyers =
        FirebaseFirestore.instance.collection("users");
    return FutureBuilder<DocumentSnapshot>(
      future: userBuyers.doc(auth.currentUser?.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Center(child: Text("Document does not exist"));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              // backgroundColor: Colors.yellow.shade900,
              backgroundColor: Colors.transparent,

              centerTitle: true,
              title: const Text(
                "Profile",
                style: TextStyle(
                    // color: Colors.white,
                    letterSpacing: 4),
              ),
              actions: [
                IconButton(
                  icon: Icon(color: Colors.yellow.shade900, Icons.dark_mode),
                  onPressed: () {},
                ),
              ],
            ),
            body: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    // CircleAvatar(
                    //   radius: 64,
                    //   // backgroundImage: AssetImage("assets/images/avatar.png"),
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(200),
                    //     child: Image.network(
                    //       data["profileImageUrl"],
                    //       fit: BoxFit.cover,
                    //       height: double.infinity,
                    //       width: double.infinity,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(data["name"],
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),

                    Text(
                      
                      data["email"],
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),

                    // const SizedBox(height: 20,),

                    Container(
                        margin: const EdgeInsets.only(top: 20),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 200,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.yellow.shade900,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          "Edit  profile",
                          style: TextStyle(
                              color: Colors.white,
                              // fontSize: ,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold),
                        )),

                    const SizedBox(
                      height: 20,
                    ),

                    const Divider(
                      color: Colors.grey,
                    ),

                    // const SizedBox(height: 20,),

                    ListTile(
                      leading: const Icon(Icons.settings, color: Colors.grey),
                      title: Text(
                        "Settings",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone, color: Colors.grey),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Phone",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          Text(
                            data['contactNumber'],
                            style: const TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),

                    ListTile(
                      leading: const Icon(CupertinoIcons.cart_badge_plus,
                          color: Colors.grey),
                      title: Text(
                        "Cart",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.shopping_cart, color: Colors.grey),
                      title: Text(
                        "Orders",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),

                    ListTile(
                      onTap: () {
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: const Text("Are you sure you want to logout?"),
                            actions: [
                              TextButton(
                                child: const Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text("Logout"),
                                onPressed: () async{
                                  await FirebaseAuth.instance.signOut().whenComplete(() {
                                    EasyLoading.show();
                                     Navigator.of(context).pop();
                                     EasyLoading.dismiss();
                                     Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (context) => const RegistrationScreen() ),
                                      (Route<dynamic> route) => false
                                     
                                     );
                                  });
                                 
                                },
                              ),
                            ],
                          );
                        });
                      },
                      leading:
                          Icon(Icons.logout, color: Colors.yellow.shade900),
                      title: Text(
                        "Logout",
                        style: TextStyle(color: Colors.yellow.shade900),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Center(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LinearProgressIndicator(
            color: Colors.yellow.shade900,
          ),
        ));
      },
    );
  }
}