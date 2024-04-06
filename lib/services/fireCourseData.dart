import 'package:cloud_firestore/cloud_firestore.dart';


class DbCourseMethods {
  FirebaseFirestore db = FirebaseFirestore.instance;



  Future<List<Map<String, dynamic>>> getAllCourse() async {
    List<Map<String, dynamic>> documentIdsList = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('AcademicYear').get();
    querySnapshot.docs.forEach((doc) {
      documentIdsList.add({'documentId': doc.id});
    });
    return documentIdsList;
  }

  Future<void> createAcademicYear(String documentId, int ACYNo) async {
    try {
      CollectionReference academicYearCollection = db.collection('AcademicYear');
      await academicYearCollection.doc(documentId).set(<String, dynamic>{'currentYear':ACYNo});
      print('Document with ID $documentId created successfully');
    } catch (e) {
      print('Error creating document: $e');
    }
  }

  Future<void> deleteAcademicYear(String documentId) async {
    try {
      CollectionReference academicYearCollection = db.collection('AcademicYear');
      await academicYearCollection.doc(documentId).delete();
    } catch (e) {
      print(e);
    }
  }

  // course functions

  Future createCourse(String documentID, courseCode, Map<String, dynamic> courseOriginData, String semNo) async {
    await db.collection('AcademicYear').doc(documentID).collection(semNo).doc(courseCode).set(courseOriginData);
  }

  Future<List<Map<String, dynamic>>> getCourseInAY(String documentID, String semNo) async {
    // List<Map<String, dynamic>> subCollectionNames = [];

    // QuerySnapshot<Map<String, dynamic>> academicYearSnapshot = await db
    List<Map<String, dynamic>> subCollectionNames = [];
    await db
        .collection('AcademicYear')
        .doc(documentID)
        .collection(semNo)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> academicYearSnapshot) {
      academicYearSnapshot.docs.forEach((academicYearDoc) {
        Map<String, dynamic> data = academicYearDoc.data();
        data['id'] = academicYearDoc.id; // Add document ID to the data map
        subCollectionNames.add(data);
      });
    });

    return subCollectionNames;
  }

  Future deleteCourse(documentID,courseCode, String semNo) async {
    db.collection('AcademicYear').doc(documentID).collection(semNo).doc(courseCode).delete();
  }


  Future addTopicToCourse(acYear, Map<String, dynamic> subjectTopic,String semNo,String courseCode) async {
    return await db.collection('AcademicYear').doc(acYear).collection(semNo).doc(courseCode).collection('topics').add(subjectTopic);
  }

  Future<List<Map<String, dynamic>>> getTopicsInSubject (acYear, semNo,courseCode) async {
    List<Map<String, dynamic>> recivedList = [];
    QuerySnapshot querySnapshot = await db.collection('AcademicYear').doc(acYear).collection(semNo).doc(courseCode).collection('topics').get();
    querySnapshot.docs.forEach((doc) {
      recivedList.add({
        'topicName':doc['topicName'],
        'documentLink':doc['documentLink'],
        'topicNote':doc['topicNote'],
        'videoLink':doc['videoLink'],
      });
    });

    return recivedList;
  }



}