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
    var dSnapId;
    if (docSnap.exists) {
      dSnapId = docSnap.get('id');
    } else {
      dSnapId = 'noExtUser';
    }
    return dSnapId;
  }

  Future userRole(String userId) async {
    DocumentSnapshot docSnap = await db.collection("Users").doc(userId).get();
    return docSnap.get('role');
  }

  List<Map<String, dynamic>> userData = [];

  Future getCurrentUserData(String userID) async {
    DocumentSnapshot doc = await db.collection("Users").doc(userID).get();
    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      userData.add(data);
      print('---------------done-------------');
      print(userData);
    } else {
      print("Document does not exist on the database");
    }
    return userData;

  }

}
