import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:pinput/pinput.dart';

import '../global/global.dart';

enum MobileVerificationState {
  PhoneNumberState,
  OtpState,
}

class PhoneNumberState {}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  MobileVerificationState currentState =
      MobileVerificationState.PhoneNumberState;
  final phoneCotoroller = TextEditingController();
  final otpCotoroller = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  FirebaseAuth auth = FirebaseAuth.instance;
  late String verificationId;
  bool showLoading = false;
  void signInWithPhoneAuthCredential(phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
          await auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        appRouter.pushNamed('/home', args: 'From SignUp Screen');
      }
    } on FirebaseAuth catch (e) {
      setState(() {
        showLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  getMobileFormWidget(context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // LOGO
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Column(
                children: const <Widget>[
                  Icon(
                    CupertinoIcons.drop_fill,
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
                  // PHONE NUMBER

                  TextFormField(
                    controller: phoneCotoroller,
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
                      prefix: CountryCodePicker(
                        initialSelection: selectedCountryCode,
                        onChanged: assistant.onCountryChange,
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
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
                  const SizedBox(height: 20),
                ],
              ),
            ),
            // FULL NAME

            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 55,
                    width: 350,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: const BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          showLoading = true;
                        });
                        await auth.verifyPhoneNumber(
                          phoneNumber:
                              selectedCountryCode + phoneCotoroller.text.trim(),
                          verificationCompleted: (phoneAuthCredential) async {
                            setState(() {
                              showLoading = false;
                            });
                          },
                          verificationFailed: (verificationFailed) async {
                            setState(() {
                              showLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(verificationFailed.message!)));
                          },
                          codeSent: (verificationId, resendingToken) async {
                            setState(() {
                              showLoading = false;
                              currentState = MobileVerificationState.OtpState;
                              this.verificationId = verificationId;
                            });
                          },
                          codeAutoRetrievalTimeout: (verificationId) async {},
                        );
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
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 55,
                    width: 350,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side:
                                const BorderSide(color: Colors.red, width: 1.6),
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
    );
  }

  getOtpFormWidget(context) {
    return Column(
      children: [
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Pinput(
            onCompleted: (pin) => print(pin),
            length: 6,
            focusNode: _pinPutFocusNode,
            controller: otpCotoroller,
            pinAnimationType: PinAnimationType.fade,
            onSubmitted: (pin) async {
              final phoneAuthCredential = PhoneAuthProvider.credential(
                  verificationId: verificationId, smsCode: pin);
              signInWithPhoneAuthCredential(phoneAuthCredential);
            },
          ),
        ),
        const Spacer(),
      ],
    );
  }

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
        body: Container(
          child: showLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : currentState == MobileVerificationState.PhoneNumberState
                  ? getMobileFormWidget(context)
                  : getOtpFormWidget(context),
          padding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
