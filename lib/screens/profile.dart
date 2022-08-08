import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhiigplus/constants/colors.dart';
import 'package:dhiigplus/global/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final bloodTypeController = TextEditingController();
  final locationController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    // nameController.text = "Mohamed Abdirahman";
    // phoneController.text = "0617 678 889";
    // bloodTypeController.text = "B+";
    // locationController.text = "Hawlwadaag";
    // passwordController.text = "1234567890";
    super.initState();
  }

  final firestoreInstance = FirebaseFirestore.instance;
  var userModel = UserModel();

  Future getDocument() async {
    print("getDocument");

    //assume there is a collection called "users"
    var uid = fAuth.currentUser!.uid; //the unique user id/document id

    firestoreInstance.collection("users").doc(uid).get().then((querySnapshot) {
      print("result");
      print(querySnapshot.data()!);

      //convert the result to a model
    });
  }

  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    getDocument();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        centerTitle: true,
        title: const Text('Profile'),
      ),
      body: FutureBuilder(
        future: users.doc(fAuth.currentUser!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist, ${fAuth.currentUser!.uid}");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            nameController.text = data["fullname"];
            phoneController.text = data["phoneNumber"];
            bloodTypeController.text = data["bloodType"];
            locationController.text = data["district"];

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Name
                  TextFormField(
                    controller: nameController,
                    enabled: false,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      height: 1.6,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Your name',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: UnderlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), //Add rounded corners
                      ),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.black38,
                        //size: 30,
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),

                  // Phone Number
                  TextFormField(
                    controller: phoneController,
                    enabled: false,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      height: 1.6,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: UnderlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), //Add rounded corners
                      ),
                      prefixIcon: const Icon(
                        Icons.phone_in_talk,
                        color: Colors.black38,
                        //size: 30,
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),

                  // Blood Type
                  TextFormField(
                    controller: bloodTypeController,
                    enabled: false,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      height: 1.6,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Blood Type',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: UnderlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), //Add rounded corners
                      ),
                      prefixIcon: const Icon(
                        Icons.water_drop,
                        color: Colors.black38,
                        //size: 30,
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),

                  // Location
                  TextFormField(
                    controller: locationController,
                    enabled: false,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      height: 1.6,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Location',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: UnderlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), //Add rounded corners
                      ),
                      prefixIcon: const Icon(
                        Icons.pin_drop_rounded,
                        color: Colors.black38,
                        //size: 30,
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),

                  // Password
                  // TextFormField(
                  //   controller: passwordController,
                  //   obscureText: true,
                  //   obscuringCharacter: '*',
                  //   enabled: false,
                  //   style: const TextStyle(
                  //     fontWeight: FontWeight.w500,
                  //     fontSize: 18,
                  //     height: 1.6,
                  //   ),
                  //   decoration: InputDecoration(
                  //     labelText: 'Password',
                  //     filled: true,
                  //     fillColor: Colors.grey.shade200,
                  //     border: UnderlineInputBorder(
                  //       borderRadius:
                  //           BorderRadius.circular(10.0), //Add rounded corners
                  //     ),
                  //     prefixIcon: const Icon(
                  //       Icons.lock,
                  //       color: Colors.black38,
                  //       //size: 30,
                  //     ),
                  //     labelStyle: const TextStyle(
                  //       color: Colors.grey,
                  //     ),
                  //   ),
                  // ),
                  // TextButton(
                  //   onPressed: () {},
                  //   child: const Text(
                  //     'Change password',
                  //     style: TextStyle(
                  //       fontSize: 12,
                  //       color: Colors.blue,
                  //     ),
                  //   ),
                  // ),
                  Divider(
                    height: 60,
                    thickness: 1,
                    color: Colors.grey.shade400,
                  ),

                  Center(
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                          minimumSize: const Size(double.infinity, 60),
                          alignment: const Alignment(-0.999, 0)),
                      onPressed: () async {
                        setState(() {
                          appRouter.pushNamedAndRemoveUntil('/splash',
                              args: 'From Logout');
                          FirebaseAuth.instance.signOut();
                        });
                      },
                      icon: const Icon(
                        Icons.power_settings_new_outlined,
                        color: primary,
                        size: 30,
                      ),
                      label: const Text(
                        "Log out",
                        style: TextStyle(fontSize: 20, color: primary),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return Text("loading");
        },
        // child:
      ),
    );
  }
}
