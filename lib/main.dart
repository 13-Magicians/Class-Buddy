import 'package:classbuddy/screens/dashboard_admin.dart';
import 'package:classbuddy/screens/dashboard_lecturer.dart';
import 'package:classbuddy/screens/screen_login.dart';
import 'package:classbuddy/screens/screen_onboard.dart';
import 'package:classbuddy/screens/screen_splash.dart';
import 'package:classbuddy/screens/dashboard_student.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';

const version = ('1.0.4.6');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();

  runApp(
    const ClassBuddy()
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => const ClassBuddy(),
    // ),
  );
}

// class ClassBuddy extends StatefulWidget {
//   const ClassBuddy({super.key});
//
//   @override
//   State<ClassBuddy> createState() => _ClassBuddyState();
// }
//
// class _ClassBuddyState extends State<ClassBuddy> {
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
//       routes: <String, WidgetBuilder>{
//         '/splash': (context) => CBSplashScr(version),
//         '/home': (context) => CBHomeScr(),
//         '/duo': (context) => Duo(),
//         '/onboard': (context) => OnBoarding(),
//         '/login': (context) => CB_Login(),
//         '/dashLec': (context) => LecDash(),
//       },
//     );
//   }
// }

class ClassBuddy extends StatelessWidget {
  const ClassBuddy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Class Buddy',
      theme: ThemeData.light(),
      home: const CBSplashScr(version),
      // home: const StuDash(),
      routes: <String,WidgetBuilder>{
        '/splash': (context) => CBSplashScr(version),
        '/onboard':(context) => OnBoarding(),
        '/login':(context) => CBAppLogin(),
        '/dashLec':(context) => LecDash(),
        '/dashStu':(context) => StuDash(),
        '/dashAdmin':(context) => AdminDash(),
      },
    );
  }
}
