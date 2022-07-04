import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/route_generator.dart';
import 'providers/auth_provider.dart';
import 'utils/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider.value(
    value: AuthProvider(),
    child: MaterialApp(
      navigatorKey: NavigationService.navigationKey,
      initialRoute: '/splash',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    ),
  ));
}
