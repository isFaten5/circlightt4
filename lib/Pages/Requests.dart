import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  String Dusername = " "; //

  String isAccepted = "Waiting"; //
  String isActive; //
  String DName = " ";

  String SID = " "; //
//

  Request(
      {required this.Dusername,
      required this.isAccepted,
      required this.isActive,
      required this.SID,
      required this.DName});
//to update student

// to delete student

// to add student
  AddRequest(DName, DUserName, IsAccepted, IsActive, SID, DACtive, Date,
      ParentID) async {
    final Delegator = FirebaseFirestore.instance;
    await Delegator.collection("Requests").add({
      "DelegatorName": DName,
      "DUserName": DUserName,
      'isAccepted': IsAccepted,
      'IsActive': IsActive,
      'StudentID': SID,
      "DelegatorActive": DACtive,
      "Date": Date,
      "ParentID": ParentID
    });
  }

  DeleteRequests(DocId) async {
    CollectionReference Parents =
        FirebaseFirestore.instance.collection("Requests");
    await Parents.doc(DocId).delete();
  }

  UpdateRequest(DocId, Field, Updated) async {
    CollectionReference Request =
        FirebaseFirestore.instance.collection("Requests");

    switch (Field) {
      case 'DUserName':
        await Request.doc(DocId).update({
          'DUserName': Updated,
        });
        break;

      case "DelegatorName":
        await Request.doc(DocId).update({
          'DelegatorName': Updated,
        });
        break;
      case "isAccepted":
        await Request.doc(DocId).update({
          'isAccepted': Updated,
        });
        break;
      case "IsActive":
        await Request.doc(DocId).update({
          'IsActive': Updated,
        });
        break;
      case "StudentID":
        await Request.doc(DocId).update({
          'StudentID': Updated,
        });
        break;
      case "DelegatorActive":
        await Request.doc(DocId).update({
          'DelegatorActive': Updated,
        });
        break;
      case "Date":
        await Request.doc(DocId).update({
          'Date': Updated,
        });
        break;
    }
  }
} //END OF CLASS
