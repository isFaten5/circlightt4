import 'package:circlight/Pages/Admin.dart';
import 'package:circlight/Pages/Requests.dart';
import 'package:circlight/Pages/Student.dart';
import 'package:circlight/flutter_flow/flutter_flow_icon_button.dart';

import 'package:flutter/cupertino.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home_page/home_page_widget.dart';
import 'CreateDelegator.dart';
import 'Nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:circlight/Pages/Parent.dart';

import 'package:circlight/Pages/Nav.dart';
import 'package:flutter/cupertino.dart';

class DelegatorPending extends StatefulWidget {
  var SName;
  DelegatorPending({
    super.key,
    this.SName,
  });

  @override
  State<DelegatorPending> createState() => _DelegatorPending();
}

class _DelegatorPending extends State<DelegatorPending>
    with TickerProviderStateMixin {
  List<String> StudentName = [];
  List<String> StudentName2 = [];
  List<String> StudentName4 = [];
  List<String> docPname = [];
  List<String> ParentName = [];

  List<String> ParentName2 = [];
  List<bool> IsSwitch = [];
  bool IsSwitched = false;
  var IsIDExists = false;
  int count = 0;
  bool ispending = false;
  List<String> ParentID = [];
  List<String> ParentID2 = [];
  Future ParentName3() async {
    await FirebaseFirestore.instance.collection("Requests").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            // print(document["Email"]);

            docPname[count] = document["DelegatorName"];
            count += 1;
          }),
        );
  }

  CollectionReference Parentt = FirebaseFirestore.instance.collection('Parent');
  CollectionReference request =
      FirebaseFirestore.instance.collection('Student');
  Future Fill() async {
    //var count = 0;
    //   print("99999999999999999999999999999999999");
    await FirebaseFirestore.instance.collection("Requests").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            // print(document["Email"]);
            // print("[[[[[[[[[[[[[[[[[[[[[[[[object]]]]]]]]]]]]]]]]]]]]]]]]");
            var bol;
            if (document["IsActive"] == "true" &&
                document["isAccepted"] == "true") {
              bol = true;
              IsSwitch.add(bol);
            } else if (document["IsActive"] == "false" &&
                document["isAccepted"] == "true") {
              bol = false;
              IsSwitch.add(bol);
            }

            //   print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");

            //  count += 1;
          }),
        );
  }

  CollectionReference reques =
      FirebaseFirestore.instance.collection('Requests');
  CheckForStudent(SID) {
    var ID;
    var bol = true;
    List<String> IsActive = [];
    reques.get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            if (document["StudentID"] == SID) {
              if (document["IsActive"] == "true") {
                IsActive.add(document["IsActive"]);
              }
            }
            if (IsActive.isNotEmpty) {
              IsIDExists = true;
              bol = false;
              print("IsIDExistsis truuuuuuuuuuuuuuueeeeeeeee");
            }
          }),
        );

    if (bol) {
      print("IsIDExistsis falseeeee");
      IsIDExists = false;
    }
  }

  int SnapCount = 0;
  Student Studentx = new Student(
    Name: "",
    Class: "",
    SNationalID: "",
    SNationality: "",
    SUserName: "",
    SBloodType: "",
  );
  bool ShowRequest = false;
  bool isNull = true;
  String CurID = "";
  String RID = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _ColorAnimationController;
  late AnimationController _TextAnimationController;
  late Animation _colorTween, _iconColorTween, _icon2ColorTween;
  late Animation<Offset> _transTween;
  CollectionReference ColStudent =
      FirebaseFirestore.instance.collection('Student');

  var SID;
  Request Req = new Request(
      DName: "", Dusername: "", isAccepted: "Waiting", isActive: "", SID: "");

  var CurrentID;
  var SCount = 0;
  String Name = "";
  @override
  void initState() {
    _ColorAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(_ColorAnimationController);
    _iconColorTween = ColorTween(begin: Colors.grey, end: Colors.white)
        .animate(_ColorAnimationController);
    _icon2ColorTween =
        ColorTween(begin: Colors.white, end: const Color(0xff42c98d))
            .animate(_ColorAnimationController);

    _TextAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));

    _transTween = Tween(begin: Offset(-10, 40), end: Offset(-10, 0))
        .animate(_TextAnimationController);

    super.initState();
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _ColorAnimationController.animateTo(scrollInfo.metrics.pixels / 350);

      _TextAnimationController.animateTo(
          (scrollInfo.metrics.pixels - 350) / 50);
      return true;
    }

    return false;
  }

  int CountStudent = -1;
  Parent parentx = new Parent(
      Name: "",
      Email: "",
      PUserName: "",
      PNationalID: "",
      PJobTitle: "",
      PPhoneNumber: "",
      PAltPhoneNumber: "",
      PNationality: "",
      PRelativeRelation: "");

  @override
  Widget build(BuildContext context) {
    ParentName3();
    Fill();
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: NotificationListener<ScrollNotification>(
          onNotification: _scrollListener,
          child: Container(
            height: double.infinity,
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 10, 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 180,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),

                          /*Container(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 20, left: 0, right: 0, bottom: 10),
                              child: Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: 2, top: 0, left: 80, bottom: 0),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 0, left: 20, right: 20),
                                      child: TextField(
                                        textAlign: TextAlign.right,
                                        decoration: InputDecoration(
                                            hintText: "..بحث",
                                            hintStyle: TextStyle(
                                                color: Colors.grey.shade600),
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: Colors.grey.shade600,
                                              size: 20,
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey.shade100,
                                            contentPadding: EdgeInsets.all(8),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.grey.shade100)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.grey.shade100))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),*/
                        ],
                      ),
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 40,
                            ),
                            Align(
                              alignment: Alignment(0.91, 0),
                              child: Text(
                                "الطلاب",
                                textAlign: TextAlign.left,
                                style: FlutterFlowTheme.of(context)
                                    .title2
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("Requests")
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  final snap = snapshot.data!.docs;

                                  return FutureBuilder(
                                    future: Future.wait([
                                      Admin().getAdminID(),
                                      Admin().ParentListView(),
                                      GetNames2(snap)
                                    ]),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          primary: false,
                                          itemCount: snap.length,
                                          itemBuilder: (context, index) {
                                            //dynamic v = docIDS[index];

                                            //   print("CountStudent");
                                            //   print(CountStudent);
                                            /* if (CountStudent < SnapCount) {
                                              CountStudent += 1;
                                            }*/

                                            // SCount += 1;
                                            // RID = snap[index].reference.id;
                                            ShowRequest = false;
                                            print(
                                                "aaaaaaaaaaaaaaaaaaaaaaaaaaa");
                                            var Co = index;
                                            print(Co);
                                            if (snap[index]
                                                        ["DelegatorActive"] ==
                                                    "true" &&
                                                snap[index]["isAccepted"] ==
                                                    "true" &&
                                                snap[index]["IsActive"] ==
                                                    "true") {
                                              ShowRequest = true;
                                              IsSwitched = true;
                                            } else if (snap[index]
                                                        ["DelegatorActive"] ==
                                                    "false" &&
                                                snap[index]["isAccepted"] ==
                                                    "true" &&
                                                snap[index]["IsActive"] ==
                                                    "true") {
                                              IsSwitched = false;
                                              ShowRequest = true;
                                            } else {
                                              ShowRequest = false;
                                            }
                                            return ShowRequest
                                                ? Container(
                                                    height: 70,
                                                    width: double.infinity,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 1),
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.black12),
                                                      ),
                                                    ),
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: Container(
                                                            width: 4,
                                                            height: 90,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 17,
                                                                    top: 10,
                                                                    bottom: 10),
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              color: const Color(
                                                                  0xff0da6c2),
                                                              //color:
                                                              // Color(0xffD6D6D6),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                            ),
                                                          ),
                                                        ),
                                                        //to only show the allowed people to admin
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.78, -0.59),
                                                          child: Text(
                                                            " الطالب " +
                                                                " " +
                                                                // snap[index][
                                                                StudentName4[
                                                                    index],
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 15,
                                                              color: const Color(
                                                                  0xff0da6c2),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.77, 0.49),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        4,
                                                                        0,
                                                                        0),
                                                            child: Text(
                                                              'ولي الأمر' +
                                                                  " " +
                                                                  ParentName2[
                                                                      index],
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        144,
                                                                        143,
                                                                        143),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 69,
                                                        ),

                                                        //container for button

                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          //mainAxisSize:
                                                          // MainAxisSize.max,

                                                          /* mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,*/

                                                          children: <Widget>[
                                                            //Here
                                                            new Switch(
                                                              value: IsSwitched,
                                                              onChanged:
                                                                  (value) {
                                                                RID = snap[
                                                                        index]
                                                                    .reference
                                                                    .id;
                                                                ;
                                                                print(
                                                                    "&&&&&&&&&&&&&&&&&&&&&");
                                                                print(value);
                                                                IsSwitched =
                                                                    value;
                                                                print(
                                                                    "object33333333333333333333333333333333");

                                                                if (value) {
                                                                  print(
                                                                      "+++++++++++++++");
                                                                  print(value);
                                                                  setState(() {
                                                                    Req.UpdateRequest(
                                                                        RID,
                                                                        "DelegatorActive",
                                                                        "true");
                                                                  });

                                                                  //     CountSwitch);
                                                                } else {
                                                                  Req.UpdateRequest(
                                                                      RID,
                                                                      "DelegatorActive",
                                                                      "false");
                                                                }
                                                              },
                                                              activeTrackColor:
                                                                  Colors
                                                                      .lightGreenAccent,
                                                              activeColor:
                                                                  Colors.green,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Text("");
                                          },
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ); /////////////
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment(0.91, -0.70),
                        child: Text(
                          " الطلبات الموقفة مؤقتًا من قبل ولي الأمر", /////المعلقه
                          textAlign: TextAlign.left,
                          style: FlutterFlowTheme.of(context).title2.override(
                                fontFamily: 'Outfit',
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("Requests")
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  final snap = snapshot.data!.docs;

                                  return FutureBuilder(
                                    future: Future.wait([
                                      Admin().getAdminID(),
                                      Admin().ParentListView(),
                                      GetNames(snap)
                                    ]),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          primary: false,
                                          itemCount: snap.length,
                                          itemBuilder: (context, index) {
                                            SCount += 1;
                                            RID = snap[index].reference.id;

                                            if (snap[index]["IsActive"] ==
                                                    "false" &&
                                                snap[index]["isAccepted"] ==
                                                    "true") {
                                              ShowRequest = true;
                                            } else {
                                              ShowRequest = false;
                                            }

                                            ;
                                            return ShowRequest
                                                ? Container(
                                                    height: 70,
                                                    width: double.infinity,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 1),
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.black12),
                                                      ),
                                                    ),
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: Container(
                                                            width: 4,
                                                            height: 90,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 17,
                                                                    top: 10,
                                                                    bottom: 10),
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              color: const Color(
                                                                  0xff0da6c2),
                                                              //color:
                                                              // Color(0xffD6D6D6),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                            ),
                                                          ),
                                                        ),
                                                        //to only show the allowed people to admin
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.78, -0.59),
                                                          child: Text(
                                                            StudentName[index],
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 15,
                                                              color: const Color(
                                                                  0xff0da6c2),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.77, 0.49),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        4,
                                                                        0,
                                                                        0),
                                                            child: Text(
                                                              'ولي الأمر' +
                                                                  " " +
                                                                  ParentName[
                                                                      index],
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        144,
                                                                        143,
                                                                        143),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 69,
                                                        ),

                                                        //container for button

                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          //mainAxisSize:
                                                          // MainAxisSize.max,

                                                          /* mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,*/

                                                          children: <Widget>[
                                                            //Here

                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              child: Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.63,
                                                                        -0.16),
                                                                child:
                                                                    Container(
                                                                  width: 50.7,
                                                                  height: 22,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.2),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              0.2),
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                      ' متوقف',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Colors.grey)),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Text("");
                                          },
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ); /////////////
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  child: AnimatedBuilder(
                    animation: _ColorAnimationController,
                    builder: (context, child) => AppBar(
                      elevation: 1.5,
                      backgroundColor: Colors.white,
                      iconTheme: IconThemeData(
                        color: _iconColorTween.value,
                      ),
                      automaticallyImplyLeading: false,
                      title: Text(
                        "قائمه المفوضين ",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: _iconColorTween.value),
                      ),
                      centerTitle: true,
                      actions: [],
                      titleSpacing: 0.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget CreateDialog2(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: const Text('تنبيه',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold)),
      content: Text("تم تعليق هذا الطالب بنجاح ",
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("موافق",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 24, 197, 67),
                ))),
      ],
    );
  }

  Widget CreateDialog3(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: const Text('تنبيه',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold)),
      content: Text("سنقوم بإطلاع ولي الامر الطالب بقدرتك على استلام الطالب",
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("موافق",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 24, 197, 67),
                ))),
      ],
    );
  }

  Future GetStudentName(snap) async {
    // print("Entered!");
    int count = 0;
    String n = "lllllllllllllllllll";
    List<String> StudentID = [];

    try {
      for (var i = 0; snap[i] != null; i++) {
        SnapCount += 1;
        StudentID.add(snap[i]["StudentID"]);
      }
    } catch (error) {
      //   print("error");
    }
    // print("SnapppppppppppppppppppppppppppppppCount");
    // print(SnapCount);
    for (var j = 0; j < StudentID.length; j++) {
      //    print("object");
      //   print(StudentID[j]);
      await ColStudent.doc(StudentID[j]).get().then((value) {
        count = 1;
        // print(value["Name"]);

        StudentName.add(value["Name"]);
      });
    }

    // print(StudentName[0]);
  }

  Future GetNames2(snap) async {
    List<String> StudentID = [];

    try {
      for (var i = 0; snap[i] != null; i++) {
        SnapCount += 1;
        StudentID.add(snap[i]["StudentID"]);
        print("000000000000000000000000");
        print("000000000000000000000000");
        print(snap[i]["StudentID"]);
        print("000000000000000000000000");
        print("000000000000000000000000");
      }
    } catch (error) {
      //   print("error");
    }
    print("SnapppppppppppppppppppppppppppppppCount");
    print(SnapCount);
    for (var j = 0; j < StudentID.length; j++) {
      await request.doc(StudentID[j]).get().then((value) {
        //StudentName.add(value.get('Name'));
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        //   print("StID");
        //   print(StudentID[j]);

        //  print(StudentName[0]);
        // Access your after your get the data
        count = 1;

        StudentName4.add(value["Name"]);
        ParentID2.add(value["ParentId"]);
        print(value["ParentId"]);

        //  print("Starteddd");'
        print("&&&&&&&&&&&&&&&&&&&&&&&&&");
        print("&&&&&&&&&&&&&&&&&&&&&&&&&");
        print(value["ParentId"]);
        print("&&&&&&&&&&&&&&&&&&&&&&&&&");
        print("&&&&&&&&&&&&&&&&&&&&&&&&&");
        for (var i = 0; i < StudentName4.length; i++) {
          print("*******************************************");
          print(StudentName4[i]);
        }
      });
    }
//--------------------------------
    print("........................................................");
    print(ParentID2.length);
    for (var j = 0; j < ParentID2.length; j++) {
      print(ParentID2[j]);
      await Parentt.doc(ParentID2[j]).get().then((value) {
        //StudentName.add(value.get('Name'));
        print("kfkfkkkkkkkkkkkkkfkk");
        //    print("pID");
        //   print(ParentID[j]);

        //  print(StudentName[0]);
        // Access your after your get the data
        count = 1;
        print(value["Name"]);
        ParentName2.add(value["Name"]);
        print("=============================================");
        print(value["Name"]);
        print("Starteddd");
      });
    }

    // print(StudentName[0]);
  }

  Future GetNames(snap) async {
    List<String> StudentID = [];

    try {
      for (var i = 0; snap[i] != null; i++) {
        SnapCount += 1;
        StudentID.add(snap[i]["StudentID"]);
        print("000000000000000000000000");
        print("000000000000000000000000");
        print(snap[i]["StudentID"]);
        print("000000000000000000000000");
        print("000000000000000000000000");
      }
    } catch (error) {
      //   print("error");
    }
    print("SnapppppppppppppppppppppppppppppppCount");
    print(SnapCount);
    for (var j = 0; j < StudentID.length; j++) {
      await request.doc(StudentID[j]).get().then((value) {
        //StudentName.add(value.get('Name'));
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        //   print("StID");
        //   print(StudentID[j]);

        //  print(StudentName[0]);
        // Access your after your get the data
        count = 1;

        StudentName.add(value["Name"]);
        ParentID.add(value["ParentId"]);
        print(value["ParentId"]);

        //  print("Starteddd");'
        print("&&&&&&&&&&&&&&&&&&&&&&&&&");
        print("&&&&&&&&&&&&&&&&&&&&&&&&&");
        print(value["ParentId"]);
        print("&&&&&&&&&&&&&&&&&&&&&&&&&");
        print("&&&&&&&&&&&&&&&&&&&&&&&&&");
        for (var i = 0; i < StudentName.length; i++) {
          print("*******************************************");
          print(StudentName[i]);
        }
      });
    }
//--------------------------------
    print("........................................................");
    print(ParentID.length);
    for (var j = 0; j < ParentID.length; j++) {
      print(ParentID[j]);
      await Parentt.doc(ParentID[j]).get().then((value) {
        //StudentName.add(value.get('Name'));
        print("kfkfkkkkkkkkkkkkkfkk");
        //    print("pID");
        //   print(ParentID[j]);

        //  print(StudentName[0]);
        // Access your after your get the data
        count = 1;
        print(value["Name"]);
        ParentName.add(value["Name"]);
        print("=============================================");
        print(value["Name"]);
        print("Starteddd");
      });
    }

    // print(StudentName[0]);
  }

  Future GetStudentName2(snap) async {
    // print("Entered!");
    int count = 0;
    //  String n = "lllllllllllllllllll";
    List<String> StudentID2 = [];

    try {
      for (var i = 0; snap[i] != null; i++) {
        SnapCount += 1;
        StudentID2.add(snap[i]["StudentID"]);
      }
    } catch (error) {
      //   print("error");
    }
    // print("SnapppppppppppppppppppppppppppppppCount");
    // print(SnapCount);
    for (var j = 0; j < StudentID2.length; j++) {
      //   print("object");
      //   print(StudentID2[j]);
      await ColStudent.doc(StudentID2[j]).get().then((value) {
        //StudentName.add(value.get('Name'));
        //  print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        // print("StID");
        // print(StudentID[j]);
        // print("3333333333333333333333");
        //  print(StudentName[0]);
        // Access your after your get the data
        count = 1;

        StudentName2.add(value["Name"]);
      });
    }
  }

  Widget CreateDialog33(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: const Text("!تنبيه",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold)),
      content: const Text('هذا الطالب تم التفعيل ',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("موافق",
                style: TextStyle(
                    color: Color.fromARGB(255, 197, 24, 24),
                    fontWeight: FontWeight.bold))),
      ],
    );
  }
}
