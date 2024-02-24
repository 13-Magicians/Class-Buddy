
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

  userRole(String userId) async {
    final retrieveUserRole = await DatabaseMethods().userRole(userId);
    print(retrieveUserRole);
    print('zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
    if (retrieveUserRole == "Student") {
      print('aaaaaaaaaaaaaaaaaaaaaaaa');
      return '/dashStu';
    }
    else if(retrieveUserRole == "Lecture"){
      print('bbbbbbbbbbbbbbbbbbbbbbbbbb');
      return '/dashLec';
    }
    else if(retrieveUserRole == "Admin"){
      print('ccccccccccccccccccccccccc');
      return '/dashAdmin';
    }
    else {
      print('Something Error');
    }
    return null;
  }

}