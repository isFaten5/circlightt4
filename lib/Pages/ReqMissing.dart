import 'package:circlight/Pages/ListRequest.dart';
import 'package:circlight/Pages/Nav.dart';
import 'package:circlight/Pages/NavParent.dart';
import 'package:circlight/Pages/RequestParent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import '../flutter_flow/flutter_flow_pdf_viewer.dart';
import '../flutter_flow/flutter_flow_theme.dart';

import 'package:flutter/material.dart';
import 'package:circlight/Pages/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'dart:ui' as ui;

import '../flutter_flow/flutter_flow_widgets.dart';
import '../storage_service.dart';

import '../storage_service.dart';

class ReqMissing extends StatefulWidget {
  String documentId;
  ReqMissing({
    Key? key,
    required this.documentId,
  });

  @override
  _PreviewReqParent createState() => _PreviewReqParent();
}

class _PreviewReqParent extends State<ReqMissing> {
  final Storage storage = Storage();
  final _unfocusNode = FocusNode();
  var fileName;
  var path;
  var FileNa = "";
  var StratIndex;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _key = GlobalKey<FormState>();
  TextEditingController _Name = TextEditingController();
  late FixedExtentScrollController scrollController;
  late TextEditingController controller;
  var isPDF = true;
  bool Other = false;
  bool onError = false;
  var Type2;
  bool showFile = false;
  late String value = "-";
  int Index = 0;
  var ParentID = "G2tniHX0FfIB7dQWV616";
  final Reason = ["-", "مقبول", "مرفوض", "ناقص"];
  TextEditingController? emailAddressController1;
  TextEditingController? emailAddressController2;
  TextEditingController? emailAddressController3;
  TextEditingController ContentController = TextEditingController();
  var Title = "";
  int _changedNumber = 0;
  int _selectedNumber = 1;
  RequestParent ReqParent2 = new RequestParent(
      Type: "", Content: "", Date: "", ParentID: "", Title: "", Status: "");

  @override
  void dispose() {
    _unfocusNode.dispose();
    ContentController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    controller = TextEditingController(text: Reason[Index]);
    scrollController = FixedExtentScrollController(initialItem: Index);
    emailAddressController1 = TextEditingController();
    emailAddressController2 = TextEditingController();

    emailAddressController3 = TextEditingController();
  }

  final firebase_storage.FirebaseStorage storage2 =
      firebase_storage.FirebaseStorage.instance;
  List<String> PName = [];
  List<String> SName = [];

