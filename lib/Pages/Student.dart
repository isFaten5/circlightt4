import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Student {
  String Name = " "; //

  String Class = " "; //
  String SNationalID; //

  String SNationality = " "; //
  String SUserName = " "; //
  String SBloodType = ""; //
  List<String> search = [];
  Student({
    required this.Name,
    required this.Class,
    required this.SNationalID,
    required this.SNationality,
    required this.SUserName,
    required this.SBloodType,
  });
//to update student
  UpdateStudent(DocId, Field, Updated) async {
    CollectionReference StudentS =
        FirebaseFirestore.instance.collection("Student");

    switch (Field) {
      case 'Name':
        await StudentS.doc(DocId).update({
          'Name': Updated,
        });
        break;

      case "UserName":
        await StudentS.doc(DocId).update({
          'UserName': Updated,
        });
        break;

      case "NationalID":
        await StudentS.doc(DocId).update({
          'NationalID': Updated,
        });
        break;
      case "Nationality":
        await StudentS.doc(DocId).update({
          'Nationality': Updated,
        });
        break;
      case "Class":
        await StudentS.doc(DocId).update({
          'Class': Updated,
        });
        break;
      case "BloodType":
        await StudentS.doc(DocId).update({
          'BloodType': Updated,
        });
        break;
    }
  }

// to delete student
  DeleteStudent(DocId) async {
    CollectionReference Parents =
        FirebaseFirestore.instance.collection("Student");
    await Parents.doc(DocId).delete();
  }

// to add student
  addStudent(DocId, Name, SUserName, SNationalID, SNationality, Class,
      SBloodType, AdminID) async {
    for (var i = 0; i < Name.length; i++) {
      search.add(Name.substring(0, i + 1));
    }
    final Student = FirebaseFirestore.instance;
    await Student.collection("Student").add({
      "ParentId": DocId,
      'Name': Name,
      'UserName': SUserName,
      'NationalID': SNationalID,
      'Nationality': SNationality,
      'Class': Class,
      'BloodType': SBloodType,
      'AdminID': AdminID,
      'Search': search,
    });
  }

  Existstudent(DocId, ParentID, Name, SUserName, SNationalID, SNationality,
      Class, SBloodType, AdminID) async {
    final Student = FirebaseFirestore.instance.collection("Student");
    await Student.doc(DocId).set({
      "ParentId": ParentID,
      "Name": Name,
      'UserName': SUserName,
      'NationalID': SNationalID,
      'Nationality': SNationality,
      'Class': Class,
      'BloodType': SBloodType,
      'AdminID': AdminID,
    });
  }
} //END OF CLASS
