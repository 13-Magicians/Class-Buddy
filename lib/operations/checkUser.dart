
import 'package:classbuddy/services/auth.dart';
import 'package:classbuddy/services/fireDatabase.dart';

class checkUser {

  //-------------------------------------
  //
  Future userExist(userId) async {
    final userExist = await DatabaseMethods().checkUser(userId);
    if (userExist != null) {
      print(userExist);

    }else {
      print("-------------error-----------");
    }
    return userExist;

  }

  Future getUser() async {
     await authMethods().getCurrentUser();

  }

  setDefaultRole(String userId) {
    Map<String, dynamic> userRole = {
      "role": "Student",
    };

  }

  userRole(String userId) async {
    final retrieveUserRole = await DatabaseMethods().userRole(userId);
    if (retrieveUserRole == "Student") {
      return '/dashStu';
    }
    else if(retrieveUserRole == "Lecture"){
      return '/dashLec';
    }
    else if(retrieveUserRole == "Admin"){
      return '/dashAdmin';
    }
    else {
      print('Something Error in userRole function');
    }
    return null;
  }



  Future retLecUserList() async {
    List<Map<String, dynamic>> lecturesList = [];
    List<Map<String, dynamic>> userList = await DatabaseMethods().getAllUsers();
    userList.forEach((userData) {
      if (userData['role'] == "Lecture") {
        lecturesList.add(userData);
      }
      print(userData);
    });
    print('-==============================================-');
    // if (userList[0].keys) {}
    print(lecturesList);
    return lecturesList;
  }


}