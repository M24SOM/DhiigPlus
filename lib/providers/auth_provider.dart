import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../global/global.dart';

class AuthProvider with ChangeNotifier {
  String? verificationId;

  Future<void> verifyPhone(String countryCode, String mobile) async {
    var mobileToSend = mobile;

    try {
      await fAuth.verifyPhoneNumber(
        phoneNumber: mobileToSend,
        codeSent: (String verificationId, int? resendToken) async {
          // Update the UI - wait for the user to enter the SMS code
          String smsCode = 'xxxx';

          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          await fAuth.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (String verId) {
          //Starts the phone number verification process for the given phone number.
          //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
          verificationId = verId;
        },
        verificationCompleted: (AuthCredential phoneAuthCredential) {
          logger.i(phoneAuthCredential);
        },
        verificationFailed: (e) {
          logger.w(e);
        },
        timeout: const Duration(
          seconds: 120,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> verifyOTP(String otp) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otp,
      );
      final UserCredential user = await fAuth.signInWithCredential(credential);
      final User currentUser = await fAuth.currentUser!;
      logger.i(user);

      if (currentUser.uid != "") {
        logger.i(currentUser.uid);
      }
    } catch (e) {
      rethrow;
    }
  }

  showError(error) {
    throw error.toString();
  }
}
