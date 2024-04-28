import 'package:classbuddy/services/firebase_std_course_control.dart';
import 'package:get_storage/get_storage.dart';

class StudentOperations {


  Future getAllCourses(semNo) async {
    List<Map<String, dynamic>> courseList = [];
    final localUser = GetStorage();
    final userData = localUser.read('user');
    final acYear = userData['academicYear'];

    StudentCourseCtrl().getAllCourse(acYear,semNo);

    return courseList;
  }

  Future<List<Map<String, dynamic>>> getMyCourses() async {
    List<Map<String, dynamic>> courseList = [];
    return courseList;
  }

  Future enrollToCourse() async {

  }

  // Future getMyCourses(acYear) async {
  //   List<Map<String, dynamic>> courseList = [];
  //   final localUser = GetStorage();
  //   final userData = localUser.read('user');
  //
  //   return courseList;
  // }












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