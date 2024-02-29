

import 'package:cloud_firestore/cloud_firestore.dart';

class DataOrgManage {
  FirebaseFirestore db = FirebaseFirestore.instance;
  
  Future createDepartment () {
    return db.collection("Organization").doc("Departments").set(Map());
    
  }
  
  Future removeDepartment() {
    return db.collection("Organization").doc("Departments").delete();
    
  }

  Future getAllDepartment() {
    return db.collection("Organization").get();
  }
  
  checkDepartment() {
    
  }
  
  
}