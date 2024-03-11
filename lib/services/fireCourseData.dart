import 'package:cloud_firestore/cloud_firestore.dart';

class DbCourseMethods {
  FirebaseFirestore db = FirebaseFirestore.instance;
  
  Future getAllCourse() async {
    QuerySnapshot querySnapshot = await db.collection('CourseModule').get();
    querySnapshot.docs.forEach((doc) {
      print(doc);
    });

    return;
  }

  
  
  
}