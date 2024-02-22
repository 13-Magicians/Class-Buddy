
import 'package:classbuddy/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:intl/intl.dart';


class CB_Login extends StatefulWidget {
  const CB_Login({super.key});

  @override
  State<CB_Login> createState() => _CB_LoginState();
}

// GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
//   'email',
//   'https://www.googleapis.com/auth/contacts.readonly'
// ]);

// String regGoogleAuth() {
//   const awe = "";
//   return awe;
// }

class _CB_LoginState extends State<CB_Login> {
  // late GoogleSignInAccount _currentUser;
  // late String u_id = "";
  // late String u_name = "";
  // late String u_email = "";
  // late String u_photoUrl = "";
  // late String u_lastDate = "";
  // late String u_lastTime = "";

  // @override
  // void initState() {
  //   super.initState();
  //   Firebase.initializeApp().whenComplete(() {
  //     print("completed");
  //     setState(() {});
  //   });
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
    // _googleSignIn.onCurrentUserChanged.listen((account) {
    //   setState(() {
    //     _currentUser = account!;
    //
    //     u_id = _currentUser.id;
    //     u_name = _currentUser.displayName!;
    //     u_email = _currentUser.email;
    //     u_photoUrl = _currentUser.photoUrl!;
    //     u_lastDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    //     u_lastTime = DateFormat("hh:mm:ss a").format(DateTime.now());
    //     // MongoDatabase.userFind(u_id);
    //
    //     // MongoDatabase.user_write(
    //     //     u_id, u_name, u_photoUrl, u_email, u_lastDate, u_lastTime);
    //   });
    //   if (_currentUser != null) {
    //     print("Already signin");
    //     Navigator.pushNamed(context, '/dashLec');
    //     // Navigator.pushNamed(context, '/lecdash');
    //   }
    // });
    // _googleSignIn.signInSilently();
  // }

  // Future<void> handleSignIn() async {
  //   try {
  //     await _googleSignIn.signIn();
  //   } catch (error) {
  //     print("error:" + error.toString());
  //   }
  // }
  //
  // Future<void> handleSignOut() => _googleSignIn.disconnect();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin:
                                const EdgeInsets.only(top: 10.0, left: 40.0),
                            child: const Text(
                              'Class',
                              style: TextStyle(
                                  fontSize: 50.0,
                                  fontFamily: 'K2D',
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4F0000)),
                            )),
                        Container(
                            margin: const EdgeInsets.only(top: 1.0, left: 40.0),
                            child: const Text(
                              'Buddy',
                              style: TextStyle(
                                  fontSize: 50.0,
                                  fontFamily: 'K2D',
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4F0000)),
                            )),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 70.0),
                      child: Image.asset('assets/images/CB_Ico.png',
                          width: 80.0, height: 80.0),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25.0),
                child: Text(
                  'Learn it easily',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8),
                ),
              )
            ],
          )),
          Container(
            width: 280.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    'Welcome !',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Color(0xFFEC6565),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 14.0),
                  child: Text(
                    'Find what you are looking for',
                    style: TextStyle(
                        fontSize: 48.0,
                        color: Color(0xFF823232),
                        fontWeight: FontWeight.w100),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12.0),
                  child: Text(
                    'By personalize your account, we can help you to find what you like.',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFF9E7878),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8),
                  ),
                ),
                Container(
                    width: 280.0,
                    height: 45.0,
                    margin: EdgeInsets.only(top: 40.0),
                    child: ElevatedButton(
                        onPressed: () {
                          authMethods().signInWithGoogle();
                        },
                        child: Text('Sign in with Google',
                            style: TextStyle(
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            backgroundColor: Color(0xFFD13838)))
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
