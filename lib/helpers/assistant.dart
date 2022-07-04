import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../global/global.dart';
import '../providers/auth_provider.dart';

class Assistant {
  verifyPhone(BuildContext context) {
    try {
      Provider.of<AuthProvider>(context, listen: false)
          .verifyPhone(selectedCountryCode,
              selectedCountryCode + phoneNumberController.text.toString())
          .then((value) {
        appRouter.pushNamedAndRemoveUntil('/verify',
            args: 'From SingUp Screen');
      }).catchError((e) {
        String errorMsg = 'Cant Authenticate you, Try Again Later';
        if (e.toString().contains(
            'We have blocked all requests from this device due to unusual activity. Try again later.')) {
          errorMsg = 'Please wait as you have used limited number request';
        }
        alert.showErrorDialog(context, errorMsg);
      });
    } catch (e) {
      alert.showErrorDialog(context, e.toString());
    }
  }

  void onCountryChange(CountryCode countryCode) {
    selectedCountryCode = countryCode.toString();
    logger.i("New Country selected: $countryCode");
  }

  verifyOTP(BuildContext context) {
    try {
      Provider.of<AuthProvider>(context, listen: false)
          .verifyOTP(verifyController.text.toString())
          .then((_) {
        appRouter.pushNamedAndRemoveUntil('/hone', args: 'From SingUp Screen');
        logger.i('verified');
      }).catchError((e) {
        String errorMsg = 'Cant authenticate you Right now, Try again later!';
        if (e.toString().contains("ERROR_SESSION_EXPIRED")) {
          errorMsg = "Session expired, please resend OTP!";
        } else if (e.toString().contains("ERROR_INVALID_VERIFICATION_CODE")) {
          errorMsg = "You have entered wrong OTP!";
        }
        alert.showErrorDialog(context, errorMsg);
      });
    } catch (e) {
      alert.showErrorDialog(context, e.toString());
    }
  }
}
