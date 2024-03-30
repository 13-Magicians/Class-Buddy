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

  // course functions

  Future createCourse(String documentID, courseCode, Map<String, dynamic> courseOriginData) async {
    await db.collection('AcademicYear').doc(documentID).collection('subjects').doc(courseCode).set(courseOriginData);
  }

  // Future<List<Map<String, dynamic>>> getCourseInAY(String documentID) async {
  //   print(documentID);
  //   List<Map<String, dynamic>> subCollectionNames = [];
  //   QuerySnapshot<Map<String, dynamic>> academicYearSnapshot = await db.collection('AcademicYear').doc(documentID).collection('subjects').get();
  //
  //   for (DocumentSnapshot<Map<String, dynamic>> academicYearDoc in academicYearSnapshot.docs) {
  //     Map<String, dynamic>? data = academicYearDoc.data();
  //     if (data != null) {
  //       data['id'] = academicYearDoc.id; // Add document ID to the data map
  //       subCollectionNames.add(data);
  //     }
  //   }
  //   return subCollectionNames;
  // }

  Future<List<Map<String, dynamic>>> getCourseInAY(String documentID) async {
    // List<Map<String, dynamic>> subCollectionNames = [];

    // QuerySnapshot<Map<String, dynamic>> academicYearSnapshot = await db
    List<Map<String, dynamic>> subCollectionNames = [];
    await db
        .collection('AcademicYear')
        .doc(documentID)
        .collection('subjects')
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

  Future deleteCourse(documentID,courseCode) async {
    db.collection('AcademicYear').doc(documentID).collection('subjects').doc(courseCode).delete();
  }








// Future<List<String>> getCourseInAY(String documentID, String myID) async {
  //   // Retrieve the document in the AcademicYear collection
  //   DocumentSnapshot academicYearSnapshot = await FirebaseFirestore.instance.collection('AcademicYear').doc(documentID).get();
  //
  //   // Get the collection IDs where creatorID matches myID
  //   List<String> courseCodes = [];
  //   if (academicYearSnapshot.exists) {
  //     Map<String, dynamic>? data = academicYearSnapshot.data() as Map<String, dynamic>?;
  //     if (data != null) {
  //       for (String collectionID in data.keys) {
  //         // Retrieve the courseData document in the collection
  //         DocumentSnapshot courseDataSnapshot = await FirebaseFirestore.instance.collection('AcademicYear').doc(documentID).collection(collectionID).doc('courseData').get();
  //
  //         if (courseDataSnapshot.exists && courseDataSnapshot.data() != null && courseDataSnapshot.data()!['creatorID'] == myID) {
  //           courseCodes.add(collectionID);
  //         }
  //       }
  //     }
  //   }
  //
  //   return courseCodes;
  // }

  //
  // Future<List<String>> getCourseInAY(String documentID, String creatorID) async {
  //   try {
  //     // Retrieve all subcollections under the 'AcademicYear' document
  //     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //         .collection('AcademicYear')
  //         .doc(documentID)
  //         .collectionGroup('') // Retrieve all subcollections
  //         .get();
  //
  //     // Extract document IDs where creatorID matches provided creatorID
  //     List<String> documentIds = [];
  //     for (QueryDocumentSnapshot subcollection in querySnapshot.docs) {
  //       QuerySnapshot subcollectionQuerySnapshot =
  //       await subcollection.reference
  //           .where('courseData.creatorID', isEqualTo: creatorID)
  //           .get();
  //       subcollectionQuerySnapshot.docs.forEach((doc) {
  //         documentIds.add(doc.id);
  //       });
  //     }
  //     return documentIds;
  //   } catch (error) {
  //     // Handle errors here
  //     print('Error retrieving document IDs: $error');
  //     return []; // Return an empty list in case of an error
  //   }
  // }


// Future getCourseInAY(documentID, creatorID) async {
  //   QuerySnapshot querySnapshot = await db.collection('AcademicYear').doc(documentID).collection(courseCode).doc('courseData').get()
  //
  // }





}