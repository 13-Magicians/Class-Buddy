import 'package:classbuddy/screens/duo.dart';
import 'package:classbuddy/screens/home_page.dart';
import 'package:classbuddy/screens/lec_dash.dart';
import 'package:classbuddy/screens/login.dart';
import 'package:classbuddy/screens/on_boarding.dart';
import 'package:classbuddy/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart   ';

// import 'dart:async';
import 'package:device_preview/device_preview.dart';

import 'operations/mongodb.dart';

const version = ('1.0.0.2');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Firebase.initializeApp();


  // await MongoDatabase.connect();
  runApp(
    // ClassBuddy(),
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const ClassBuddy(),
    ),
  );
}

class ClassBuddy extends StatefulWidget {
  const ClassBuddy({super.key});

  @override
  State<ClassBuddy> createState() => _ClassBuddyState();
}

class _ClassBuddyState extends State<ClassBuddy> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Class Buddy',
      theme: ThemeData.light(),
      // home: const CBSplashScr(version),
      home: const CB_Login(),
      routes: <String, WidgetBuilder>{
        '/splash': (context) => CBSplashScr(version),
        '/home': (context) => CBHomeScr(),
        '/duo': (context) => Duo(),
        '/onboard': (context) => OnBoarding(),
        '/login': (context) => CB_Login(),
        '/dashLec': (context) => LecDash(),
      },
    );
  }
}

// class ClassBuddy extends StatelessWidget {
//   const ClassBuddy({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       locale: DevicePreview.locale(context),
//       builder: DevicePreview.appBuilder,
//       title: 'Class Buddy',
//       theme: ThemeData.light(),
//       // home: const CBSplashScr(version),
//       home: const CB_Login(),
//       routes: <String,WidgetBuilder>{
//         '/splash': (context) => CBSplashScr(version),
//         '/home': (context) => CBHomeScr(),
//         '/duo': (context) => Duo(),
//         '/onboard':(context) => OnBoarding(),
//         '/login':(context) => CB_Login(),
//         '/dashLec':(context) => LecDash(),
//       },
//     );
//   }
// }
