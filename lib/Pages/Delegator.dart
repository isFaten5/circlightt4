import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:encryptor/encryptor.dart';

class Delegator {
  String Name = " "; //

  String Email = ""; //

  String DUserName = " "; //
  late String DNationalID; //

  late String Password;

  String State = ''; //

  Delegator(
      {required this.Name,
      required this.Email,
      required this.DUserName,
      required this.DNationalID,
      required this.Password,
      required this.State});

  UpdateDelegator(DocId, Field, Updated) async {
    CollectionReference Parents =
        FirebaseFirestore.instance.collection("Delegator2");
    bool IsUpdated = false;

    switch (Field) {
      case 'Name':
        await Parents.doc(DocId).update({
          'Name': Updated,
        });
        IsUpdated = true;
        break;
      case "UserName":
        await Parents.doc(DocId).update({
          'UserName': Updated,
        });
        break;
      case "Email":
        await Parents.doc(DocId).update({
          'Email': Updated,
        });
        break;

      case "ID":
        await Parents.doc(DocId).update({
          'ID': Updated,
        });
        break;

      case "Password":
        await Parents.doc(DocId).update({
          'Password': Updated,
        });
        break;

      case "State":
        await Parents.doc(DocId).update({
          'State': Updated,
        });
        break;
    }
    return IsUpdated;
  }
}
