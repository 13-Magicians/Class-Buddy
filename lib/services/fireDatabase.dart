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

  List<Map<String, dynamic>> userList = [];
  
  Future getAllUsers() async {
    QuerySnapshot querySnapshot = await db.collection('Users').get();
    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> userData = {
        'email': doc['email'],
        'id': doc['id'],
        'imgUrl': doc['imgUrl'],
        'lastLogin': doc['lastLog'],
        'name': doc['name'],
        'role': doc['role'],
      };
      userList.add(userData);
      print('111111111111111--------done-------111111111111');
    });

    // if (doc.exists) {
    //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    //   data.forEach((key, value) {
    //     print(key);
    //     print(value);
    //     userList.add({key:value});
    //   });
    //   print(data);
    //
    //   print('---------------done-------------');
    //   print(userList);
    // } else {
    //   print("Document does not exist on the database");
    // }
    return userList;
  }

  Future getAdminsOnly() async {
    List<Map<String, dynamic>> adminUsers = [];

    QuerySnapshot querySnapshot = await db.collection('Users').where(
        'role', isEqualTo: 'Admin').get();
    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> userData = {
        'name': doc['name'],
        'email': doc['email'],
        'id': doc['id'],
        'imgUrl': doc['imgUrl'],
        'lastLogin': doc['lastLog'],
        'role': doc['role'],
      };
      adminUsers.add(userData);
    });

    return adminUsers;
  }

    Future getStudentsOnly() async {
      List<Map<String, dynamic>> studentUsers = [];

      QuerySnapshot querySnapshot = await db.collection('Users').where('role', isEqualTo: 'Student').get();
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> userData = {
          'name': doc['name'],
          'email': doc['email'],
          'id': doc['id'],
          'imgUrl': doc['imgUrl'],
          'lastLogin': doc['lastLog'],
          'role': doc['role'],
        };
        studentUsers.add(userData);
      });

      return studentUsers;


  }

  Future updateUserRole(userId, gRole) async {
    return db.collection("Users").doc(userId).update(gRole);
  }


  

}
