


// class AcademicOperation {
//   FirebaseFirestore db = FirebaseFirestore.instance;
//
//   Future getAcYears() async {
//     QuerySnapshot querySnapshot = await db.collection('AcademicYear').get();
//     List<String> documentIds = [];
//
//     querySnapshot.docs.forEach((doc) {
//       documentIds.add(doc.id);
//     });
//     print("=====================================");
//
//     print(documentIds);
//
//   }
//
// }