

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataOrgManage {
  FirebaseFirestore db = FirebaseFirestore.instance;



  Future createDepartment (String fcName, String fcCode) async {
    try {
      await db.collection("Organization").doc("Department").update({
        fcCode: fcName,
      });
    } catch (e) {
      // print(e);
    }
  }

  
  Future removeDepartment() {
    return db.collection("Organization").doc("Department").delete();
    
  }

  Future<void> deleteDepartment(String departmentId) async {
    try {
      await db.collection('Organization').doc('Department').update({
        departmentId: FieldValue.delete(),
      });
      print('Department deleted successfully');
    } catch (error) {
      print('Error deleting department: $error');
    }
  }



  Future departmentList() async {
    List<Map<String, dynamic>> depList = [];
    DocumentSnapshot doc = await db.collection("Organization").doc("Department").get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    data.forEach((key, value) {
      Map<String, dynamic> department = {
        'id': key,
        'name': value,
      };
      depList.add(department);
    });

    return depList;
  }


  

  
  
}