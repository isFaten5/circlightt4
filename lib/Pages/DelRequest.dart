import 'package:circlight/Pages/ListDelegator.dart';
import 'package:circlight/Pages/ListRequest.dart';
import 'package:circlight/Pages/Nav.dart';
import 'package:circlight/Pages/NavParent.dart';
import 'package:circlight/Pages/RequestParent.dart';
import 'package:circlight/Pages/Requests.dart';
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

class DelRequest extends StatefulWidget {
  const DelRequest({Key? key}) : super(key: key);

  @override
  _DelRequest createState() => _DelRequest();
}

class _DelRequest extends State<DelRequest> {
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
  Request Req = new Request(
      DName: "",
      Dusername: "",
      isAccepted: "Waiting",
      isActive: "false",
      SID: "");
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
  var ErrorColor = true;
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
  var ParentId = "G2tniHX0FfIB7dQWV616";
  var showError = false;
  TextEditingController DelegatortName = TextEditingController();

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
  TextEditingController Delegatorsername = TextEditingController();
  var delName = null;
  var delUserName = null;
  var stUserName = null;
  var CC = 0;
  final Reason = ["-", "غياب", "ظرف صحي", "أخرى"];
  int _changedNumber = 0;
  var StName;
  int _selectedNumber = 1;
  List<String> DelegatorList = [];
  TextEditingController _Name = TextEditingController();
  TextEditingController _NName = TextEditingController();
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

