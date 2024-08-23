import 'package:e_commerce/Auth/keeplogin.dart';
import 'package:e_commerce/Auth/login.dart';
import 'package:e_commerce/Auth/signup.dart';
import 'package:e_commerce/days.dart';
import 'package:e_commerce/firebase_options.dart';
import 'package:e_commerce/payment/payment.dart';
import 'package:e_commerce/screens/BottomNavigation.dart';
import 'package:e_commerce/screens/calender.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

// void init() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: // DatePickerExample()
            //Login()
            //Signup()
           AuthWrapper()
         //CalendarWithNumbers()
        // PaymentScreen()

        //   const BottomNavigationBarExample()
        //  PageViewExample()

        );
  }
}
