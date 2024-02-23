import 'package:classbuddy/operations/checkUser.dart';
import 'package:classbuddy/services/fireDatabase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class authMethods {
  final _auth = FirebaseAuth.instance;

  getCurrentUser() async {
    var userId;
    print("-----------------------------------------------Test");
    await _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        userId = user.uid;
      } else {
        userId = null;
      }
    });
    return userId;
  }

  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken);

    UserCredential result = await firebaseAuth.signInWithCredential(credential);
    User? userDetails = result.user;

    // Create email validation

    //------------------------
    print('---------------------------------------------------');
    print('qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq');

    if (userDetails != null) {
      final userIdValue = await DatabaseMethods().checkUser(userDetails.uid);

      if (userIdValue == userDetails.uid) {
        Map<String, dynamic> userLastLog = {
          "lastLog": new DateTime.now().microsecondsSinceEpoch,
        };
        await DatabaseMethods()
            .updateUser(userDetails.uid, userLastLog)
            .then((value) {
              final scrPath = checkUser().userRole(userDetails.uid);

              print('0000000000000000000000000000000000000000000000');
              print(scrPath);
              print('0000000000000000000000000000000000000000000000');
              Navigator.pushNamed(context, '/dashStu');
            });
      }
      else {
        Map<String, dynamic> userInfoMap = {
          "email": userDetails!.email,
          "id": userDetails.uid,
          "name": userDetails.displayName,
          "imgUrl": userDetails.photoURL,
          "role":"Student",
          "lastLog": new DateTime.now().microsecondsSinceEpoch,

        };
        await DatabaseMethods()
            .addUser(userDetails.uid, userInfoMap)
            .then((value) {
          Navigator.pushNamed(context, '/dashStu');
        });
      }

    }

      if (result != null) {
        print('111111111111111111111111111111111111');

      }
      // else {
      //   print('============================');
      //   if (checkUser().userRole(userDetails!.uid) == 1) {
      //     Navigator.pushNamed(context, '/dashStu');
      //   }
      //   else if (checkUser().userRole(userDetails!.uid) == 2) {
      //     Navigator.pushNamed(context, '/dashLec');
      //   }
      //   else if (checkUser().userRole(userDetails!.uid) == 3) {
      //     Navigator.pushNamed(context, '/dashAdmin');
      //   }





  }

  userSignOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, '/login');
  }

  userChanges() {
    _auth.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }
}
