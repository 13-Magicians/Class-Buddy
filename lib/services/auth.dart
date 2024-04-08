
import 'package:classbuddy/operations/checkUser.dart';
import 'package:classbuddy/services/fireDatabase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class authMethods {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();



  //
  // Future<String?> getCurrentUser() async {
  //   Completer<String?> completer = Completer();
  //
  //   _auth.authStateChanges().listen((User? user) {
  //     if (user != null) {
  //       completer.complete(user.uid);
  //     } else {
  //       completer.complete(null);
  //     }
  //   });
  //
  //   return completer.future;
  // }

  getCurrentUser() async {
    var userId;
    await _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        userId = user.uid;
        print(userId);
      } else {
        userId = null;
      }
    });
    return userId;
  }

  getAccessToken() async {
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
    return result.credential?.accessToken;

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
    final loggedUser = GetStorage();

    UserCredential result = await firebaseAuth.signInWithCredential(credential);
    User? userDetails = result.user;

    // Create email validation

    //------------------------





    if (userDetails != null) {

      Map<String, dynamic> userBData = {
        "email": userDetails.email,
        "id": userDetails.uid,
        "name": userDetails.displayName,
        "imgUrl": userDetails.photoURL,
        "accessToken":credential.accessToken,
      };

      loggedUser.write('user', userBData);



      // final userIdValue = await DatabaseMethods().checkUser(userDetails.uid);
      final userIdValue = await checkUser().userExist(userDetails.uid);

      if (userIdValue == userDetails.uid) {
        Map<String, dynamic> userLastLog = {
          "lastLog": DateTime.now().millisecondsSinceEpoch,
        };
        await DatabaseMethods()
            .updateUser(userDetails.uid, userLastLog)
            .then((value) async {
              final scrPath = await checkUser().userRole(userDetails.uid);
              if (!context.mounted) return;
              Navigator.pushReplacementNamed(context, '$scrPath');
            });
      }
      else {
        Map<String, dynamic> userInfoMap = {
          "email": userDetails.email,
          "id": userDetails.uid,
          "name": userDetails.displayName,
          "imgUrl": userDetails.photoURL,
          "role":"Student",
          "lastLog": DateTime.now().microsecondsSinceEpoch,

        };
        await DatabaseMethods()
            .addUser(userDetails.uid, userInfoMap)
            .then((value) {
          Navigator.pushReplacementNamed(context, '/dashStu');
        });
      }

    }




  }

  userSignOut(BuildContext context) async {
    GetStorage().erase();
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();
    Navigator.pushReplacementNamed(context, '/login');
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
