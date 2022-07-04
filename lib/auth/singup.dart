import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:country_code_picker/country_code_picker.dart';

import '../global/global.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //  saveUserInfoNow() async {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext c) {
  //         return ProgressDialog(
  //           message: "Processing, Please wait...",
  //         );
  //       });

  //   final User? firebaseUser = (await fAuth
  //           .createUserWithEmailAndPassword(
  //     email: emailTextEditingController.text.trim(),
  //     password: passwordTextEditingController.text.trim(),
  //   )
  //           .catchError((msg) {
  //     Navigator.pop(context);
  //     Fluttertoast.showToast(msg: "Error: " + msg.toString());
  //   }))
  //       .user;

  //   if (firebaseUser != null) {
  //     Map userMap = {
  //       "id": firebaseUser.uid,
  //       "name": fullNameController.text.trim(),
  //       "phone": phoneNumberController.text.trim(),
  //       "district": selectedDistrict,
  //       "blood_type": selectedBloodType,
  //     };

  //     DatabaseReference usersRef =
  //         FirebaseDatabase.instance.ref().child("users");
  //     usersRef.child(firebaseUser.uid).set(userMap);

  //     currentFirebaseUser = firebaseUser;
  //     Fluttertoast.showToast(msg: "Account has been Created.");
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (c) => MySplashScreen()));
  //   } else {
  //     Navigator.pop(context);
  //     Fluttertoast.showToast(msg: "Account has not been Created.");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // LOGO
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Column(
                    children: const <Widget>[
                      Icon(
                        Icons.bloodtype,
                        size: 70,
                        color: Colors.red,
                      ),
                      Text(
                        'DhiigPlus+',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 32.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      TextFormField(
                        // controller: ,
                        textCapitalization: TextCapitalization.words,
                        autofillHints: const [AutofillHints.name],
                        style: const TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          height: 2,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Full name'.toUpperCase(),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: Colors.black87,
                            // size: 20,
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      // PHONE NUMBER
                      CountryCodePicker(
                        initialSelection: selectedCountryCode,
                        onChanged: assistant.onCountryChange,
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                      ),
                      TextFormField(
                        autofillHints: const [
                          AutofillHints.telephoneNumberNational
                        ],
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          height: 2,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Phone number'.toUpperCase(),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          prefixIcon: const Icon(
                            Icons.phone_outlined,
                            color: Colors.black87,
                            // size: 20,
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      // BLOOD TYPE
                      DropdownButtonHideUnderline(
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            InputDecorator(
                              decoration: const InputDecoration(
                                filled: false,
                                prefixIcon: Icon(
                                  Icons.bloodtype_outlined,
                                  color: Colors.black87,
                                ),
                                labelText: 'BLOOD TYPE',
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  height: 2,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              isEmpty: selectedBloodType == null,
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  menuMaxHeight: 500,
                                  isExpanded: false,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  value: selectedBloodType,
                                  isDense: true,
                                  onChanged: (bloodType) {
                                    setState(() {
                                      selectedBloodType = bloodType;
                                    });
                                  },
                                  items: bloodTypes
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          // height: 2,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // District
                      DropdownButtonHideUnderline(
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            InputDecorator(
                              decoration: const InputDecoration(
                                filled: false,
                                prefixIcon: Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.black87,
                                ),
                                labelText: 'DISTRICT',
                                // selectedCity == null ? 'PLEASE CHOOSE' : 'DISTRICT',
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  height: 2,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              isEmpty: selectedDistrict == null,
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  menuMaxHeight: 500,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  value: selectedDistrict,
                                  isDense: true,
                                  onChanged: (district) {
                                    setState(() {
                                      selectedDistrict = district;
                                    });
                                  },
                                  items: districts
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          // height: 0,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // PASSWORD
                      TextFormField(
                        obscureText: hidePassword,
                        autofillHints: const [AutofillHints.password],
                        style: const TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          height: 2,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Password'.toUpperCase(),
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_open_outlined,
                            color: Colors.black87,
                            // size: 20,
                          ),
                          suffixIcon: IconButton(
                            icon: hidePassword
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: Colors.black54,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Colors.black87,
                                  ),
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                // FULL NAME

                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 55,
                        width: 350,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side: const BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          onPressed: () {
                            assistant.verifyPhone(context);
                          },
                          child: Text(
                            'Send OTP'.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              letterSpacing: 1.8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 55,
                        width: 350,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side: const BorderSide(
                                    color: Colors.red, width: 1.6),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Log in'.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.red,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              letterSpacing: 1.8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
