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


}

