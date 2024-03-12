

import 'package:cloud_firestore/cloud_firestore.dart';

class AcademicOperation {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future getAcYears() async {
    QuerySnapshot querySnapshot = await db.collection('Users').get();
    print(querySnapshot);


  }

}