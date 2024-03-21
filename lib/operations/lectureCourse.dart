import 'package:cloud_firestore/cloud_firestore.dart';

class AcademicOperation {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future getAcYears() async {
    QuerySnapshot querySnapshot = await db.collection('AcademicYear').get();
    List<Map<String, dynamic>> documentIds = [];

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> acY = {
        'documentID': doc.id,
      };

      documentIds.add(acY);
    });

    print(documentIds.length);

    return documentIds;

  }

}
