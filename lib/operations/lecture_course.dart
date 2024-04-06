import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import '../services/fireCourseData.dart';


class AcademicOperation {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future getAcYears() async {
    QuerySnapshot querySnapshot = await db.collection('AcademicYear').get();
    List<Map<String, dynamic>> documentIds = [];

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> acY = {
        'documentID': doc.id,
        'currentYear': doc['currentYear'],
      };

      documentIds.add(acY);
    }

    return documentIds;
  }


  Future<void> addCourseACY(String documentID, String subjectName, String courseCode, String selectedDepartment, String passCode, String semNo) async {
    final localUser = GetStorage();
    final userData = localUser.read('user');

    Map<String, dynamic> courseOriginData = {
      'courseCode':courseCode,
      'subjectName':subjectName,
      'department':selectedDepartment,
      'creator':userData['id'],
      'passCode':passCode,
    };

    DbCourseMethods().createCourse(documentID, courseCode, courseOriginData, semNo);


    // Implement your API call to send the data to the database
    // Use the provided subjectName, courseCode, and selectedDepartment to send the data
  }

  Future<List<Map<String, dynamic>>> getMyCourse(acYear, String semNo) async {

    List<Map<String, dynamic>> myCourseList = [];
    List<Map<String, dynamic>> courseList = [];

    courseList = await DbCourseMethods().getCourseInAY(acYear, semNo);
    final localUser = GetStorage();
    final userData = localUser.read('user');
    for (var element in courseList) {
      if (userData['id'] == element['creator']) {
        myCourseList.add(element);
      }

    }


    return myCourseList;


  }

  Future addTopic(acYear, Map<String, dynamic> courseData, Map<String, dynamic> subjectTopic,String semNo) async  {
    await DbCourseMethods().addTopicToCourse(acYear, subjectTopic, semNo, courseData['courseCode']);
  }

  Future<List<Map<String, dynamic>>> getTopics (acYear, semNo, courseCode) async {
    // List<Map<String, dynamic>> topicList = [];
    List<Map<String, dynamic>> receivedList = [];
    receivedList = await DbCourseMethods().getTopicsInSubject(acYear, semNo, courseCode);
    print(receivedList);

    return receivedList;
  }




}
