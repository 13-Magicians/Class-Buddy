
import 'package:classbuddy/operations/error_handler.dart';
import 'package:classbuddy/services/authentication.dart';
import 'package:classbuddy/services/firebase_database.dart';

class CheckUser {

  //-------------------------------------
  //
  Future userExist(userId) async {
    final userExist = await DatabaseMethods().checkUser(userId);
    if (userExist != null) {
    }else {
    }
    return userExist;

  }

  Future getUser() async {
     await AuthMethods().getCurrentUser();

  }

  // setDefaultRole(String userId) {
  //   Map<String, dynamic> userRole = {
  //     "role": "Student",
  //   };
  //
  // }

  userRole(String userId) async {
    final retrieveUserRole = await DatabaseMethods().userRole(userId);
    if (retrieveUserRole == "Student") {
      return '/dashStu';
    }
    else if(retrieveUserRole == "Lecturer"){
      return '/dashLec';
    }
    else if(retrieveUserRole == "Admin"){
      return '/dashAdmin';
    }
    else {
      AppLogger.log('Something Error in userRole function');
    }
    return null;
  }



  Future retLecUserList() async {
    List<Map<String, dynamic>> lecturesList = [];
    List<Map<String, dynamic>> userList = await DatabaseMethods().getAllUsers();
    for (var userData in userList) {
      if (userData['role'] == "Lecture") {
        lecturesList.add(userData);
      }
    }
    return lecturesList;
  }

  // Future retAdminUserList() async {
  //   List<Map<String, dynamic>> AdminsList = [];
  //
  // }

  Future changeRole(userId, gRole) {
    Map<String, dynamic> userRole = {
      'role': "$gRole",
    };

    return DatabaseMethods().updateUserRole(userId, userRole);
  }


}