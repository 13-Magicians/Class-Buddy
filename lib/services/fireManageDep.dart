

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataOrgManage {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future createDepartment (String fcName, String fcCode) async {
    try {
      // Add a new field "fcName" with the fcName value to the "Organization" collection document
      await db.collection("Organization").doc("Department").update({
        fcCode: fcName,
      });
    } catch (e) {
      // print(e);
    }
  }

  
  Future removeDepartment() {
    return db.collection("Organization").doc("Departments").delete();
    
  }

  List<Map<String, dynamic>> depList = [];

  Future departmentList() async {
    DocumentSnapshot doc = await db.collection("Organization").doc("Department").get();
    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      depList.add(data);
      print('---------------done-------------');
      print(depList);
    } else {
      print("Document does not exist on the database");
    }

    return depList;
  }


  

  
  
}