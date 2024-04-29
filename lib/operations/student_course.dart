import 'package:classbuddy/services/firebase_std_course_control.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

class StudentOperations {


  Future<List<Map<String, dynamic>>> getAllCourses(String semNo) async {
    List<Map<String, dynamic>> courseList = [];
    final localUser = GetStorage();
    final userData = localUser.read('user');
    final acYear = userData['academicYear'];

    courseList = await StudentCourseCtrl().getAllCourse(acYear,semNo);


    return courseList;
  }

  Future<List<Map<String, dynamic>>> getMyEnrolledCourse(acYear, String semNo) async {
    List<Map<String, dynamic>> myCourseList = [];
    List<Map<String, dynamic>> courseList = [];
    final localUser = GetStorage();
    final userData = localUser.read('user');
    await StudentCourseCtrl().getMyEnrolled(acYear, semNo, userData['id']);
    // for (var element in courseList) {
    //   if (userData['id'] == element['creator']) {
    //     myCourseList.add(element);
    //   }
    // }
    return myCourseList;
  }

  Future enrollToCourse(String semNo, String courseCode, String passCode) async {
    final localUser = GetStorage();
    final userData = localUser.read('user');
    final acYear = userData['academicYear'];
    final userId = userData['id'];

    Map<String, dynamic> userInfo = {
      'id':userData['id'],
      'email':userData['email'],
      'name':userData['name'],
      'imgUrl':userData['imgUrl']
    };

    StudentCourseCtrl().enrollToCourse(acYear, semNo, courseCode, userId, passCode, userInfo);

  }

  Future<List<Map<String, dynamic>>> getEnrolledCourses(String semNo) async {

    List<Map<String, dynamic>> courseList = [];
    List<Map<String, dynamic>> myCourseList = [];

    final localUser = GetStorage();
    final userData = localUser.read('user');
    final acYear = userData['academicYear'];
    final userId = userData['id'];
    List<Map<String, dynamic>> cdata = await StudentCourseCtrl().getMyEnrolled(acYear, semNo, userId);
    print(cdata);

    return cdata;

  }




}


// class AcademicOperation {
//   FirebaseFirestore db = FirebaseFirestore.instance;
//
//   Future getAcYears() async {
//     QuerySnapshot querySnapshot = await db.collection('AcademicYear').get();
//     List<String> documentIds = [];
//
//     querySnapshot.docs.forEach((doc) {
//       documentIds.add(doc.id);
//     });
//     print("=====================================");
//
//     print(documentIds);
//
//   }
//
// }