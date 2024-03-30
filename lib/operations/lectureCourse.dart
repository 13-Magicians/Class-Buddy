import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

import '../services/fireCourseData.dart';

class AcademicOperation {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future getAcYears() async {
    QuerySnapshot querySnapshot = await db.collection('AcademicYear').get();
    List<Map<String, dynamic>> documentIds = [];

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> acY = {
        'documentID': doc.id,
        'currentYear': doc['currentYear'],
      };

      documentIds.add(acY);
    });

    return documentIds;
  }


  Future<void> addCourseACY(String documentID, String subjectName, String courseCode, String selectedDepartment) async {
    final localUser = GetStorage();
    final userData = localUser.read('user');
    print(userData['id']);

    Map<String, dynamic> courseOriginData = {
      'courseCode':courseCode,
      'subjectName':subjectName,
      'department':selectedDepartment,
      'creator':userData['id'],
    };

    DbCourseMethods().createCourse(documentID, courseCode, courseOriginData);


    // Implement your API call to send the data to the database
    // Use the provided subjectName, courseCode, and selectedDepartment to send the data
  }

  Future<List<Map<String, dynamic>>> getMyCourse(ACYear) async {

    List<Map<String, dynamic>> MyCourseList = [];
    List<Map<String, dynamic>> CourseList = [];

    CourseList = await DbCourseMethods().getCourseInAY(ACYear);
    final localUser = GetStorage();
    final userData = localUser.read('user');
    CourseList.forEach((element) {
      if (userData['id'] == element['creator']) {
        MyCourseList.add(element);
      }

    });


    return MyCourseList;


  }









}
