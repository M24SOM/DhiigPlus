import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../global/global.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final otpCotoroller = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  late String verificationId;
  void signInWithPhoneAuthCredential(phoneAuthCredential) async {
    try {
      final authCredential =
          await auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        appRouter.pushNamed('/home', args: 'From SignUp Screen');
      }
    } on FirebaseAuth catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          UserCredential result = await _auth.signInWithCredential(credential);

          User? user = result.user;

          if (user != null) {
            appRouter.pushNamed('/home', args: 'From SignUp Screen');
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        // verificationFailed: (AuthException exception) {
        //   print(exception);
        // },
        codeSent: (verificationId, resendingToken) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Give the code?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: otpCotoroller,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        final code = otpCotoroller.text.trim();

                        final phoneAuthCredential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId, smsCode: code);
                        signInWithPhoneAuthCredential(phoneAuthCredential);
                      },
                      child: const Text("Confirm"),
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        verificationFailed: (FirebaseAuthException error) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      controller: phoneNumberController,
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

                    // // PASSWORD
                    // TextFormField(
                    //   obscureText: hidePassword,
                    //   autofillHints: const [AutofillHints.password],
                    //   style: const TextStyle(
                    //     color: Colors.black87,
                    //     fontFamily: 'Montserrat',
                    //     fontWeight: FontWeight.w500,
                    //     fontSize: 18,
                    //     height: 2,
                    //   ),
                    //   decoration: InputDecoration(
                    //     labelText: 'Password'.toUpperCase(),
                    //     labelStyle: const TextStyle(
                    //       color: Colors.grey,
                    //     ),
                    //     enabledBorder: const UnderlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.grey),
                    //     ),
                    //     focusedBorder: const UnderlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.red),
                    //     ),
                    //     prefixIcon: const Icon(
                    //       Icons.lock_open_outlined,
                    //       color: Colors.black87,
                    //       // size: 20,
                    //     ),
                    //     suffixIcon: IconButton(
                    //       icon: hidePassword
                    //           ? const Icon(
                    //               Icons.visibility_off,
                    //               color: Colors.black54,
                    //             )
                    //           : const Icon(
                    //               Icons.visibility,
                    //               color: Colors.black87,
                    //             ),
                    //       onPressed: () {
                    //         setState(() {
                    //           hidePassword = !hidePassword;
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // ),
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
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              side: const BorderSide(
                                  color: Colors.red, width: 1.6),
                            ),
                          ),
                        ),
                        onPressed: () {
                          final phone = '+252${phoneController.text.trim()}';

                          loginUser(phone, context);
                        },
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
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  appRouter.pushNamedAndRemoveUntil('/signUp',
                      args: 'From Login Screen');
                },
                child: const Text(
                  "Don't Have an Account, Register Now ...",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    letterSpacing: 0.5,
                  ),
                ),
              )
              // Container(
              //   margin:
              //       const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              //   child: Column(
              //     children: <Widget>[
              //       SizedBox(
              //         height: 55,
              //         width: 350,
              //         child: ElevatedButton(
              //           style: ButtonStyle(
              //             backgroundColor:
              //                 MaterialStateProperty.all<Color>(Colors.red),
              //             shape:
              //                 MaterialStateProperty.all<RoundedRectangleBorder>(
              //               RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(50.0),
              //                 side: const BorderSide(color: Colors.red),
              //               ),
              //             ),
              //           ),
              //           onPressed: () {},
              //           child: Text(
              //             'Register'.toUpperCase(),
              // style: const TextStyle(
              //   color: Colors.white,
              //   fontFamily: 'Montserrat',
              //   fontWeight: FontWeight.w700,
              //   fontSize: 20,
              //   letterSpacing: 1.8,
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
      ),
    );
  }
}
