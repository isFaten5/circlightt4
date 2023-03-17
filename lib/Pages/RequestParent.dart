import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class RequestParent {
  String Title = " "; //

  String Status = " "; //
  String Content = ""; //
  String ParentID = " ";
  String Type = " ";
  String SUsername = " "; //
  String Date = " "; //
//

  RequestParent(
      {required this.Title,
      required this.Status,
      required this.Type,
      required this.Content,
      required this.ParentID,
      required this.Date});
//to update student

// to delete student

// to add student
  AddRequestParent(Title, Status, Content, ParentID, SID, Date, Res, Url, Type,
      AdminID) async {
    final ParentRequest = FirebaseFirestore.instance;

    await ParentRequest.collection("RequestParent").add({
      "Title": Title,
      "Status": Status,
      'Content': Content,
      'ParentID': ParentID,
      'AdminID': AdminID,
      "StudentID": SID,
      "Date": Date,
      "Response": Res,
      "Url": Url,
      "Type": Type
    });
  }

  UpdateRequestParent(DocId, Field, Updated) async {
    CollectionReference RequestParent =
        FirebaseFirestore.instance.collection("RequestParent");

    switch (Field) {
      case 'Title':
        await RequestParent.doc(DocId).update({
          'Title': Updated,
        });
        break;

      case "Status":
        await RequestParent.doc(DocId).update({
          'Status': Updated,
        });
        break;

      case "Content":
        await RequestParent.doc(DocId).update({
          'Content': Updated,
        });
        break;
      case "ParentID":
        await RequestParent.doc(DocId).update({
          'ParentID': Updated,
        });
        break;
      case "StudentID":
        await RequestParent.doc(DocId).update({
          'StudentID': Updated,
        });
        break;
      case "Date":
        await RequestParent.doc(DocId).update({
          'Date': Updated,
        });
        break;
      case "Response":
        await RequestParent.doc(DocId).update({
          'Response': Updated,
        });
        break;
      case "Url":
        await RequestParent.doc(DocId).update({
          'Url': Updated,
        });
        break;
      case "Type":
        await RequestParent.doc(DocId).update({
          'Type': Updated,
        });
        break;
    }
  }

  DeleteRequestsParent(DocId) async {
    CollectionReference Parents =
        FirebaseFirestore.instance.collection("RequestParent");
    await Parents.doc(DocId).delete();
  }
} //END OF CLASS
