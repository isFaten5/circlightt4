import 'package:circlight/Pages/ListReqAdmin.dart';
import 'package:circlight/Pages/RequestParent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../flutter_flow/flutter_flow_pdf_viewer.dart';
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

class PreviewReqAdmin extends StatefulWidget {
  String documentId;
  PreviewReqAdmin({
    Key? key,
    required this.documentId,
  });

  @override
  _PreviewReqAdmin createState() => _PreviewReqAdmin();
}

class _PreviewReqAdmin extends State<PreviewReqAdmin> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _key = GlobalKey<FormState>();
  TextEditingController _Name = TextEditingController();
  late FixedExtentScrollController scrollController;
  late TextEditingController controller;
  bool Other = false;
  List<String> RUrl = [];
  bool onError = false;
  final Storage storage = Storage();
  late String value = "-";
  int Index = 0;
  var ParentID = "G2tniHX0FfIB7dQWV616";
  final Reason = ["-", "مقبول", "مرفوض", "ناقص"];
  TextEditingController? emailAddressController1;
  TextEditingController? emailAddressController2;
  TextEditingController? emailAddressController3;
  List<String> TType = [];
  var Title = "";
  int _changedNumber = 0;
  int _selectedNumber = 1;
  RequestParent ReqParent2 = new RequestParent(
      Type: "", Content: "", Date: "", ParentID: "", Title: "", Status: "");
  var ParentName = [];
  var isPDF = true;
  var StudentNames = [];
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
  List<String> TTitle = [];
  List<String> Content = [];

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

                                      String str = snap[index]['Content'];
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
                                      //find substring
                                      result = result +
                                          str.substring(startIndex, endIndex);

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
                                                    width: 158,
                                                  ),
                                                  SizedBox(
                                                    width: 40,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 5, 0, 0),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            CupertinoPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ListReqAdmin()));
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
                                              //

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
                                                                                0,
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
                                                            width: MediaQuery
                                                                    .of(context)
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
                                                                    thickness:
                                                                        6,
                                                                    isAlwaysShown:
                                                                        true,
                                                                    radius:
                                                                        const Radius.circular(
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
                                                                    child: Container(
                                                                        width: MediaQuery.of(context).size.width,
                                                                        decoration: BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        ),
                                                                        child: FutureBuilder(
                                                                            future: storage.downloadURL("20221228_163343.jpg", "06YH3Ox5AvO4eUYahk54"),
                                                                            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                                                              print("ffffffffffffffffffffffffffff");
                                                                              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                                                                                return Container(
                                                                                    height: 250,
                                                                                    width: 300,
                                                                                    child: Image.network(
                                                                                      RUrl[index],
                                                                                      fit: BoxFit.cover,
                                                                                    ));
                                                                              } else if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                                                                                print("---------------------------");
                                                                                //print(snapshot.data!.items[0].name);
                                                                                return Text("");
                                                                              }
                                                                              return SizedBox(
                                                                                height: 0,
                                                                                width: 0,
                                                                              );
                                                                            })))),
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
                                                      Center(
                                                        child: new Wrap(
                                                            spacing: 5.0,
                                                            runSpacing: 5.0,
                                                            direction: Axis
                                                                .vertical, // main axis (rows or columns)
                                                            children: <Widget>[
                                                              CupertinoButton(
                                                                child: Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .only(
                                                                      right: 0,
                                                                      left: 0,
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      // padding:
                                                                      width:
                                                                          380,
                                                                      height:
                                                                          47,

                                                                      //   EdgeInsets.symmetric(horizontal: 120),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(18),
                                                                        border:
                                                                            Border.all(
                                                                          color: Color.fromARGB(
                                                                              139,
                                                                              46,
                                                                              41,
                                                                              95),
                                                                          width:
                                                                              1,
                                                                        ),
                                                                      ),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Flexible(
                                                                        child:
                                                                            Row(
                                                                          textDirection: ui
                                                                              .TextDirection
                                                                              .rtl,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end, //change here don't //worked
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.end,
                                                                          children: <
                                                                              Widget>[
                                                                            Container(
                                                                              child: Row(
                                                                                children: <Widget>[
                                                                                  Container(
                                                                                    alignment: Alignment.center,
                                                                                    padding: EdgeInsets.only(left: 10),
                                                                                    child: Positioned(
                                                                                      left: 0,
                                                                                      child: Icon(
                                                                                        Icons.arrow_circle_down_rounded,
                                                                                        // Icons.arrow_downward_outlined,
                                                                                        color: Color.fromARGB(139, 46, 41, 95),
                                                                                        size: 16,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: Alignment.centerLeft,
                                                                                    child: Container(
                                                                                      width: 120,
                                                                                      alignment: Alignment.center,
                                                                                      padding: EdgeInsets.only(right: 50),
                                                                                      child: Text(
                                                                                        textAlign: TextAlign.end,
                                                                                        style: GoogleFonts.poppins(
                                                                                          fontSize: 14,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          color: Color.fromARGB(139, 46, 41, 95),
                                                                                        ),
                                                                                        controller.text,
                                                                                        maxLines: 2,
                                                                                        // textAlign: TextAlign.left,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 140,
                                                                                  ),
                                                                                  Column(
                                                                                    children: <Widget>[
                                                                                      Container(
                                                                                        alignment: Alignment.centerRight,
                                                                                        padding: EdgeInsets.only(left: 0, top: 15),
                                                                                        // child: Padding(
                                                                                        //  padding: const EdgeInsets.only(
                                                                                        //      right: 12, top: 9, left: 9),
                                                                                        child: Container(
                                                                                          //  padding: const EdgeInsets.only(right: 5),

                                                                                          child: Row(
                                                                                              textDirection: ui.TextDirection.rtl,
                                                                                              mainAxisAlignment: MainAxisAlignment.end, //change here don't //worked
                                                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                                                              children: [
                                                                                                Padding(
                                                                                                  padding: const EdgeInsets.only(left: 0, bottom: 6),
                                                                                                  child: Image.asset(
                                                                                                    "assets/icons/family.png",
                                                                                                    width: 15,
                                                                                                    height: 15,
                                                                                                    color: Color.fromARGB(139, 46, 41, 95),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  width: 4,
                                                                                                ),
                                                                                                Text(
                                                                                                  style: GoogleFonts.poppins(
                                                                                                    fontSize: 16,
                                                                                                    color: Color.fromARGB(139, 46, 41, 95),
                                                                                                  ),
                                                                                                  "حالة الطلب",
                                                                                                  maxLines: 2,
                                                                                                  textAlign: TextAlign.right,
                                                                                                ),
                                                                                              ]),
                                                                                        ),
                                                                                      ),
                                                                                      // ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  showModalBottomSheet(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return Container(
                                                                          height:
                                                                              200.0,
                                                                          color:
                                                                              Colors.white,
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: <Widget>[
                                                                              CupertinoButton(
                                                                                child: Text(
                                                                                  "إلغاء",
                                                                                  style: GoogleFonts.poppins(
                                                                                    fontSize: 17,
                                                                                    color: Color(0xffA7A7A7),
                                                                                  ),
                                                                                ),
                                                                                onPressed: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                              ),
                                                                              Expanded(
                                                                                child: CupertinoPicker(
                                                                                  scrollController: scrollController,
                                                                                  looping: false,
                                                                                  itemExtent: 64,
                                                                                  backgroundColor: Colors.white,
                                                                                  onSelectedItemChanged: (index) {
                                                                                    print(index);
                                                                                    setState(() {
                                                                                      Index = index;
                                                                                      print("[[[[[[[[[[[[[[[[[[[[[[[object]]]]]]]]]]]]]]]]]]]]]]]");
                                                                                      print(Index);

                                                                                      final item = Reason[Index];
                                                                                      Index = index;
                                                                                      print(item);
                                                                                      controller.text = item;
                                                                                      controller..text = item;
                                                                                      value = item;
                                                                                      if (Reason[Index] == "أخرى") {
                                                                                        setState(() {
                                                                                          Other = true;
                                                                                        });
                                                                                      } else {
                                                                                        setState(() {
                                                                                          Other = false;
                                                                                        });
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                  children: Reason.map((item) => Center(
                                                                                          child: Text(
                                                                                        item,
                                                                                        style: TextStyle(fontSize: 20),
                                                                                      ))).toList(),
                                                                                ),
                                                                              ),
                                                                              CupertinoButton(
                                                                                child: Text("موافق",
                                                                                    style: GoogleFonts.poppins(
                                                                                      fontSize: 17,
                                                                                      color: Color.fromARGB(139, 46, 41, 95),
                                                                                    )),
                                                                                onPressed: () {
                                                                                  // isshowadd = false;

                                                                                  scrollController = FixedExtentScrollController(initialItem: _changedNumber);
                                                                                  //scrollController.dispose();
                                                                                  setState(() {
                                                                                    _selectedNumber = _changedNumber;
                                                                                  });

                                                                                  Navigator.pop(context);
                                                                                  /*  parentx.UpdateParent(
                                              widget.documentId,
                                              "RelativeRelation",
                                              value);*/
                                                                                },
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      });
                                                                },
                                                              ),
                                                            ]),
                                                      ),

                                                      ///

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
                                                                          print(
                                                                              "kkkkkkkkkkkkkkkkkkkkkkk");
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
                                                                              "إضافة ملاحظه",
                                                                          labelStyle: TextStyle(
                                                                              color: Color(0xFF2E295F),
                                                                              fontSize: 14),
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
                                                                        /*  validator:
                                                                            (String?
                                                                                value) {
                                                                          print(
                                                                              value);
                                                                          if (value ==
                                                                              "") {
                                                                            print("444444444444444");
                                                                            setState(() {
                                                                              onError = true;
                                                                            });
                                                                            return null;
                                                                          }

                                                                          if (value !=
                                                                              null) {
                                                                            print("sssssssssssss");
                                                                            setState(() {
                                                                              onError = false;
                                                                            });
                                                                            return null;
                                                                          }
                                                                          return null;
                                                                        },









                                                                        */
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
                                                                .fromSTEB(16, 4,
                                                                    16, 16),
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
                                                        height: 90,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
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
              Navigator.of(context).push(
                  CupertinoPageRoute(builder: (context) => ListReqAdmin()));
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
        TTitle.add(document["Title"]);
        Content.add(document["Content"]);
        RUrl.add(document["Url"]);
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
}
