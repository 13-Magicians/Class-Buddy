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

  Future<void> createAcademicYear(String documentId) async {
    try {
      CollectionReference academicYearCollection = db.collection('AcademicYear');
      await academicYearCollection.doc(documentId).set(<String, dynamic>{});
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





}