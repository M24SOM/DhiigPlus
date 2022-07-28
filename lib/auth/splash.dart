import 'dart:async';
import 'package:flutter/material.dart';
import '../global/global.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  startTimer() {
    Timer(const Duration(seconds: 3), () async {
      if (fAuth.currentUser != null) {
        currentFirebaseUser = fAuth.currentUser;
        appRouter.pushNamedAndRemoveUntil('/home', args: 'From Login Screen');
      } else {
        appRouter.pushNamedAndRemoveUntil('/home', args: 'From Login Screen');
      }
    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: // LOGO
          Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
