import 'package:circlight/Pages/AdminPRequest.dart';
import 'package:circlight/Pages/ListReqAdmin.dart';
import 'package:circlight/Pages/ListRequest.dart';
import 'package:circlight/Pages/Nav.dart';
import 'package:circlight/Pages/RequestParent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../flutter_flow/flutter_flow_pdf_viewer.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:circlight/home_page/home_page_model.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

import '../storage_service.dart';

class RequestDone extends StatefulWidget {
  String documentId;
  RequestDone({
    Key? key,
    required this.documentId,
  });

  @override
  _PreviewReqParent createState() => _PreviewReqParent();
}

class _PreviewReqParent extends State<RequestDone> {
  final Storage storage = Storage();
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _key = GlobalKey<FormState>();
  TextEditingController _Name = TextEditingController();
  late FixedExtentScrollController scrollController;
  late TextEditingController controller;
  var isPDF = true;
  bool Other = false;
  bool onError = false;
  late String value = "-";
  int Index = 0;
  var ParentID = "G2tniHX0FfIB7dQWV616";
  final Reason = ["-", "مقبول", "مرفوض", "ناقص"];
  TextEditingController? emailAddressController1;
  TextEditingController? emailAddressController2;
  TextEditingController? emailAddressController3;
  var Title = "";
  int _changedNumber = 0;
  int _selectedNumber = 1;
  RequestParent ReqParent2 = new RequestParent(
      Type: "", Content: "", Date: "", ParentID: "", Title: "", Status: "");

  @override
  void dispose() {
    _unfocusNode.dispose();

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
                                      //  print("666666666666");
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
                                      int endIndex = 0;
                                      int startIndex = 0;
                                      String result = "..";
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
                                                    width: 120,
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
                                                                        Nav(
                                                                          TabValue:
                                                                              16,
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
                                                            "ولي الأمر",
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
                                                                        PName[
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
                                                                    0, 8, 0, 0),
                                                        child: Align(
                                                          alignment: Alignment(
                                                              0.91, 0),
                                                          child: Text(
                                                            "محتوى الطلب",
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
                                                                .fromSTEB(16, 4,
                                                                    16, 4),
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
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
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            20,
                                                                            12),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                0,
                                                                                20,
                                                                                0),
                                                                            child: Align(
                                                                                alignment: Alignment(1.2, 0.7),
                                                                                child: SizedBox(
                                                                                    height: 80,
                                                                                    width: 80,
                                                                                    child: SingleChildScrollView(
                                                                                      child: Text(
                                                                                        Content[index],
                                                                                        textAlign: TextAlign.left,
                                                                                        style: FlutterFlowTheme.of(context).title2.override(
                                                                                              fontFamily: 'Outfit',
                                                                                              color: Color(0xFF29294D),
                                                                                              fontSize: 15,
                                                                                              fontWeight: FontWeight.w300,
                                                                                            ),
                                                                                      ),
                                                                                    ))),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                      /////
                                                      ///
                                                      ///
                                                      ///

                                                      ///\\
                                                      ///
                                                      ///
                                                      ///
                                                      ///

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
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 8, 0, 0),
                                                        child: Align(
                                                          alignment: Alignment(
                                                              0.91, 0),
                                                          child: Text(
                                                            "المرفقات",
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
                                                                .fromSTEB(16, 4,
                                                                    16, 4),
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
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
                                                          child: isPDF
                                                              ? Scrollbar(
                                                                  thickness: 6,
                                                                  isAlwaysShown:
                                                                      true,
                                                                  radius: const Radius
                                                                          .circular(
                                                                      10),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            20,
                                                                            0,
                                                                            20,
                                                                            12),
                                                                    child: Container(
                                                                        height: 500,
                                                                        child: FlutterFlowPdfViewer(
                                                                          width:
                                                                              400,
                                                                          networkPath:
                                                                              RUrl[index],
                                                                          horizontalScroll:
                                                                              false,
                                                                        )),
                                                                  ))
                                                              : Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16,
                                                                          4,
                                                                          16,
                                                                          4),
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    child: FutureBuilder(
                                                                        future: storage.downloadURL("20221228_163343.jpg", "06YH3Ox5AvO4eUYahk54"),
                                                                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                                                          print(
                                                                              "ffffffffffffffffffffffffffff");
                                                                          if (snapshot.connectionState == ConnectionState.done &&
                                                                              snapshot
                                                                                  .hasData) {
                                                                            return Container(
                                                                                height: 250,
                                                                                width: 300,
                                                                                child: Image.network(
                                                                                  RUrl[index],
                                                                                  fit: BoxFit.cover,
                                                                                ));
                                                                          } else if (snapshot.connectionState == ConnectionState.waiting ||
                                                                              !snapshot.hasData) {
                                                                            print("---------------------------");
                                                                            //print(snapshot.data!.items[0].name);
                                                                            return Text("");
                                                                          }
                                                                          return SizedBox(
                                                                            height:
                                                                                0,
                                                                            width:
                                                                                0,
                                                                          );
                                                                        }),
                                                                  ),
                                                                ),
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        height: 30,
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
            onPressed: () {
              DateTime today = DateTime.now();
              String dateStr =
                  "${today.year}-${today.month}-${today.day} ${today.hour}:${today.minute}";
              // print(dateStr);

              /*  ReqParent2.AddRequestParent(_Title,_Name.text, Type,StudentUsername.text,
                 ParentID, dateStr);*/
              // Navigator.push(context,
              //     CupertinoPageRoute(builder: (context) => ListDelegator()));
              //parentx.DeleteParent(CurrentID);

              var Stat;
              if (value == "مقبول") {
                Stat = "Accepted";
              } else if (value == "مرفوض") {
                Stat = "rejected";
              } else if (value == "ناقص") {
                Stat = "Missing";
              } else {
                Stat = "InProgress";
              }
              ReqParent2.UpdateRequestParent(
                  widget.documentId, "Response", _Name.text);
              ReqParent2.UpdateRequestParent(widget.documentId, "Status", Stat);
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
