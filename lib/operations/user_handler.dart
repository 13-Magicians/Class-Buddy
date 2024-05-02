
import 'package:classbuddy/operations/error_handler.dart';
import 'package:classbuddy/services/firebase_authentication_control.dart';
import 'package:classbuddy/services/firebase_user_control.dart';
import 'package:get_storage/get_storage.dart';

class CheckUser {

  Future userExist(userId) async {
    final userExist = await DatabaseMethods().checkUser(userId);
    if (userExist != null) {
    }else {
    }
    return userExist;

  }

  Future getCurrentUserData() async {
    final userId = await AuthMethods().getCurrentUser();
    return await DatabaseMethods().getCurrentUserData(userId!);
  }

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
      if (userData['role'] == "Lecturer") {
        lecturesList.add(userData);
      }
    }
    return lecturesList;
  }

  Future changeRole(userId, gRole) {
    Map<String, dynamic> userRole = {
      'role': "$gRole",
    };

    return DatabaseMethods().updateUserRole(userId, userRole);
  }

  Future userListByRoles(uRole) async {
    return await DatabaseMethods().getRoleBasedUser(uRole);
  }

  Future userACYUpdate(String acYear) async {
    final localUser = GetStorage();
    final userData = localUser.read('user');
    Map<String, dynamic> userACY = {
      'academicYear': acYear,
    };

    Map<String, dynamic> reUserData = {
      'email': userData['email'],
      'id': userData['id'],
      'imgUrl': userData['imgUrl'],
      'lastLogin': userData['lastLog'],
      'name': userData['name'],
      'role': userData['role'],
      'academicYear': acYear,
    };
    localUser.write('user', reUserData);
    DatabaseMethods().updateUserACY(userData['id'], userACY);

  }

  Future getUserACY() async {
    final localUser = GetStorage();
    final userData = localUser.read('user');
    final userID = userData['id'];
    Map<String, dynamic> acyUserDataX = {};
    List<Map<String, dynamic>> acyUserData = [];
    acyUserDataX = await DatabaseMethods().getACYUser(userID);
    return acyUserDataX;
  }

}