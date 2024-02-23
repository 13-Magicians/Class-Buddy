import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future addUser(String userId, Map<String, dynamic> userInfoMap){
    return db.collection("Users").doc(userId).set(userInfoMap);
  }

  Future updateUser(String userId, Map<String, dynamic> userLastLog) {
    return db.collection("Users").doc(userId).update(userLastLog);
  }


  Future checkUser(String userId) async {
    DocumentSnapshot docSnap = await db.collection("Users").doc(userId).get();
    return docSnap.get('id');
  }

  Future userRole(String userId) async {
    DocumentSnapshot docSnap = await db.collection("Users").doc(userId).get();
    return docSnap.get('role');
  }

}
