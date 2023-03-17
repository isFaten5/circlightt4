import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:adobe_xd/adobe_xd.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:encryptor/encryptor.dart';

class Admin {
  //get doc id
  String Email = ""; //
  String Password = " "; //
  String SchoolName=""; //
  String Username = " "; //

  

 
 

  
   Future<List<String>> ParentListView() async {
    List<String> docIDS = [];
   
    await FirebaseFirestore.instance.collection("Parent").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
       
            docIDS.add(document.reference.id);
          }),
        );
 
    return docIDS;
  }


// to get all the admin
  Future<List<String>> getAdminID() async {
    List<String> AdminID = [];
    
    await FirebaseFirestore.instance.collection("Admin").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
           
            AdminID.add(document.reference.id);
          }),
        );
   
    return AdminID;
  }

  
//the list of all student to view the id 
  Future<List<String>> StudentListveiw() async {
    List<String> docIDSStudent = [];
    
    await FirebaseFirestore.instance.collection("Student").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
          
            docIDSStudent.add(document.reference.id);
          }),
        );
    
    return docIDSStudent;
  }
}//End of class
