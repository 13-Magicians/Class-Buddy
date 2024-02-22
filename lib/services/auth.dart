

import 'package:classbuddy/services/fireDatabase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';




class authMethods {
  final _auth = FirebaseAuth.instance;
  // getCurrentUser{} async {
  //   return await auth.currentUser;
  // }

  Future<User?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if(googleUser == null) return null;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken,);

      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;



    } catch (e) {
      print(e);
      return null;

    }
    // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    // final GoogleSignIn googleSignIn = GoogleSignIn();
    // final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    // final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;

    // final credential = GoogleAuthProvider.credential(
    //   idToken: googleAuth?.idToken,
    //   accessToken: googleAuth?.accessToken
    // );
    
    // UserCredential result = await firebaseAuth.signInWithCredential(credential);
    // User? userDetails = result.user;

    // if(result!=null){
    //   Map<String, dynamic> userInfoMap = {
    //     "email":userDetails!.email,
    //     "id":userDetails.uid,
    //     "name":userDetails.displayName,
    //     "imgUrl":userDetails.photoURL,
    //   };
    //   await DatabaseMethods().addUser(userDetails.uid, userInfoMap).then((value) {
    //     // Navigator.pushNamed(context, '/dashLec');
    //   });
    // }




  }



}

class _auth {
}