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



// Future getMyEnrolled(String acYear, String semNo) async {
//     List<Map<String, dynamic>> documentIdsList = [];
//
//     QuerySnapshot querySnapshot = await db.collection('AcademicYear').doc(acYear).collection(semNo).get();
//     for (var doc in querySnapshot.docs) {
//
//     }
//
//     return documentIdsList;
//
//
//   }

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




// Future getMyEnrolled(String acYear, String semNo, String userID) async {
  //   List<Map<String, dynamic>> documentIdsList = [];
  //
  //   QuerySnapshot querySnapshot = await db.collection('AcademicYear').doc(acYear).collection(semNo).get();
  //   for (var doc in querySnapshot.docs) {
  //     QuerySnapshot enrolledSnapshot = await db.collection('AcademicYear').doc(acYear).collection(semNo).doc(doc.id).collection('enrolled').get();
  //     for (var enrolledDoc in enrolledSnapshot.docs) {
  //       if (enrolledDoc.id == userID) {
  //
  //         return doc.data();
  //
  //       }
  //     }
  //   }
  //
  // }





}

