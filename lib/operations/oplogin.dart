//
//
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:intl/intl.dart';
//
// // import 'mongodb.dart';
//
// class usr_Data {
//   late String usr_id;
//   late String usr_name;
//   late String usr_email;
//   late String usr_photoUrl;
//   late String usr_lastDate;
//   late String usr_lastTime;
//
// // usr_Data({required this.usr_id, required this.usr_name, required this.usr_email, required this.usr_photoUrl, required this.usr_lastDate, required this.usr_lastTime});
//
// }
//
// late GoogleSignInAccount _currentUser;
// String u_id = "";
// String u_name = "";
// String u_email = "";
// String u_photoUrl = "";
// String u_lastDate = "";
// String u_lastTime = "";
// int user_state = 0;
// var udata = "";
//
// GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
//   'email',
//   'https://www.googleapis.com/auth/contacts.readonly'
// ]);
//
// loginCheck () {
//   _googleSignIn.onCurrentUserChanged.listen((account) {
//     setState(() {
//       _currentUser = account!;
//     });
//     if (_currentUser != null) {
//       u_id = _currentUser.id;
//       u_name = _currentUser.displayName!;
//       u_email = _currentUser.email;
//       u_photoUrl = _currentUser.photoUrl!;
//       u_lastDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
//       u_lastTime = DateFormat("hh:mm:ss a").format(DateTime.now());
//       // usr_Data.usr_id = "";
//       // MongoDatabase.userF_Last(u_lastDate, u_lastTime);
//       print("Already signin");
//       user_state = 1;
//       // Navigator.pushNamed(context, '/lecdash');
//       // Navigator.pushNamed(context, '/lecdash');
//     }
//   });
// }
//
// void setState(Null Function() param0) {
// }