  Future GetDelegators() async {
    await FirebaseFirestore.instance.collection("Delegator").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            //DelegatorList.add(document["UserName"]);
            DelegatorList.add(document["UserName"]);
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

  final formKeyDelegator = GlobalKey<FormState>();
  final formk = GlobalKey<FormState>();
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
  final key2 = GlobalKey<ScaffoldState>();
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
    print("pppppppppppppppppppppppppppppppp");
    print(_NName);
    GetStudents();
    if (CC == 0) {
      getParentsList("G2tniHX0FfIB7dQWV616");
    }
    GetDelegators();
    CC += 1;
    String x = "";
    int m = DelegatorList.length;
    for (var i = 0; i < DelegatorList.length; i++) {
      x = DelegatorList[i];
    }
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
                            TabValue: 0,
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
                                'طلب تفويض جديد ',
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
                        key: formKeyDelegator,
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
                                        left: 20,
                                        right: 20,
                                        top: 0,
                                        bottom: 15),
                                    child: Stack(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(bottom: 0),
                                          child: Directionality(
                                            textDirection: ui.TextDirection.rtl,
                                            child: TextFormField(
                                              onChanged: (val) {
                                                ////////////////////////
                                                ///
                                                DelegatortName..text = "";
                                                formKeyDelegator.currentState
                                                    ?.validate();

                                                for (var i = 0;
                                                    i < DelegatorList.length;
                                                    i++) {
                                                  if (val == DelegatorList[i]) {
                                                    /* print("the delegator exsits");
                                            print(DelegatorList[i]);
                                            print(val);*/
                                                    setState(() {
                                                      isWrong = true;
                                                      isCorrect = true;
                                                    });

                                                    formKeyDelegator
                                                        .currentState
                                                        ?.validate();
                                                    /*  print("isWrong:");
                                            print(isWrong);
                                            print("isCorrect:");
                                            print(isCorrect);*/
                                                    break;
                                                  } else {
                                                    ///print("Heeree");
                                                    setState(() {
                                                      isWrong = false;
                                                      isCorrect = true;
                                                    });
                                                  }
                                                }

                                                if (isWrong) {
                                                  // print("ssssssssssssssssssssssss");
                                                  // print(Delegatorsername.text);
                                                  FirebaseFirestore.instance
                                                      .collection("Delegator")
                                                      .get()
                                                      .then((snapshot) =>
                                                          snapshot.docs.forEach(
                                                              (document) {
                                                            if (Delegatorsername
                                                                    .text ==
                                                                document[
                                                                    "UserName"]) {
                                                              DelegatortName
                                                                ..text =
                                                                    document[
                                                                        "Name"];
                                                              // print(
                                                              //     "++++++++++++++++++++++++++++++++++");
                                                              // print(str);
                                                            }
                                                          }));
                                                }
                                              },
                                              controller: Delegatorsername,
                                              //  controller: parentUserName..text = parentx.PUserName,
                                              //to take text from user input
                                              textAlign: TextAlign.right,

                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  //fontWeight: FontWeight.w600,
                                                  color: Colors.grey),
                                              showCursor: true,
                                              cursorColor: Color.fromARGB(
                                                  139, 46, 41, 95),

                                              decoration: InputDecoration(
                                                prefixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 28),
                                                  child: Icon(
                                                    Icons.person,
                                                    color: Color.fromARGB(
                                                        139, 46, 41, 95),
                                                    size: 20,
                                                  ),
                                                ),
                                                alignLabelWithHint: true,
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.never,
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        30, 5, 10, 5),
                                                labelText:
                                                    'اسم المستخدم للمفوض ',
                                                labelStyle: TextStyle(
                                                    color: Color(0xFF2E295F),
                                                    fontSize: 14),
                                                hintText:
                                                    'أدخل اسم المستخدم للمفوض ',
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
                                                suffixIcon: isCorrect
                                                    ? Align(
                                                        widthFactor: 1.0,
                                                        heightFactor: 1.0,
                                                        child: isWrong
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

                                              validator: (value) {
                                                if (value!.isEmpty)
                                                  return "أرجو منك تعبئه الحقل الفارغ ";
                                                else if (isWrong == false) {
                                                  return " اسم المستخدم للمفوض غير صحيح";
                                                } else {}
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                    Form(
                      key: formk,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 0, bottom: 0),
                            child: Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 0),
                                  child: Directionality(
                                    textDirection: ui.TextDirection.rtl,
                                    child: TextFormField(
                                      onChanged: (val) {
                                        ////////////////////////
                                        ///
                                        DelegatortName..text = "";
                                        formKeyDelegator.currentState
                                            ?.validate();

                                        for (var i = 0;
                                            i < DelegatorList.length;
                                            i++) {
                                          if (val == DelegatorList[i]) {
                                            /* print("the delegator exsits");
                                            print(DelegatorList[i]);
                                            print(val);*/
                                            setState(() {
                                              isWrong = true;
                                              isCorrect = true;
                                            });

                                            formKeyDelegator.currentState
                                                ?.validate();
                                            /*  print("isWrong:");
                                            print(isWrong);
                                            print("isCorrect:");
                                            print(isCorrect);*/
                                            break;
                                          } else {
                                            ///print("Heeree");
                                            setState(() {
                                              isWrong = false;
                                              isCorrect = true;
                                            });
                                          }
                                        }

                                        if (isWrong) {
                                          // print("ssssssssssssssssssssssss");
                                          // print(Delegatorsername.text);
                                          FirebaseFirestore.instance
                                              .collection("Delegator")
                                              .get()
                                              .then((snapshot) => snapshot.docs
                                                      .forEach((document) {
                                                    if (Delegatorsername.text ==
                                                        document["UserName"]) {
                                                      DelegatortName
                                                        ..text =
                                                            document["Name"];
                                                      // print(
                                                      //     "++++++++++++++++++++++++++++++++++");
                                                      // print(str);
                                                    }
                                                  }));
                                        }
                                      },

                                      controller:
                                          DelegatortName, //..text = parentx.Name,
                                      readOnly: true,
                                      //  controller: parentUserName..text = parentx.PUserName,
                                      //to take text from user input
                                      textAlign: TextAlign.right,

                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          //fontWeight: FontWeight.w600,
                                          color: Colors.grey),
                                      showCursor: true,
                                      cursorColor:
                                          Color.fromARGB(139, 46, 41, 95),

                                      decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 28),
                                          child: Icon(
                                            Icons.title,
                                            color:
                                                Color.fromARGB(139, 46, 41, 95),
                                            size: 20,
                                          ),
                                        ),
                                        alignLabelWithHint: true,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(30, 5, 10, 5),
                                        labelText: 'اسم للمفوض ',
                                        labelStyle: TextStyle(
                                            color: Color(0xFF2E295F),
                                            fontSize: 14),
                                        hintText: 'أدخل اسم للمفوض ',
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade400,
                                            fontSize: 14),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromARGB(139, 46, 41, 95),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          borderSide: BorderSide(
                                            color: Color(0xFF2E295F),
                                            width: 0.5,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromARGB(139, 46, 41, 95),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),

                                      validator: (value) {
                                        if (value!.isEmpty)
                                          return "أرجو منك تعبئه الحقل الفارغ ";
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
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
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 18, right: 18, bottom: 0),
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
                                                                      if (!ChoosenNames
                                                                          .isEmpty) {
                                                                        setState(
                                                                            () {
                                                                          ErrorColor =
                                                                              true;
                                                                          showError =
                                                                              false;
                                                                        });
                                                                      }
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
                                      if (ChoosenNames.isNotEmpty) {
                                        setState(() {
                                          ErrorColor = true;
                                          showError = false;
                                        });
                                      }
                                    },
                                    child: Container(
                                      child: Row(
                                        children: <Widget>[
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
                                          color: ErrorColor
                                              ? Color.fromARGB(139, 46, 41, 95)
                                              : Color.fromARGB(
                                                  255, 221, 62, 51),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(18)),
                                      ),
                                    ),
                                  ),
                                ),
                                showError
                                    ? Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            243, 5, 0, 5),
                                        child: Text(
                                          "أرجو منك تعبئه الحقل الفارغ ",
                                          textAlign: TextAlign.right,
                                          style: FlutterFlowTheme.of(context)
                                              .subtitle2
                                              .override(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w100,
                                                fontFamily: 'Outfit',
                                                color: Color.fromARGB(
                                                    255, 221, 62, 51),
                                              ),
                                        ))
                                    : Text(""),
                                ////
                                ///
                                ///
                                ///
                                ///
                              ],
                            ),

                            // Padding(padding: padding)

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
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(22, 4, 22, 16),
                      child: FFButtonWidget(
                        onPressed: () async {
                          formk.currentState!.validate();
                          formKeyDelegator.currentState != null;
                          formk.currentState != null;
                          setState(() {
                            if (ChoosenNames.isEmpty) {
                              showError = true;
                              ErrorColor = false;
                            }
                          });
                          formKeyDelegator.currentState!.validate();
                          if (formk.currentState!.validate() &&
                              formk.currentState != null &&
                              formKeyDelegator.currentState != null &&
                              formKeyDelegator.currentState!.validate() &&
                              ErrorColor) {
                            showCupertinoDialog(
                                context: context, builder: CreateDialog3);
                            await FirebaseFirestore.instance
                                .collection("Student")
                                .get()
                                .then(
                                  (snapshot) =>
                                      snapshot.docs.forEach((document) async {
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
                                          SIDArray.add(document.reference.id);
                                          NamesArray.add(document['Name']);
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
                            var Countt = NamesArray.length;
                            if (NamesArray.length == 1) {
                              DelegationNames = "لطالب ";
                              for (var A in NamesArray) {
                                DelegationNames += A + "  ";
                              }
                            } else {
                              DelegationNames = "لطلاب  ";
                              for (var A in NamesArray) {
                                if (Countt != 1) {
                                  DelegationNames += A + " و ";
                                  Countt -= 1;
                                } else {
                                  DelegationNames += A + " ";
                                }
                              }
                            }
                          } else {}
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
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
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
      title: const Text(' طلب تفويض',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold)),
      content: Text(
          'هل انت متأكد انك تريد تفويض' +
              " " +
              DelegatortName.text +
              " " +
              DelegationNames,
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              DateTime today = DateTime.now();
              String dateStr =
                  "${today.year}-${today.month}-${today.day} ${today.hour}:${today.minute}";
              // print(dateStr);
              for (var i = 0;
                  i < NamesArray.length && i < SIDArray.length;
                  i++) {
                Req.AddRequest(DelegatortName.text, Delegatorsername.text,
                    "Waiting", "false", SIDArray[i], "true", dateStr, ParentId);
              }

              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => ListDelegator()));
              //parentx.DeleteParent(CurrentID);
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
