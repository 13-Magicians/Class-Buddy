import 'package:classbuddy/operations/error_handler.dart';
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
    String dSnapId;
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
    } else {
      AppLogger.log('Document does not exist on the database');
    }
    return userData;

  }

  List<Map<String, dynamic>> userList = [];
  
  Future getAllUsers() async {
    QuerySnapshot querySnapshot = await db.collection('Users').get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> userData = {
        'email': doc['email'],
        'id': doc['id'],
        'imgUrl': doc['imgUrl'],
        'lastLogin': doc['lastLog'],
        'name': doc['name'],
        'role': doc['role'],
        'academicYear': doc['academicYear'],
      };
      userList.add(userData);
    }

    return userList;
  }

  Future getAdminsOnly() async {
    List<Map<String, dynamic>> adminUsers = [];

    QuerySnapshot querySnapshot = await db.collection('Users').where('role', isEqualTo: 'Admin').get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> userData = {
        'name': doc['name'],
        'email': doc['email'],
        'id': doc['id'],
        'imgUrl': doc['imgUrl'],
        'lastLogin': doc['lastLog'],
        'role': doc['role'],
      };
      adminUsers.add(userData);
    }

    return adminUsers;
  }

    Future getStudentsOnly() async {
      List<Map<String, dynamic>> studentUsers = [];

      QuerySnapshot querySnapshot = await db.collection('Users').where('role', isEqualTo: 'Student').get();
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> userData = {
          'name': doc['name'],
          'email': doc['email'],
          'id': doc['id'],
          'imgUrl': doc['imgUrl'],
          'lastLogin': doc['lastLog'],
          'role': doc['role'],
        };
        studentUsers.add(userData);
      }
      return studentUsers;


  }

  Future updateUserRole(userId, gRole) async {
    return db.collection("Users").doc(userId).update(gRole);
  }

  Future getRoleBasedUser(String uRole) async {
    List<Map<String, dynamic>> retUsers = [];
    QuerySnapshot querySnapshot = await db.collection('Users').where('role', isEqualTo: uRole).get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> userData = {
        'name': doc['name'],
        'email': doc['email'],
        'id': doc['id'],
        'imgUrl': doc['imgUrl'],
        'lastLogin': doc['lastLog'],
        'role': doc['role'],
      };
      retUsers.add(userData);
    }
    return retUsers;

  }

  Future updateUserACY(String userId ,Map<String, dynamic> userACY) async {
    db.collection("Users").doc(userId).update(userACY);
  }

  Future getACYUser(userID) async {
    Map<String, dynamic> nUserData = {};
    DocumentSnapshot doc = await db.collection("Users").doc(userID).get();
    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      nUserData = data;
    } else {
      AppLogger.log('Document does not exist on the database');
    }
    return nUserData;
  }



}
