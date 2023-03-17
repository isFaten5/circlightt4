import 'package:circlight/Pages/ListRequest.dart';
import 'package:circlight/Pages/Nav.dart';
import 'package:circlight/Pages/NavParent.dart';
import 'package:circlight/Pages/RequestParent.dart';
import 'package:circlight/Pages/Student.dart';
import 'package:circlight/Pages/constants.dart';

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../storage_service.dart';
import 'AdminPRequest.dart';

class ParentReqq extends StatefulWidget {
  const ParentReqq({Key? key}) : super(key: key);

  @override
  _ParentReq createState() => _ParentReq();
}

class _ParentReq extends State<ParentReqq> {
  TextEditingController? emailAddressController1;
  TextEditingController? emailAddressController2;
  TextEditingController? emailAddressController3;
  TextEditingController StudentName = TextEditingController();
  TextEditingController OtherController = TextEditingController();
  TextEditingController _Type = TextEditingController();
  TextEditingController Content = TextEditingController();
  final _unfocusNode = FocusNode();
  final firebase_storage.FirebaseStorage storage2 =
      firebase_storage.FirebaseStorage.instance;
  List<String> listStudentName = [];
  List<String> listStudentId = [];
  List<String> NamesArray = [];
  bool isSTWrong = false;
  bool isSTCorrect = false;
  Student Studentx = new Student(
    Name: "",
    Class: "",
    SNationalID: "",
    SNationality: "",
    SUserName: "",
    SBloodType: "",
  );
  var ChoosenNames = [];
  var fileName;
  var path;
  bool isWrong = false;
  List<String> SIDArray = [];
  String DelegationNames = "";
  bool isCorrect = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _Name2 = TextEditingController();
  TextEditingController StudentUsername = TextEditingController();
  TextEditingController _Title = TextEditingController();
  late TextEditingController controller;
  var Url;
  bool Other = false;
  bool onError = false;
  var Type2;
  bool showFile = false;
  int Index = 0;
  var STID = "";
  late FixedExtentScrollController scrollController;
  late String value = "-";
  //var ParentID = firebaseAuth.currentUser.uid;
  // var ParentID = FirebaseAuth.instance.currentUser!.uid;
  var ParentID = "G2tniHX0FfIB7dQWV616";
  var FileNa = "";
  var StratIndex;
  var CC = 0;
  final Reason = ["-", "غياب", "ظرف صحي", "أخرى"];
  int _changedNumber = 0;
  var StName;
  int _selectedNumber = 1;
  TextEditingController _Name = TextEditingController();
  var FileName = [];
  List<String> UsernameList = [];
  Future GetStudents() async {
    await FirebaseFirestore.instance.collection("Student").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            //DelegatorList.add(document["UserName"]);
            UsernameList.add(document["UserName"]);
          }),
        );
  }

  final Storage storage = Storage();
  var AdminID = "nXEWTcyL1hhilCZGWhO6rEmVGFt1";
  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: Reason[Index]);
    scrollController = FixedExtentScrollController(initialItem: Index);
    emailAddressController1 = TextEditingController();
    emailAddressController2 = TextEditingController();

    emailAddressController3 = TextEditingController();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    emailAddressController1?.dispose();
    emailAddressController2?.dispose();
    emailAddressController3?.dispose();
    super.dispose();
  }

  var PID = "G2tniHX0FfIB7dQWV616";
  final _key = GlobalKey<FormState>();
  RequestParent ReqParent2 = new RequestParent(
      Type: "", Content: "", Date: "", ParentID: "", Title: "", Status: "");
  Future getParentsList(PID) async {
    listStudentName.clear();

    await FirebaseFirestore.instance.collection("Student").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            if (document["ParentId"] == PID) {
              // print(document.reference.id);
              // print("parentids are${listParentId}");
              // print("pppppppppppppppppppppppp");
              // print(document["Name"]);
              listStudentName.add(document["Name"]);
            }
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    GetStudents();
    if (CC == 0) {
      getParentsList("G2tniHX0FfIB7dQWV616");
    }
    CC += 1;

    print("&YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY");
    print(ParentID);
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        // backgroundColor: Color(0x44000000),
        title: Text(
          "",
          textAlign: TextAlign.start,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => NavParent(
                            TabValue: 17,
                          )));
            },
            icon: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.white,
            ),
            color: Color.fromARGB(255, 202, 21, 21),
          ),
        ],
      ),
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 210,
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/formbackground.png',
                            width: double.infinity,
                            height: 230,
                            fit: BoxFit.cover,
                          ),
                          Align(
                            alignment: AlignmentDirectional(-0.06, 0.74),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                              child: Text(
                                'إنشاء طلب ',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText2
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 22,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.86, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                            child: Text(
                              ' ',
                              style: FlutterFlowTheme.of(context).bodyText2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Form(
                      key: _key,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 0, bottom: 0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(bottom: 20),
                                        child: Directionality(
                                            textDirection: ui.TextDirection.rtl,
                                            child: TextFormField(
                                              controller: _Name,
                                              onChanged: (value) {
                                                setState(() {
                                                  onError = false;
                                                });
                                              },
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      139, 46, 41, 95),
                                                  fontSize: 14),
                                              decoration: InputDecoration(
                                                prefixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 28),
                                                  child: Icon(
                                                    Icons.title,
                                                    color: Color.fromARGB(
                                                        139, 46, 41, 95),
                                                    size: 22,
                                                  ),
                                                ),
                                                alignLabelWithHint: true,
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.never,
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        30, 5, 10, 5),
                                                labelText: 'عنوان الطلب',
                                                labelStyle: TextStyle(
                                                    color: Color(0xFF2E295F),
                                                    fontSize: 14),
                                                hintText: 'أدخل عنوان الطلب',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey.shade400,
                                                    fontSize: 14),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        139, 46, 41, 95),
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  borderSide: BorderSide(
                                                    color: Color(0xFF2E295F),
                                                    width: 0.5,
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        139, 46, 41, 95),
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                              ),
                                              validator: (String? value) {
                                                if (value == "") {
                                                  setState(() {
                                                    onError = true;
                                                  });
                                                  return null;
                                                }

                                                if (value != null) {
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
                                                  textAlign: TextAlign.right,
                                                  "أرجو منك تعبئه الحقل الفارغ ",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.red)))
                                          : Positioned(
                                              bottom: 0,
                                              right: 1,
                                              child: Text(
                                                textAlign: TextAlign.right,
                                                " ",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color.fromARGB(
                                                      255, 86, 244, 54),
                                                ),
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                                ///////////
                                ///
                                ///
                                ///
                                ///

                                ////////
                                ///
                                ///
                                ///
                                /*Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 0, 0),
                                  child: InkWell(
                                    onTap: () async {},
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.96,
                                      height: 350,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: Image.asset(
                                            'assets/images/upload.png',
                                          ).image,
                                        ),
                               /         boxShadow: [
                                          BoxShadow(
                                            blurRadius: 6,
                                            color: Color(0x3A000000),
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),*/
                                /*    Container(
                                    width: 200,
                                    height: 50,
                                    child: ElevatedButton(
                                        child: Text("رفع ملف"),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontStyle: FontStyle.normal),
                                        ),
                                        onPressed: () async {
                                          final results = await FilePicker
                                              .platform
                                              .pickFiles(
                                            allowMultiple: false,
                                            type: FileType.custom,
                                            allowedExtensions: [
                                              'png',
                                              'jpg',
                                              "pdf"
                                            ],
                                          );
                                          if (results == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content:
                                                    Text('No file selected.'),
                                              ), // SnackBar
                                            );
                                            return null;
                                          }
                                          path = results.files.single.path!;
                                          fileName = results.files.single.name;
                              
                                        })),*/

                                ////
                                ///
                                ///
                                ///
                                ///
                                ///

                                ///
                                ///
                                ///
                                ///
                                ///
                                ///
                                ///
                                ///
                                ///

                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 18, right: 18, bottom: 20),
                                  child: InkWell(
                                    //height: 80,
                                    onTap: () {
                                      showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Stack(children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 5, bottom: 0, left: 10),
                                              child: InkWell(
                                                  child: Text(
                                                    "الجميع",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: const Color(
                                                            0xff0da6c2),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  //height: 80,
                                                  onTap: () {
                                                    for (var x
                                                        in listStudentName) {
                                                      ChoosenNames.add(x);
                                                    }
                                                  }),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 0),
                                              child: Container(
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        "الأبناء",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              width: 100,
                                              height: 50,
                                            ),
                                            Container(
                                              child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 20),
                                                  child: Align(
                                                    alignment:
                                                        Alignment(0.91, -1.9),
                                                    child: ListView.builder(
                                                        itemCount:
                                                            listStudentName
                                                                .length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index2) {
                                                          return Stack(
                                                            children: [
                                                              //   Text("اسم الطلاب"),

                                                              ListTile(
                                                                onTap: () {
                                                                  // await assignParentToStudent(studentId: snap[index].id, parentId: listParentId[index2]);

                                                                  // print("Executed after 5 seconds");

                                                                  setState(() {
                                                                    Studentx.Name =
                                                                        listStudentName[
                                                                            index2];
                                                                    var bol =
                                                                        true;
                                                                    for (var x
                                                                        in ChoosenNames) {
                                                                      if (x ==
                                                                          listStudentName[
                                                                              index2]) {
                                                                        bol =
                                                                            false;
                                                                        break;
                                                                      }
                                                                    }
                                                                    if (bol) {
                                                                      ChoosenNames.add(
                                                                          listStudentName[
                                                                              index2]);
                                                                    }

                                                                    print(
                                                                        "aaaaaaaaaaaaaaaa");
                                                                    print(listStudentName[
                                                                        index2]);
                                                                  });
                                                                  /* print(
                                                                "ffffffffffffffffffffffff");
                                                            print(
                                                                Studentx.Name);*/
                                                                  Navigator.pop(
                                                                      context);

                                                                  //  print(snap[index])
                                                                  //  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                },
                                                                title: Text(
                                                                  listStudentName[
                                                                      index2],
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        }),
                                                  )),
                                            ),
                                          ]);
                                        },
                                      );

                                      // int Tab = 7;
                                      // Navigator.of(context)
                                      //     .push(
                                      //         CupertinoPageRoute(
                                      //   builder:
                                      //       (context) =>
                                      //           Nav(
                                      //     documentId:
                                      //         snapshot.data![
                                      //             1][index],
                                      //     index: 1,
                                      //     Name: "",
                                      //     username: "",
                                      //     SID: "",
                                      //     TabValue: 8,
                                      //     header: false,
                                      //   ),
                                      // ));
                                    },
                                    child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Positioned(
                                              left: 0.0,
                                              child: isSTCorrect
                                                  ? Align(
                                                      widthFactor: 1.0,
                                                      heightFactor: 1.0,
                                                      child: isSTWrong
                                                          ? Icon(
                                                              Icons.check,
                                                              size: 18,
                                                              color: const Color(
                                                                  0xff42c98d),
                                                            )
                                                          : Icon(
                                                              Icons.close,
                                                              size: 18,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      225,
                                                                      80,
                                                                      61),
                                                            ),
                                                    )
                                                  : Text(""),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                left: 2,
                                              ),
                                              child: Row(children: [
                                                Container(
                                                  child: Center(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                            constraints:
                                                                BoxConstraints(
                                                                    maxWidth:
                                                                        600,
                                                                    minWidth:
                                                                        0),
                                                            child: Container(
                                                              child:
                                                                  SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    ...ChoosenNames.map((email) => Transform(
                                                                        transform: new Matrix4.identity()..scale(0.59),
                                                                        child: Chip(
                                                                            labelPadding: EdgeInsets.only(left: 1.9, right: 1.9),
                                                                            avatar: CircleAvatar(
                                                                              backgroundColor: Colors.white70,
                                                                              child: Text(email[0].toUpperCase()),
                                                                            ),
                                                                            label: Text(
                                                                              email,
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                            backgroundColor: Color(0xff0da6c2),
                                                                            elevation: 6.0,
                                                                            shadowColor: Colors.grey[60],
                                                                            padding: EdgeInsets.all(8.0),
                                                                            onDeleted: () {
                                                                              setState(() {
                                                                                for (var i = 0; i < ChoosenNames.length; i++) {
                                                                                  if (email == ChoosenNames[i]) {
                                                                                    ChoosenNames.removeAt(i);
                                                                                  }
                                                                                }
                                                                              });
                                                                            }))).toList(),
                                                                  ],
                                                                ),
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Container(
                                                        child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10,
                                                      right: 4,
                                                      bottom: 10),
                                                  child: RichText(
                                                    textAlign: TextAlign.right,
                                                    text: TextSpan(
                                                      children: [
                                                        /*   WidgetSpan(
                                                          child: Icon(
                                                            Icons
                                                                .arrow_drop_down_circle,
                                                            size: 22,
                                                            color:
                                                                Color.fromARGB(
                                                                    139,
                                                                    46,
                                                                    41,
                                                                    95),
                                                          ),
                                                        ),
                                                        WidgetSpan(
                                                            child: SizedBox(
                                                          width: 190,
                                                        )),*/
                                                        TextSpan(
                                                          text:
                                                              " اسم المستخدم للطالب ",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF2E295F),
                                                              fontSize: 14),
                                                        ),
                                                        WidgetSpan(
                                                          child: Icon(
                                                            Icons.person,
                                                            size: 18,
                                                            color:
                                                                Color.fromARGB(
                                                                    139,
                                                                    46,
                                                                    41,
                                                                    95),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ))),
                                              ]),
                                            ),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color:
                                              Color.fromARGB(139, 46, 41, 95),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(18)),
                                      ),
                                    ),
                                  ),
                                ),

                                ////
                                ///
                                ///
                                ///
                                ///
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(bottom: 20),
                                        child: Directionality(
                                            textDirection: ui.TextDirection.rtl,
                                            child: TextFormField(
                                              minLines: 3,
                                              maxLines: 5,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              textInputAction:
                                                  TextInputAction.next,
                                              onChanged: (value) {
                                                setState(() {
                                                  onError = false;
                                                });
                                              },
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      139, 46, 41, 95),
                                                  fontSize: 14),
                                              controller: Content,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                  top: 30.0,
                                                  bottom: 10,
                                                ),
                                                prefixIcon: Padding(
                                                  padding: const EdgeInsets.all(
                                                      defaultPadding),
                                                  child: Icon(
                                                    Icons.message,
                                                    color: Color.fromARGB(
                                                        139, 46, 41, 95),
                                                    size: 22,
                                                  ),
                                                ),
                                                alignLabelWithHint: true,
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.never,
                                                labelText: 'محتوى الطلب',
                                                labelStyle: TextStyle(
                                                    color: Color(0xFF2E295F),
                                                    fontSize: 14),
                                                hintText: 'أدخل محتوى الطلب',
                                                hintStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        139, 46, 41, 95),
                                                    fontSize: 14),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        139, 46, 41, 95),
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        139, 46, 41, 95),
                                                    width: 0.5,
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        139, 46, 41, 95),
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                              ),
                                              validator: (String? value) {
                                                if (value == "") {
                                                  setState(() {
                                                    onError = true;
                                                  });
                                                  return null;
                                                }

                                                if (value != null) {
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
                                                  textAlign: TextAlign.right,
                                                  "أرجو منك تعبئه الحقل الفارغ ",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.red)))
                                          : Positioned(
                                              bottom: 0,
                                              right: 1,
                                              child: Text(
                                                textAlign: TextAlign.right,
                                                " ",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color.fromARGB(
                                                      255, 86, 244, 54),
                                                ),
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(22, 4, 22, 5),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  final results =
                                      await FilePicker.platform.pickFiles(
                                    allowMultiple: false,
                                    type: FileType.custom,
                                    allowedExtensions: ['png', 'jpg', "pdf"],
                                  );
                                  if (results == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('No file selected.'),
                                      ), // SnackBar
                                    );
                                    return null;
                                  }
                                  path = results.files.single.path!;
                                  fileName = results.files.single.name;
                                  print(
                                      ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");

                                  FileNa = fileName;
                                  StratIndex = FileNa.length - 3;
                                  Type2 = FileNa.substring(StratIndex);
                                  print(
                                      "[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[object]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]");
                                  print(Type2);
                                  setState(() {
                                    showFile = true;
                                  });
                                  print("===============================");
                                },
                                text: ' رفع ملف',
                                icon: Icon(
                                  Icons.upload_file,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 40,
                                  color: Color.fromARGB(255, 203, 205, 206),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: Colors.white,
                                      ),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            // Padding(padding: padding)

                            showFile
                                ? Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 23, 5),
                                    child: Text(
                                      FileNa + " تم إضافة الملف ",
                                      textAlign: TextAlign.right,
                                      style: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontSize: 14,
                                            fontFamily: 'Outfit',
                                            color: Color.fromARGB(
                                                255, 102, 169, 104),
                                          ),
                                    ))
                                : Text(""),

                            /*  FutureBuilder(
                                future: storage.listFiles(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<firebase_storage.ListResult>
                                        snapshot) {
                              
                                  if (snapshot.connectionState ==
                                          ConnectionState.done &&
                                      snapshot.hasData) {
                                

                                    return Container(
                                      // padding: const EdgeInsets.symmetric(
                                      //     horizontal: 20),
                                      height: 50,
                                      color: Colors.red,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount:
                                              snapshot.data!.items.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: ElevatedButton(
                                                  onPressed: () {},
                                                  child: Text(snapshot.data!
                                                      .items[index].name)),
                                            );
                                          }),


                                    );
                                  } else if (snapshot.connectionState ==
                                          ConnectionState.waiting ||
                                      !snapshot.hasData) {
                             
                                    return Text("SS");
                                  }
                                  return SizedBox(
                                    height: 0,
                                    width: 0,
                                  );
                                })*/
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(22, 4, 22, 16),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  if (_key.currentState != null &&
                                      _key.currentState!.validate()) {
                                    showCupertinoDialog(
                                        context: context,
                                        builder: CreateDialog3);
                                    await FirebaseFirestore.instance
                                        .collection("Student")
                                        .get()
                                        .then(
                                          (snapshot) => snapshot.docs
                                              .forEach((document) async {
                                            //print(
                                            //    "this field is??????????????????????");
                                            //  print(Studentx.Name);
                                            if (PID == document["ParentId"]) {
                                              print("DDDDDDDDDDDDDDDD");
                                              print(PID);
                                              for (var v in ChoosenNames) {
                                                print(
                                                    "+++++++++++++++++++++++++++++++++++");
                                                print(v);
                                                print(ChoosenNames.length);

                                                if (document["Name"] == v) {
                                                  SIDArray.add(
                                                      document.reference.id);
                                                  NamesArray.add(
                                                      document['Name']);
                                                  /*   print(
                                                  "666666666666666666666666666");*/
                                                  StName = document['Name'];
                                                  // print("777777777777777");

                                                  //  IsIDExists = false;
                                                }
                                              }
                                            }
                                          }),
                                        );
                                    var Count = NamesArray.length;
                                    if (NamesArray.length == 1) {
                                      DelegationNames = "لطالب ";
                                      for (var A in NamesArray) {
                                        DelegationNames += A + "  ";
                                      }
                                    } else {
                                      DelegationNames = "لطلاب  ";
                                      for (var A in NamesArray) {
                                        if (Count != 1) {
                                          DelegationNames += A + " و ";
                                          Count -= 1;
                                        } else {
                                          DelegationNames += A + " ";
                                        }
                                      }
                                    }
                                  }
                                  /* Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => Nav(
                          TabValue: 0,
                          documentId: "",
                        ),
                      ));*/
                                },
                                text: 'إرسال',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 40,
                                  color: const Color(0xff0da6c2),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: Colors.white,
                                      ),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Stack(
                      children: [],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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

              var Type = value;
              if (Type == "أخرى") {
                Type = _Type.text;
              }
              storage
                  .uploadFile(path, fileName, "06YH3Ox5AvO4eUYahk54")
                  .then((value) => print("Donnne!!!!!!!!"));

              //  await Future.delayed(const Duration(microseconds: 2), () async {
              print(fileName);
              print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");

              String DownloadURL = await storage2
                  .ref("Files/06YH3Ox5AvO4eUYahk54/$fileName")
                  .getDownloadURL();
              print(DownloadURL);
//
              // print(storage.downloadURL(fileName, "06YH3Ox5AvO4eUYahk54"));
              //
              for (var i = 0;
                  i < NamesArray.length && i < SIDArray.length;
                  i++) {
                ReqParent2.AddRequestParent(
                    _Name.text,
                    "InProgress",
                    Content.text,
                    ParentID,
                    SIDArray[i],
                    dateStr,
                    "-",
                    DownloadURL,
                    Type2,
                    AdminID);
              }

              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => NavParent(
                            TabValue: 17,
                          )));
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

  Widget CreateDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: Text("تسجيل حساب",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Color.fromRGBO(31, 31, 31, 1),
              fontWeight: FontWeight.bold)),
      content: Text(
        "تم تسجبل حسابك بنجاح بإمكانك الدخول لحسابك ",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("موافق",
                style: TextStyle(
                    color: const Color(0xff57d77a),
                    fontWeight: FontWeight.bold))),
      ],
    );
  }
}
