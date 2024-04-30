import 'package:classbuddy/services/firebase_user_control.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentCourseCtrl {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getAllCourse(acYear, semNo) async {

    List<Map<String, dynamic>> documentIdsList = [];

    await db
        .collection('AcademicYear')
        .doc(acYear)
        .collection(semNo)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> academicYearSnapshot) {
      for (var academicYearDoc in academicYearSnapshot.docs) {
        Map<String, dynamic> data = academicYearDoc.data();
        data['id'] = academicYearDoc.id; // Add document ID to the data map
        documentIdsList.add(data);
      }
    });

    return documentIdsList;
  }
  
  Future enrollToCourse(String acYear, String semNo, String courseCode,String userId,String passCode, Map<String, dynamic> userInfo) async {
    bool isDone = false;
    DocumentSnapshot docSnap = await db.collection('AcademicYear').doc(acYear).collection(semNo).doc(courseCode).get();
    if (docSnap.get('passCode') == passCode) {
      db.collection('AcademicYear').doc(acYear).collection(semNo).doc(courseCode).collection('enrolled').doc(userId).set(userInfo);
      isDone = true;
    } else {
      isDone = false;
    }
    return isDone;
  }

  Future<List<Map<String, dynamic>>> getMyEnrolled(String acYear, String semNo, String userID) async {
    List<Map<String, dynamic>> enrolledDocs = [];

    QuerySnapshot querySnapshot = await db.collection('AcademicYear').doc(acYear).collection(semNo).get();

    for (var doc in querySnapshot.docs) {
      QuerySnapshot enrolledSnapshot = await db.collection('AcademicYear').doc(acYear).collection(semNo).doc(doc.id).collection('enrolled').get();

      for (var enrolledDoc in enrolledSnapshot.docs) {
        if (enrolledDoc.id == userID) {
          Map<String, dynamic>? enrolledData = doc.data() as Map<String, dynamic>?; // Explicit casting
          if (enrolledData != null) {
            enrolledDocs.add(enrolledData);
          }
          break; // No need to continue if the user is found in this document
        }
      }
    }

    return enrolledDocs;
  }


  Future getInCourseData(String acYear, String semNo, String courseId) async {
    DocumentSnapshot doc = await db.collection('AcademicYear').doc(acYear).collection(semNo).doc(courseId).get();
    DocumentSnapshot lDoc = await db.collection("Users").doc(doc['creator']).get();
    Map<String, dynamic> courseData = {};
    if (lDoc.exists) {
      Map<String, dynamic> data = lDoc.data() as Map<String, dynamic>;
      courseData = {
        'department':doc['department'],
        'Name':data['name'],
        'email':data['email'],
        'imgUrl':data['imgUrl'],
      };

    } else {

    }
    return courseData;
  }

  Future getInCourseTopic(String acYear, String semNo, String courseId) async {
    List<Map<String, dynamic>> topiclist = [];
    QuerySnapshot querySnapshot = await db.collection('AcademicYear').doc(acYear).collection(semNo).doc(courseId).collection('topics').get();
    for (var element in querySnapshot.docs) {
      Map<String, dynamic> topicData = element.data() as Map<String, dynamic>;
      topiclist.add(topicData);
    }
    print(topiclist);
    return topiclist;


  }











}

