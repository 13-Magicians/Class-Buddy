// import 'dart:developer';
// import 'package:classbuddy/operations/constant.dart';
// import 'package:mongo_dart/mongo_dart.dart';
//
// class MongoDatabase {
//   static connect() async {
//     var db = await Db.create(App_Settings_mongo_url);
//     await db.open();
//     inspect(db);
//     var status = db.serverStatus();
//     print(status);
//     var app_settings = db.collection(App_Settings);
//     await app_settings.update(
//         where.eq("setting_1", 1), modify.set("setting_2", 3));
//   }
//
//   static user_write(u_id, u_name, u_photoUrl, u_email, u_lastDate, u_lastTime) async {
//     var db = await Db.create(App_Settings_mongo_url);
//     await db.open();
//     inspect(db);
//     var status = db.serverStatus();
//     print(status);
//     var app_users = db.collection(App_Users);
//
//     await app_users.insertOne({
//       "user_id": "$u_id",
//       "user_name": "$u_name",
//       "user_photoUrl": "$u_photoUrl",
//       "user_email": "$u_email",
//       "user_lastDate": "$u_lastDate",
//       "user_lastTime": "$u_lastTime"
//     });
//   }
//
//   static userFind(u_id) async {
//     var db = await Db.create(App_Settings_mongo_url);
//     await db.open();
//     inspect(db);
//     var status = db.serverStatus();
//     print(status);
//     var app_users = db.collection(App_Users);
//
//     final dataFind = await app_users.findOne({"user_id": u_id});
//     if (null != dataFind) {
//       print("Search result ++$dataFind++");
//     }
//     else {
//       print("result ++none++");
//     }
//
//   }
//
//   static userF_Last(u_LT, u_LD) async {
//     var db = await Db.create(App_Settings_mongo_url);
//     await db.open();
//     inspect(db);
//     var status = db.serverStatus();
//     print(status);
//     var app_users = db.collection(App_Users);
//
//
//   }
//
// }
