import 'package:classbuddy/services/firebase_std_course_control.dart';
import 'package:get_storage/get_storage.dart';

class StudentOperations {


  Future<List<Map<String, dynamic>>> getAllCourses(String semNo) async {
    List<Map<String, dynamic>> courseList = [];
    final localUser = GetStorage();
    final userData = localUser.read('user');
    final acYear = userData['academicYear'];
    print(acYear);

    courseList = await StudentCourseCtrl().getAllCourse(acYear,semNo);

    print('111111111111111111');
    print(courseList);
    print('222222222222222222');

    return courseList;
  }

  Future<List<Map<String, dynamic>>> getMyCourses() async {
    List<Map<String, dynamic>> courseList = [];
    return courseList;
  }

  Future enrollToCourse() async {

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