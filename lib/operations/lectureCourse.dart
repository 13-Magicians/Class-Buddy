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

    print(documentIds.length);

    return documentIds;
  }


  Future<void> addCourseACY(String documentID, String subjectName, String courseCode, String selectedDepartment) async {
    print(subjectName);
    print(courseCode);
    print(selectedDepartment);
    print(documentID);
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

  Future<void> getMyCourse() async {
    final localUser = GetStorage();
    final userData = localUser.read('user');
    print(userData['id']);
    await DbCourseMethods().getCourseInAY('18-19-Batch', userData['id']);
  }









}
