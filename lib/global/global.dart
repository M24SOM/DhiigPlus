import 'package:dhiigplus/helpers/assistant.dart';
import 'package:dhiigplus/utils/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../models/user_model.dart';
import '../utils/navigation.dart';

DateTime selectedDate = DateTime.now();

// LOGGER
var logger = Logger(
  printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
      ),
);
// SING UP PAGE
String selectedCountryCode = '+252';

final List<String> bloodTypes = [
  'O-',
  'O+',
  'A-',
  'A+',
  'B-',
  'B+',
  'AB-',
  'AB+'
];
final List<String> districts = [
  'Hodan',
  'Howl-Wadaag',
  'Hiliwaa',
  'Xamar Weyne',
  'Xamar Jajab',
  'Shibis',
  'Shangaani',
  'Abdi-Casiis',
  'Warta Nabada',
  'Waabari',
  'Wadajir',
  'Yaaqshiid',
  'Dharkeynley',
  'Kaxda',
  'Boondheere',
  'Kaaraan',
  'Dayniile'
];

final List<String> hospital = [
  'Madiina',
  'Kalkaal',
  'Shaafi',
];

TextEditingController fullNameController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController countryCodeController = TextEditingController();
bool hidePassword = true;
String? selectedDistrict;
String? selectedhospital;
String? selectedBloodType;

// Verify
final verifyController = TextEditingController();

// Firebase User
final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentInfo;

// Utility
Alert alert = Alert();
final NavigationService appRouter = NavigationService();

// Helpers
Assistant assistant = Assistant();
