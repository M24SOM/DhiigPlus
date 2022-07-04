import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../global/global.dart';
import '../widgets/rounded_button.dart';
import '../widgets/user_text_field.dart';

class Verify extends StatelessWidget {
  static const routeArgs = '/verify-screen';

  const Verify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'PickUp',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    )),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Please enter code sent to your number',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                UserTextField(
                  titleLabel: 'Enter 6 digit Code',
                  maxLength: 6,
                  icon: Icons.dialpad,
                  controller: verifyController,
                  inputType: TextInputType.phone,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: RoundedButton(
                      title: 'Verify Code',
                      onPressed: () {
                        assistant.verifyOTP(context);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
