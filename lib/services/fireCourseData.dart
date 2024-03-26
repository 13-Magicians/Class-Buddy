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
    await db.collection('AcademicYear').doc(documentID).collection(courseCode).doc('courseData').set(courseOriginData);
  }

  Future getCourseInAY(String documentID, String myID) async {
    List<Map<String, dynamic>> documentIdsList = [];

    List<String> collectionNames = [];

    QuerySnapshot<Map<String, dynamic>> collectionsSnapshot = await db.collectionGroup('').get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> snapshot in collectionsSnapshot.docs) {
      collectionNames.add(snapshot.reference.path.split('/')[0]);
    }

// Remove duplicates if necessary
    collectionNames = collectionNames.toSet().toList();
    print(collectionNames);

// Use collectionNames as needed

// Use collectionNames as needed

// Use collectionNames as needed

    // DocumentSnapshot<Map<String, dynamic>> academicYearSnapshot = await db.collection('AcademicYear').doc(documentID).get();

    // if (academicYearSnapshot.exists) {
    //   List<String> subcollectionNames = [];
    //   QuerySnapshot<Map<String, dynamic>> collectionsSnapshot = await academicYearSnapshot.reference.collection('agh').get();
    //   for (DocumentSnapshot<Map<String, dynamic>> collectionSnapshot in collectionsSnapshot.docs) {
    //     String collectionName = collectionSnapshot.id;
    //     subcollectionNames.add(collectionName);
    //     print(collectionName);
    //   }
    //
    //   // Use subcollectionNames as needed
    // }

    // QuerySnapshot querySnapshot = await db.collection('AcademicYear').doc(documentID).get();


    // db.collection('AcademicYear').get().then((value) => {
    //   value.docs.forEach((results) {
    //     db.collection('AcademicYear').doc(documentID).collection(collectionPath)
    //   })
    // });

    // try {
    //   final QuerySnapshot<Map<String, dynamic>> batchQuery = await db.collectionGroup('AcademicYear');
    //   print(batchQuery);
    // } catch (e) {
    //   print(e);
    //
    // }

    // db.collection('AcademicYear').doc(documentID).get().then((QuerySnapshot querySnapshot) {querySnapshot.docs.forEach((doc) {
    //   db.document(doc.id).collection('courseData')
    // })});

    // DocumentSnapshot<Map<String, dynamic>> courseCollection = db.collection('AcademicYear').doc(documentID);
    // courseCollection.forEach((element) {
    //   documentIdsList.add(element.data());
    // });

      // documentIdsList.add({'documentId': doc.reference});



    // Retrieve the document in the AcademicYear collection
    // DocumentSnapshot academicYearSnapshot = await FirebaseFirestore.instance.collection('AcademicYear').doc(documentID).get();
    // print(academicYearSnapshot.data());
    // // Get the collection IDs where creatorID matches myID

    // if (academicYearSnapshot.exists) {
    //   Map<String, dynamic>? data = academicYearSnapshot.data() as Map<String, dynamic>?;
    //   print(data);
    //
    //   data?.forEach((key, value) {
    //     print(key);
    //     print(value);
    //   });

      // if (data != null) {
      //   for (String collectionID in data.keys) {
      //     // Retrieve the courseData document in the collection
      //     DocumentSnapshot courseDataSnapshot = await FirebaseFirestore.instance.collection('AcademicYear').doc(documentID).collection(collectionID).doc('courseData').get();
      //     print(courseDataSnapshot);
      //
      //     if (courseDataSnapshot.exists && courseDataSnapshot.data() != null && (courseDataSnapshot.data()! as Map<String, dynamic>)['creatorID'] == myID) {
      //       courseCodes.add(collectionID);
      //     }
      //   }
      // }
    // }



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