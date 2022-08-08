import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhiigplus/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../global/global.dart';

enum MobileVerificationState { PhoneNumberState, OtpState, UserInformation }

class PhoneNumberState {}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? _selectedDistrict;
  String? _selectedBloodType;
  final List<String> _bloodTypes = [
    'O-',
    'O+',
    'A-',
    'A+',
    'B-',
    'B+',
    'AB-',
    'AB+'
  ];
  final List<String> _districts = [
    'Hodan',
    'H/wadaag',
    'Hilwaa',
    'X/Weyne',
    'X/Jajab',
    'Shibis',
    'Shingani',
    'Abdiaziz',
    'W/Nabada',
    'Waaberi',
    'Wadajir',
    'Yaaqshid',
    'Dharkenley',
    'Kaxda',
    'Bondhere',
    'Kaaraan',
    'Daynile'
  ];
  MobileVerificationState currentState =
      MobileVerificationState.PhoneNumberState;
  final phoneCotoroller = TextEditingController();
  final otpCotoroller = TextEditingController();
  Color focusedBorderColor = const Color.fromRGBO(23, 171, 144, 1);
  Color fillColor = const Color.fromRGBO(243, 246, 249, 0);
  final focusNode = FocusNode();
  @override
  void dispose() {
    otpCotoroller.dispose();
    phoneCotoroller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: GoogleFonts.poppins(
      fontSize: 22,
      color: primary,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: const Color.fromRGBO(23, 171, 144, 0.4)),
    ),
  );

  Future saveUser() async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    FirebaseFirestore.instance
        .collection('Users')
        .doc(fAuth.currentUser!.uid)
        .set({
      'id': fAuth.currentUser!.uid,
      'fullname': fullNameController.text.trim(),
      'district': _selectedDistrict,
      'bloodType': _selectedBloodType,
      'phoneNumber': phoneCotoroller.text.trim()
    }).then((value) => appRouter
            .pushNamedAndRemoveUntil('/home', args: 'From Login Screen')
            .catchError((error) => print("Failed to add User: $error")));
    ;

    // if (fAuth.currentUser != null) {
    //   users.add({})

    //   // users
    //   //     .doc('doc_id')
    //   //     .set(currentFirebaseUser!.uid)
    //   //     .then((_) => print('Added'))
    //   //     .catchError((error) => print('Add failed: $error'));
    // }

    // await FirebaseFirestore.instance.collection('Requests').add({
    //   'hospital': selectedhospital,
    //   'district': selectedDistrict,
    //   'bloodType': selectedBloodType,
    //   'date': selectedDate,
    //   'name': 'Shirwac',
    // });
  }
  // CollectionReference users = FirebaseFirestore.instance
  //   .collection('users')
  //   .get()
  //   .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       print('Document data: ${documentSnapshot.data()}');
  //     } else {
  //       print('Document does not exist on the database');
  //     }
  //   }) as CollectionReference<Object?>;

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

      if (authCredential.user != null) {}
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
                      prefix: const Text(
                        '+252 ',
                        style: TextStyle(color: Colors.red),
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
                          phoneNumber: '+252${phoneCotoroller.text.trim()}',
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
            // Container(
            //   margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            //   child: Column(
            //     children: <Widget>[
            //       SizedBox(
            //         height: 55,
            //         width: 350,
            //         child: ElevatedButton(
            //           style: ButtonStyle(
            //             backgroundColor:
            //                 MaterialStateProperty.all<Color>(Colors.white),
            //             shape:
            //                 MaterialStateProperty.all<RoundedRectangleBorder>(
            //               RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(50.0),
            //                 side:
            //                     const BorderSide(color: Colors.red, width: 1.6),
            //               ),
            //             ),
            //           ),
            //           onPressed: () {
            //             appRouter.pushNamed('/login',
            //                 args: 'From SignUp Screen');
            //           },
            //           child: Text(
            //             'Log in'.toUpperCase(),
            //             style: const TextStyle(
            //               color: Colors.red,
            //               fontFamily: 'Montserrat',
            //               fontWeight: FontWeight.w700,
            //               fontSize: 20,
            //               letterSpacing: 1.8,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  getOtpFormWidget(context) {
    return Column(
      children: [
        const Spacer(),
        const Text(
          'Verification',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Enter your OTP code number",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black38,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 28,
        ),
        Directionality(
          // Specify direction if desired
          textDirection: TextDirection.ltr,
          child: Center(
            child: Pinput(
              length: 6,
              controller: otpCotoroller,
              focusNode: focusNode,
              // androidSmsAutofillMethod:
              //     AndroidSmsAutofillMethod.smsUserConsentApi,
              listenForMultipleSmsOnAndroid: true,
              defaultPinTheme: defaultPinTheme,
              // validator: (value) {
              //   return value == '2222' ? null : 'Pin is incorrect';
              // },
              onClipboardFound: (value) {
                debugPrint('onClipboardFound: $value');
                otpCotoroller.setText(value);
              },
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: (pin) {
                debugPrint('onCompleted: $pin');
              },
              onChanged: (value) {
                debugPrint('onChanged: $value');
              },
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: focusedBorderColor,
                  ),
                ],
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
              onSubmitted: (pin) async {
                final phoneAuthCredential = PhoneAuthProvider.credential(
                    verificationId: verificationId, smsCode: pin);
                signInWithPhoneAuthCredential(phoneAuthCredential);
                setState(() {
                  currentState = MobileVerificationState.UserInformation;
                });
              },
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }

  userInfo(contex) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
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
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: fullNameController,
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
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Column(
                children: <Widget>[
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
                          isEmpty: _selectedDistrict == null,
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              menuMaxHeight: 500,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              value: _selectedDistrict,
                              isDense: true,
                              onChanged: (district) {
                                // print('New value: ${district!}');
                                setState(() {
                                  _selectedDistrict = district;
                                });
                              },
                              items: _districts.map<DropdownMenuItem<String>>(
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
                                      height: 2,
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
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Column(
                children: <Widget>[
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
                          isEmpty: _selectedBloodType == null,
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              menuMaxHeight: 500,
                              isExpanded: false,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              value: _selectedBloodType,
                              isDense: true,
                              onChanged: (bloodType) {
                                // print('New value: ${bloodType!}');
                                setState(() {
                                  _selectedBloodType = bloodType;
                                });
                              },
                              items: _bloodTypes.map<DropdownMenuItem<String>>(
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
                                      height: 2,
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
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 55,
                    width: 350,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        // padding: MaterialStateProperty.all<EdgeInsets>(
                        //   const EdgeInsets.all(12),
                        // ),
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
                      onPressed: () {
                        saveUser();
                        setState(() {
                          phone = phoneCotoroller.text.trim();
                        });
                      },
                      child: Text(
                        'Register'.toUpperCase(),
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
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            if (currentState == MobileVerificationState.PhoneNumberState) {
              return getMobileFormWidget(context);
            } else if (currentState == MobileVerificationState.OtpState) {
              return getOtpFormWidget(context);
            } else {
              return userInfo(context);
            }
          },
        ),
      ),

      // Scaffold(
      //   body: Container(
      //     padding: const EdgeInsets.all(10),
      //     child: Center(
      //       child: SingleChildScrollView(
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             showLoading == true
      //                 ? const CircularProgressIndicator(color: primary)
      //                 : const SizedBox(),
      //             if (currentState ==
      //                 MobileVerificationState.PhoneNumberState) ...[
      //               getMobileFormWidget(context)
      //             ] else if (currentState ==
      //                 MobileVerificationState.OtpState) ...[
      //               getOtpFormWidget(context)
      //             ] else ...[
      //               userInfo(context)
      //             ]
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
