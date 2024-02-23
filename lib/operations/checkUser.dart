
import 'package:classbuddy/services/auth.dart';
import 'package:classbuddy/services/fireDatabase.dart';

class checkUser {
  Future userExist() async {
    if (DatabaseMethods().checkUser != null) {

    }

  }

  Future getUser() async {
     await authMethods().getCurrentUser();

  }

  setDefaultRole(String userId) {
    Map<String, dynamic> userRole = {
      "role": "Student",
    };

  }

  userRole(String userId) {
    if (DatabaseMethods().userRole(userId) == 'Student') {
      return '/dashStu';
    }
    else if(DatabaseMethods().userRole(userId) == 'Lecture'){
      return '/dashLec';
    }
    else if(DatabaseMethods().userRole(userId) == 'Admin'){
      return '/dashAdmin';
    }
    else {
      print('Something Error');
    }
    return null;
  }

}