  List<String> SStatus = [];
  List<String> Notes = [];
  List<String> Content = [];
  List<String> RUrl = [];
  List<String> TType = [];
  List<String> TTitle = [];
  /*Future GetNames() async {
    //Names.clear();
    // print("pppppppppp");
    await FirebaseFirestore.instance.collection("RequestParent").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            if (document.reference.id == widget.documentId) {
              print(document.reference.id);
              print(widget.documentId);
              // print("aaaaaaaaaaa");
              var ID = document["ParentID"];
              print("aaaaaaaaaaa");
              var StName = document["StudentUserName"];

              FirebaseFirestore.instance
                  .collection("Parent")
                  .get()
                  .then((snapshot) => snapshot.docs.forEach((document) {
                        // print("bbbbbbbbbb");
                        if (ID == document.reference.id) {
                          print("cccccccccccccccc");
                          Names.add(document["Name"]);
                          // print(document["Name"]);
                        }
                      }));
              //  print("ddddddddddddddddd");
              FirebaseFirestore.instance
                  .collection("Student")
                  .get()
                  .then((snapshot) => snapshot.docs.forEach((document) {
                        // print("gggggggggggggg");
                        // print(StName);
                        //   print(document["StudentUserName"]);
                        if (StName == document["UserName"]) {
                          // print("hhhhhhhhhhhhh");
                          Names.add(document["Name"]);
                          print("555555555555555555555555");
                          // print(document["Name"]);
                        }
                      }));

              // print(document.reference.id);
              // print("parentids are${listParentId}");
              // print("pppppppppppppppppppppppp");
              // print(document["Name"]);
              print("ssssssssssssssssssssssssssssssssssssss");
            }
          }),
        );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color(0x411D2429),
                        offset: Offset(0, -2),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 202.1,
                        decoration: BoxDecoration(
                          //   color: FlutterFlowTheme.of(context).primaryColor,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.asset(
                              'assets/images/formbackground.png',
                            ).image,
                          ),
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("RequestParent")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            final snap = snapshot.data!.docs;

                            return FutureBuilder(
                              future: Future.wait([GetStudentName4(snap)]),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Align(
                                      child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: 1,
                                    itemBuilder: (context, index) {
                                      //  print("666666666666");c

                                      if (TType[index] == "pdf") {
                                        print(
                                            "IMINNNNNNNNNNNNNNNNNNNNNNNNNNNN");
                                        isPDF = true;
                                      } else {
                                        if (TType[index] == "png" ||
                                            TType[index] == "jpg") {
                                          isPDF = false;
                                        }
                                      }

                                      print(isPDF);
                                      String str = Content[index];
                                      // _Name..text = TTitle[index];
                                      int endIndex = 0;
                                      int startIndex = 0;
                                      String result = "..";
                                      ReqParent2.Content = Content[index];
                                      if (str.length > 30) {
                                        endIndex = 20;
                                      } else if (str.length > 25) {
                                        endIndex = 20;
                                      } else {
                                        endIndex = str.length;
                                      }
                                      var Stat;
                                      if (SStatus[index] == "Accepted") {
                                        Stat = "مقبول";
                                      } else if (SStatus[index] == "rejected") {
                                        Stat = "مرفوض";
                                      } else if (SStatus[index] == "Missing") {
                                        Stat = "ناقص";
                                      } else if (SStatus[index] ==
                                          "InProgress") {
                                        Stat = "تحت المعالجة";
                                      }
                                      //find substring
                                      ReqParent2.Title = TTitle[index];
                                      result = result +
                                          str.substring(startIndex, endIndex);
                                      var TheUrl;
                                      print("2222222222222222222222222222222");
                                      TheUrl = RUrl[index];
                                      print(RUrl[index]);
                                      print(TType[index]);
                                      print(isPDF);
                                      return Form(
                                          key: _key,
                                          child: Stack(
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 150,
                                                  ),
                                                  SizedBox(
                                                    width: 128,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                70, 0, 15, 0),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            CupertinoPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        NavParent(
                                                                          TabValue:
                                                                              17,
                                                                        )));
                                                      },
                                                      icon: Icon(
                                                        Icons.arrow_forward_ios,
                                                        size: 16,
                                                        color: Colors.white,
                                                      ),
                                                      color: Color.fromARGB(
                                                          255, 202, 21, 21),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 150, 0, 0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 4,
                                                        color:
                                                            Color(0x5B000000),
                                                        offset: Offset(0, -2),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(0),
                                                      bottomRight:
                                                          Radius.circular(0),
                                                      topLeft:
                                                          Radius.circular(20),
                                                      topRight:
                                                          Radius.circular(20),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(20,
                                                                    16, 20, 0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),

                                                      //

                                                      //
                                                      //
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 6),
                                                        child: Align(
                                                          alignment: Alignment(
                                                              0.91, 0),
                                                          child: Text(
                                                            "عنوان الطلب",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .title2
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: Color(
                                                                      0xFF29294D),
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(16, 0,
                                                                    16, 4),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 45,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Stack(
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.89,
                                                                            0),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              10,
                                                                              4,
                                                                              0),
                                                                      child:
                                                                          Text(
                                                                        TTitle[
                                                                            index],
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      width: 90,
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 6),
                                                        child: Align(
                                                          alignment: Alignment(
                                                              0.91, 0),
                                                          child: Text(
                                                            "حالة الطلب",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .title2
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: Color(
                                                                      0xFF29294D),
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(16, 0,
                                                                    16, 4),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 45,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Stack(
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.89,
                                                                            0),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              10,
                                                                              4,
                                                                              0),
                                                                      child:
                                                                          Text(
                                                                        Stat,
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      width: 90,
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 9, 0, 0),
                                                        child: Align(
                                                          alignment: Alignment(
                                                              0.91, 0),
                                                          child: Text(
                                                            "الطالب",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .title2
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: Color(
                                                                      0xFF29294D),
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(16, 3,
                                                                    16, 4),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 45,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Stack(
                                                                children: [
                                                                  Center(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.89,
                                                                              0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            10,
                                                                            4,
                                                                            0),
                                                                        child:
                                                                            Text(
                                                                          SName[
                                                                              index],
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style:
                                                                              FlutterFlowTheme.of(context).bodyText1,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      width: 90,
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 9, 0, 0),
                                                        child: Align(
                                                          alignment: Alignment(
                                                              0.91, 0),
                                                          child: Text(
                                                            "الملاحظات المرفقه",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .title2
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: Color(
                                                                      0xFF29294D),
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(16, 3,
                                                                    16, 4),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 45,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Stack(
                                                                children: [
                                                                  Center(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.89,
                                                                              0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            10,
                                                                            4,
                                                                            0),
                                                                        child:
                                                                            Text(
                                                                          Notes[
                                                                              index],
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style:
                                                                              FlutterFlowTheme.of(context).bodyText1,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      width: 90,
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 20,
                                                                right: 20,
                                                                top: 0,
                                                                bottom: 0),
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          20),
                                                              child:
                                                                  Directionality(
                                                                      textDirection: ui
                                                                          .TextDirection
                                                                          .rtl,
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            _Name,
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            onError =
                                                                                false;
                                                                          });
                                                                        },
                                                                        style: TextStyle(
                                                                            color: Color.fromARGB(
                                                                                139,
                                                                                46,
                                                                                41,
                                                                                95),
                                                                            fontSize:
                                                                                14),
                                                                        decoration:
                                                                            InputDecoration(
                                                                          prefixIcon:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 28),
                                                                            child:
                                                                                Icon(
                                                                              Icons.title,
                                                                              color: Color.fromARGB(139, 46, 41, 95),
                                                                              size: 22,
                                                                            ),
                                                                          ),
                                                                          alignLabelWithHint:
                                                                              true,
                                                                          floatingLabelBehavior:
                                                                              FloatingLabelBehavior.never,
                                                                          contentPadding: EdgeInsets.fromLTRB(
                                                                              30,
                                                                              5,
                                                                              10,
                                                                              5),
                                                                          labelText:
                                                                              ReqParent2.Title,
                                                                          labelStyle: TextStyle(
                                                                              color: Color(0xFF2E295F),
                                                                              fontSize: 14),
                                                                          hintText:
                                                                              'أدخل عنوان الطلب',
                                                                          hintStyle: TextStyle(
                                                                              color: Colors.grey.shade400,
                                                                              fontSize: 14),
                                                                          enabledBorder:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromARGB(139, 46, 41, 95),
                                                                              width: 1,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(20.0),
                                                                          ),
                                                                          focusedBorder:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20.0),
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color(0xFF2E295F),
                                                                              width: 0.5,
                                                                            ),
                                                                          ),
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromARGB(139, 46, 41, 95),
                                                                              width: 1,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(20.0),
                                                                          ),
                                                                        ),
                                                                        validator:
                                                                            (String?
                                                                                value) {
                                                                          if (value ==
                                                                              "") {
                                                                            setState(() {
                                                                              onError = true;
                                                                            });
                                                                            return null;
                                                                          }

                                                                          if (value !=
                                                                              null) {
                                                                            setState(() {
                                                                              onError = false;
                                                                            });
                                                                            return null;
                                                                          }
                                                                          return null;
                                                                        },
                                                                      )),
                                                            ),
                                                            onError
                                                                ? Positioned(
                                                                    bottom: 0,
                                                                    right: 1,
                                                                    child: Text(
                                                                        textAlign:
                                                                            TextAlign
                                                                                .right,
                                                                        "أرجو منك تعبئه الحقل الفارغ ",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                Colors.red)))
                                                                : Positioned(
                                                                    bottom: 0,
                                                                    right: 1,
                                                                    child: Text(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      " ",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            86,
                                                                            244,
                                                                            54),
                                                                      ),
                                                                    ),
                                                                  )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 20,
                                                                right: 20,
                                                                bottom: 0),
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          20),
                                                              child:
                                                                  Directionality(
                                                                      textDirection: ui
                                                                          .TextDirection
                                                                          .rtl,
                                                                      child:
                                                                          TextFormField(
                                                                        minLines:
                                                                            3,
                                                                        maxLines:
                                                                            5,
                                                                        keyboardType:
                                                                            TextInputType.multiline,
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            onError =
                                                                                false;
                                                                          });
                                                                        },
                                                                        style: TextStyle(
                                                                            color: Color.fromARGB(
                                                                                139,
                                                                                46,
                                                                                41,
                                                                                95),
                                                                            fontSize:
                                                                                14),
                                                                        controller:
                                                                            ContentController,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          contentPadding:
                                                                              EdgeInsets.only(
                                                                            top:
                                                                                30.0,
                                                                            bottom:
                                                                                10,
                                                                          ),
                                                                          prefixIcon:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.all(defaultPadding),
                                                                            child:
                                                                                Icon(
                                                                              Icons.message,
                                                                              color: Color.fromARGB(139, 46, 41, 95),
                                                                              size: 22,
                                                                            ),
                                                                          ),
                                                                          alignLabelWithHint:
                                                                              true,
                                                                          floatingLabelBehavior:
                                                                              FloatingLabelBehavior.never,
                                                                          labelText:
                                                                              ReqParent2.Content,
                                                                          labelStyle: TextStyle(
                                                                              color: Color(0xFF2E295F),
                                                                              fontSize: 14),
                                                                          hintText:
                                                                              'أدخل محتوى الطلب',
                                                                          hintStyle: TextStyle(
                                                                              color: Color.fromARGB(139, 46, 41, 95),
                                                                              fontSize: 14),
                                                                          enabledBorder:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromARGB(139, 46, 41, 95),
                                                                              width: 1,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(20.0),
                                                                          ),
                                                                          focusedBorder:
                                                                              OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20.0),
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromARGB(139, 46, 41, 95),
                                                                              width: 0.5,
                                                                            ),
                                                                          ),
                                                                          border:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color.fromARGB(139, 46, 41, 95),
                                                                              width: 1,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(20.0),
                                                                          ),
                                                                        ),
                                                                        validator:
                                                                            (String?
                                                                                value) {
                                                                          if (value ==
                                                                              "") {
                                                                            setState(() {
                                                                              onError = true;
                                                                            });
                                                                            return null;
                                                                          }

                                                                          if (value !=
                                                                              null) {
                                                                            setState(() {
                                                                              onError = false;
                                                                            });
                                                                            return null;
                                                                          }
                                                                          return null;
                                                                        },
                                                                      )),
                                                            ),
                                                            onError
                                                                ? Positioned(
                                                                    bottom: 0,
                                                                    right: 1,
                                                                    child: Text(
                                                                        textAlign:
                                                                            TextAlign
                                                                                .right,
                                                                        "أرجو منك تعبئه الحقل الفارغ ",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                Colors.red)))
                                                                : Positioned(
                                                                    bottom: 0,
                                                                    right: 1,
                                                                    child: Text(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .right,
                                                                      " ",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            86,
                                                                            244,
                                                                            54),
                                                                      ),
                                                                    ),
                                                                  )
                                                          ],
                                                        ),
                                                      ),

                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(22, 4,
                                                                    22, 5),
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            final results =
                                                                await FilePicker
                                                                    .platform
                                                                    .pickFiles(
                                                              allowMultiple:
                                                                  false,
                                                              type: FileType
                                                                  .custom,
                                                              allowedExtensions: [
                                                                'png',
                                                                'jpg',
                                                                "pdf"
                                                              ],
                                                            );
                                                            if (results ==
                                                                null) {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                const SnackBar(
                                                                  content: Text(
                                                                      'No file selected.'),
                                                                ), // SnackBar
                                                              );
                                                              return null;
                                                            }
                                                            path = results.files
                                                                .single.path!;
                                                            fileName = results
                                                                .files
                                                                .single
                                                                .name;
                                                            print(
                                                                ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");

                                                            FileNa = fileName;
                                                            StratIndex =
                                                                FileNa.length -
                                                                    3;
                                                            Type2 = FileNa
                                                                .substring(
                                                                    StratIndex);
                                                            print(
                                                                "[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[object]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]");
                                                            print(Type2);
                                                            setState(() {
                                                              showFile = true;
                                                            });
                                                            print(
                                                                "===============================");
                                                          },
                                                          text: ' رفع ملف',
                                                          icon: Icon(
                                                            Icons.upload_file,
                                                            color: Colors.white,
                                                            size: 15,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            width:
                                                                double.infinity,
                                                            height: 40,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    203,
                                                                    205,
                                                                    206),
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .subtitle2
                                                                    .override(
                                                                      fontFamily:
                                                                          'Outfit',
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                            borderSide:
                                                                BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                        ),
                                                      ),
                                                      // Padding(padding: padding)

                                                      showFile
                                                          ? Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          23,
                                                                          5),
                                                              child: Text(
                                                                FileNa +
                                                                    " تم إضافة الملف ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .subtitle2
                                                                    .override(
                                                                      fontSize:
                                                                          14,
                                                                      fontFamily:
                                                                          'Outfit',
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          102,
                                                                          169,
                                                                          104),
                                                                    ),
                                                              ))
                                                          : Text(""),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(22, 4,
                                                                    22, 16),
                                                        child: FFButtonWidget(
                                                          onPressed: () {
                                                            if (_key.currentState !=
                                                                    null &&
                                                                _key.currentState!
                                                                    .validate()) {
                                                              showCupertinoDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      CreateDialog3);
                                                            }
                                                            /* f.of(context).push(CupertinoPageRoute(
                        builder: (context) => Nav(
                          TabValue: 0,
                          documentId: "",
                        ),
                      ));*/
                                                          },
                                                          text: 'إرسال',
                                                          options:
                                                              FFButtonOptions(
                                                            width:
                                                                double.infinity,
                                                            height: 40,
                                                            color: const Color(
                                                                0xff0da6c2),
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .subtitle2
                                                                    .override(
                                                                      fontFamily:
                                                                          'Outfit',
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                            borderSide:
                                                                BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ));
                                    },
                                  ));
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ); /////////////
                          } else {
                            return const Text("");
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  CollectionReference Col = FirebaseFirestore.instance.collection('Parent');
  CollectionReference Col2 =
      FirebaseFirestore.instance.collection('RequestParent');
  CollectionReference ColStudent =
      FirebaseFirestore.instance.collection('Student');
  Widget CreateDialog3(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: const Text(' طلب ',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold)),
      content: Text(" هل تريد أرسال الطلب ؟",
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
      actions: <Widget>[
        TextButton(
            onPressed: () async {
              DateTime today = DateTime.now();
              String dateStr =
                  "${today.year}-${today.month}-${today.day} ${today.hour}:${today.minute}";
              // print(dateStr);

              /*  ReqParent2.AddRequestParent(_Title,_Name.text, Type,StudentUsername.text,
                 ParentID, dateStr);*/
              // Navigator.push(context,
              //     CupertinoPageRoute(builder: (context) => ListDelegator()));
              //parentx.DeleteParent(CurrentID);

              storage
                  .uploadFile(path, fileName, "06YH3Ox5AvO4eUYahk54")
                  .then((value) => print("Donnne!!!!!!!!"));

              String DownloadURL = await storage2
                  .ref("Files/06YH3Ox5AvO4eUYahk54/$fileName")
                  .getDownloadURL();

              ReqParent2.UpdateRequestParent(
                  widget.documentId, "Content", ContentController.text);
              ReqParent2.UpdateRequestParent(
                  widget.documentId, "Title", _Name.text);
              ReqParent2.UpdateRequestParent(
                  widget.documentId, "Url", DownloadURL);
              ReqParent2.UpdateRequestParent(
                  widget.documentId, "Status", "InProgress");
              Navigator.pop(context);
            },
            child: const Text("موافق",
                style: TextStyle(
                    color: Color.fromARGB(255, 197, 24, 24),
                    fontWeight: FontWeight.bold))),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('إلغاء'),
        ),
      ],
    );
  }

  Future GetStudentName4(snap) async {
    // print("Entered!");

    var ID;
    print("111111111111111111111111111111111111");
    await Col2.doc(widget.documentId).get().then((document) async {
      try {
        RUrl.add(document["Url"]);
        Content.add(document["Content"]);
        SStatus.add(document["Status"]);
        Notes.add(document["Response"]);
        TTitle.add(document["Title"]);
        TType.add(document["Type"]);
        await Col.doc(document["ParentID"]).get().then((value) {
          print("444444444444444444444444444444444444");
          PName.add(value["Name"]);
          print("++++++++++++++++++++++++");
        });
        await ColStudent.doc(document["StudentID"]).get().then((value) {
          print("99999999999999");

          print("Immmhhehrree");
          SName.add(value["Name"]);
          print(value["Name"]);
          print("666666666666666666666666666666");
          print("==================");

          print("8888888888888");
        });
      } catch (error) {
        //   print("error");
      }
    });

    // print(StudentName[0]);
  }
  /*
   FutureBuilder(
                                                                  future: storage
                                                                      .downloadURL(
                                                                          "20221228_163343.jpg",
                                                                          "06YH3Ox5AvO4eUYahk54"),
                                                                  builder: (BuildContext
                                                                          context,
                                                                      AsyncSnapshot<
                                                                              String>
                                                                          snapshot) {
                                                                    print(
                                                                        "ffffffffffffffffffffffffffff");
                                                                    if (snapshot.connectionState ==
                                                                            ConnectionState
                                                                                .done &&
                                                                        snapshot
                                                                            .hasData) {
                                                                      return Container(
                                                                          height:
                                                                              250,
                                                                          width:
                                                                              300,
                                                                          child:
                                                                              Image.network(
                                                                            snapshot.data!,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ));
                                                                    } else if (snapshot.connectionState ==
                                                                            ConnectionState
                                                                                .waiting ||
                                                                        !snapshot
                                                                            .hasData) {
                                                                      print(
                                                                          "---------------------------");
                                                                      //print(snapshot.data!.items[0].name);
                                                                      return Text(
                                                                          "SS");
                                                                    }
                                                                    return SizedBox(
                                                                      height: 0,
                                                                      width: 0,
                                                                    );
                                                                  }),*/
}
