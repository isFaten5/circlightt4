import 'package:circlight/Pages/NavParent.dart';
import 'package:circlight/Pages/ReqMissing.dart';
import 'package:circlight/Pages/Student.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:circlight/Pages/Requests.dart';

import 'CreateDelegator.dart';
import 'PreviewReqParent.dart';

class ListRequest2 extends StatefulWidget {
  const ListRequest2({Key? key}) : super(key: key);

  @override
  _ListRequest createState() => _ListRequest();
}

class _ListRequest extends State<ListRequest2> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  CollectionReference request =
      FirebaseFirestore.instance.collection('Student');
  CollectionReference Parent = FirebaseFirestore.instance.collection('Parent');
  List<String> docPname = [];
  List<String> StudentName = [];
  List<String> ParentName = [];
  List<String> ParentID = [];

  List<String> StudentName3 = [];
  List<String> StudentName4 = [];
  int CountStudent = -1;
  int SnapCount = 0;
  int ParentCount = -1;
  int count = 0;
  bool ShowRequest = false;
  String Show = "true";
  TextEditingController Namex = TextEditingController();
  CollectionReference ColStudent =
      FirebaseFirestore.instance.collection('Student');
  String ParentId = "G2tniHX0FfIB7dQWV616";
  var DelegatorActive = "";
  List<bool> IsSwitch = [];
  var CountSwitch = 0;
  var IsIDExists = false;
  List<String> DelegatorID = [];

  Request Req = new Request(
      DName: "",
      Dusername: "",
      isAccepted: "false",
      isActive: "false",
      SID: "");
  var ID;
  String Active = "";
  String Accepted = "";
  late bool IsAct = true;
  var IsSwitched;
  var status = false;
  int CountItem = 9;
  bool SShow = true;

  bool isNull = true;
  String CurID = "";
  String RID = "";
  String IDS = "";
  late AnimationController _ColorAnimationController;
  late AnimationController _TextAnimationController;
  late Animation _colorTween, _iconColorTween, _icon2ColorTween;
  late Animation<Offset> _transTween;
  CollectionReference reques =
      FirebaseFirestore.instance.collection('Requests');
  Future<bool> CheckForStudent(SID, RID) async {
    var ID;
    var bol = true;
    List<String> IsActive = [];

    reques.get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            var equal = false;

            if (RID == document.reference.id) {
              equal = false;
            } else if (RID != document.reference.id) {
              equal = true;
            }
            if (equal) {
              if (document["StudentID"] == SID) {
                if (document["IsActive"] == "true" &&
                    document["isAccepted"] == "true" &&
                    document["DelegatorActive"] == "true") {
                  IsIDExists = true;
                  bol = false;
                }
              }
            }
          }),
        );

    if (!bol) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
    // return Future.value(false);
  }

  var SID;

  var CurrentID;
  late TabController _tabController;
  var SCount = 0;
  String Name = "";
  @override
  void initState() {
    _ColorAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(_ColorAnimationController);
    _iconColorTween = ColorTween(begin: Colors.grey, end: Colors.grey)
        .animate(_ColorAnimationController);
    _icon2ColorTween =
        ColorTween(begin: Colors.white, end: const Color(0xff42c98d))
            .animate(_ColorAnimationController);

    _TextAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));

    _transTween = Tween(begin: Offset(-10, 40), end: Offset(-10, 0))
        .animate(_TextAnimationController);
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  final _selectedColor = const Color(0xff0da6c2);

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    DateTime today = DateTime.now();
    String dateStr =
        "${today.year}-${today.month}-${today.day} ${today.hour}:${today.minute}";

    return Scaffold(
      appBar: AppBar(
        elevation: 1.5,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: _iconColorTween.value,
        ),
        automaticallyImplyLeading: false,
        title: Text(
          "قائمه الطلبات ",
          textAlign: TextAlign.start,
          style: TextStyle(color: _iconColorTween.value),
        ),
        centerTitle: true,
        actions: [],
        titleSpacing: 0.0,
      ),
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(children: [
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Align(
                    // alignment: Alignment(-0.85, -0.45),
                    child: Container(
                      height: 41.0,
                      width: 41.0,
                      child: FittedBox(
                        child: FloatingActionButton(
                          onPressed: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => NavParent(
                                      TabValue: 18,
                                    )));
                          },
                          elevation: 0,
                          child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius: 6,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(90),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff0da6c2),
                                  Color(0xff0da6c2),
                                  Color(0xff0da6c2),
                                  Color(0xff0da6c2),
                                ],
                              ),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                              child: Center(
                                  child: Icon(
                                Icons.add,
                                size: 22,
                                color: Colors.white,
                              )),
                            ),
                          ),
                          backgroundColor: Color.fromARGB(0, 255, 253, 253),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 340,
                  //height: 230,
                  padding: EdgeInsets.only(right: 5, top: 0, left: 5),
                  child: Padding(
                    padding: EdgeInsets.only(right: 5, top: 0, left: 5),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          //  searchname = value;
                        });
                      },
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                          hintText: "..بحث",
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey.shade400,
                            size: 20,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(8),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300))),
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: 7,
              ),
              Row(children: [
                SizedBox(
                  width: 90,
                ),
                SizedBox(
                  width: 220,
                ),
                Align(
                  alignment: Alignment(0.91, 0.9),
                  child: Text(
                    "الطلبات الحالية",
                    textAlign: TextAlign.left,
                    style: FlutterFlowTheme.of(context).title2.override(
                          fontFamily: 'Outfit',
                          color: Color(0xFF29294D),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ]),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("RequestParent")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final snap = snapshot.data!.docs;

                    return FutureBuilder(
                      future: Future.wait([]),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Align(
                              child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            primary: false,
                            itemCount: snap.length,
                            itemBuilder: (context, index) {
                              ShowRequest = true;

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

                              result =
                                  result + str.substring(startIndex, endIndex);
                              var Stat = "";
                              print("88888888888888888888888888");
                              String PID2 = snap[index]["ParentID"];
                              if (snap[index]['Status'] == "Accepted" &&
                                  PID2 == ParentId) {
                                Stat = "مقبول";
                                ShowRequest = false;
                              } else if (snap[index]['Status'] == "rejected" &&
                                  PID2 == ParentId) {
                                Stat = "مرفوض";
                                ShowRequest = false;
                              } else if (snap[index]['Status'] == "Missing" &&
                                  PID2 == ParentId) {
                                Stat = "ناقص";
                                ShowRequest = true;
                              } else if (snap[index]['Status'] ==
                                      "InProgress" &&
                                  PID2 == ParentId) {
                                Stat = "تحت المعالجة";
                                ShowRequest = false;
                              }
                              if (snap[index]["ParentID"] != ParentId) {
                                ShowRequest = false;
                              }
                              //find substring
                              var RID = snap[index].reference.id;

                              return ShowRequest
                                  ? Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 12, 16, 0),
                                      child: Container(
                                          width: 330,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 3,
                                                color: Color(0x25000000),
                                                offset: Offset(0, 2),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              RID = snap[index].reference.id;
                                              print(
                                                  "77777777777777777777777777");
                                              print(RID);
                                              Navigator.of(context).push(
                                                  CupertinoPageRoute(
                                                      builder: (context) =>
                                                          NavParent(
                                                            TabValue: 19,
                                                            documentId: RID,
                                                          )));
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 365,
                                                  child: Stack(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(11, 4,
                                                                    4, 0),
                                                        child: Text(
                                                          snap[index]["Date"],
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Outfit',
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 7,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                1.01, 0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(8,
                                                                      8, 4, 8),
                                                          child: Container(
                                                            width: 3,
                                                            height: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFF2E295F),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.75, -0.89),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      10, 0, 0),
                                                          child: Text(
                                                            snap[index]
                                                                ['Title'],
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .title2
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: Color(
                                                                      0xFF101213),
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.81, -0.18),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      20, 0, 0),
                                                          child: Text(
                                                            result,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText2
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: Color(
                                                                      0xFF57636C),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.81, 0.74),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      9, 0, 0),
                                                          child: Text(
                                                            Stat,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: Color(
                                                                      0xFFEE8B60),
                                                                  fontSize: 9,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(7, 30,
                                                                    0, 0),
                                                        child: Icon(
                                                          Icons
                                                              .chevron_left_rounded,
                                                          color:
                                                              Color(0xFF57636C),
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    )
                                  : SizedBox(
                                      height: 0,
                                    );
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
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("RequestParent")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final snap = snapshot.data!.docs;

                    return FutureBuilder(
                      future: Future.wait([]),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Align(
                              child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            primary: false,
                            itemCount: snap.length,
                            itemBuilder: (context, index) {
                              ShowRequest = true;

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
                              String PID2 = snap[index]["ParentID"];
                              result =
                                  result + str.substring(startIndex, endIndex);
                              var Stat = "";
                              if (snap[index]['Status'] == "Accepted" &&
                                  PID2 == ParentId) {
                                Stat = "مقبول";
                                ShowRequest = false;
                              } else if (snap[index]['Status'] == "rejected" &&
                                  PID2 == ParentId) {
                                Stat = "مرفوض";
                                ShowRequest = false;
                              } else if (snap[index]['Status'] == "Missing" &&
                                  PID2 == ParentId) {
                                Stat = "ناقص";
                                ShowRequest = false;
                              } else if (snap[index]['Status'] ==
                                      "InProgress" &&
                                  PID2 == ParentId) {
                                Stat = "تحت المعالجة";
                                ShowRequest = true;
                              }
                              if (snap[index]["ParentID"] != ParentId) {
                                ShowRequest = false;
                              }
                              var RID = snap[index].reference.id;

                              return ShowRequest
                                  ? Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 12, 16, 0),
                                      child: Container(
                                          width: 330,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 3,
                                                color: Color(0x25000000),
                                                offset: Offset(0, 2),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              RID = snap[index].reference.id;
                                              print(
                                                  "77777777777777777777777777");
                                              print(RID);
                                              Navigator.of(context).push(
                                                  CupertinoPageRoute(
                                                      builder: (context) =>
                                                          NavParent(
                                                            TabValue: 1,
                                                            documentId: RID,
                                                          )));
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 365,
                                                  child: Stack(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(11, 4,
                                                                    4, 0),
                                                        child: Text(
                                                          snap[index]["Date"],
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Outfit',
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 7,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                1.01, 0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(8,
                                                                      8, 4, 8),
                                                          child: Container(
                                                            width: 3,
                                                            height: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFF2E295F),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.75, -0.89),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      10, 0, 0),
                                                          child: Text(
                                                            snap[index]
                                                                ['Title'],
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .title2
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: Color(
                                                                      0xFF101213),
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.81, -0.18),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      20, 0, 0),
                                                          child: Text(
                                                            result,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText2
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: Color(
                                                                      0xFF57636C),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.81, 0.74),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      9, 0, 0),
                                                          child: Text(
                                                            Stat,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: Color(
                                                                      0xFFEE8B60),
                                                                  fontSize: 9,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(7, 30,
                                                                    0, 0),
                                                        child: Icon(
                                                          Icons
                                                              .chevron_left_rounded,
                                                          color:
                                                              Color(0xFF57636C),
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    )
                                  : SizedBox(
                                      height: 0,
                                    );
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
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment(0.91, 0.4),
                child: Text(
                  "الطلبات السابقة",
                  textAlign: TextAlign.left,
                  style: FlutterFlowTheme.of(context).title2.override(
                        fontFamily: 'Outfit',
                        color: Color(0xFF29294D),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
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
                      future: Future.wait([]),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Align(
                              child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            primary: false,
                            itemCount: snap.length,
                            itemBuilder: (context, index) {
                              ShowRequest = true;

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
                              if (snap[index]["ParentID"] != ParentId) {
                                ShowRequest = false;
                              }

                              result =
                                  result + str.substring(startIndex, endIndex);
                              var Stat = "";
                              String PID2 = snap[index]["ParentID"];
                              if (snap[index]['Status'] == "Accepted" &&
                                  PID2 == ParentId) {
                                Stat = "مقبول";
                                ShowRequest = true;
                              } else if (snap[index]['Status'] == "rejected" &&
                                  PID2 == ParentId) {
                                Stat = "مرفوض";
                                ShowRequest = true;
                              } else if (snap[index]['Status'] == "Missing" &&
                                  PID2 == ParentId) {
                                Stat = "ناقص";
                                ShowRequest = false;
                              } else if (snap[index]['Status'] ==
                                      "InProgress" &&
                                  PID2 == ParentId) {
                                Stat = "تحت المعالجة";
                                ShowRequest = false;
                              }

                              //find substring
                              var RID = snap[index].reference.id;

                              return ShowRequest
                                  ? Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 12, 16, 0),
                                      child: Container(
                                          width: 330,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 3,
                                                color: Color(0x25000000),
                                                offset: Offset(0, 2),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              RID = snap[index].reference.id;
                                              print(
                                                  "77777777777777777777777777");
                                              print(RID);
                                              Navigator.of(context).push(
                                                  CupertinoPageRoute(
                                                      builder: (context) =>
                                                          NavParent(
                                                            TabValue: 1,
                                                            documentId: RID,
                                                          )));
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: 365,
                                                  child: Stack(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(11, 4,
                                                                    4, 0),
                                                        child: Text(
                                                          snap[index]["Date"],
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Outfit',
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 7,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                1.01, 0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(8,
                                                                      8, 4, 8),
                                                          child: Container(
                                                            width: 3,
                                                            height: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFF2E295F),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.75, -0.89),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      10, 0, 0),
                                                          child: Text(
                                                            snap[index]
                                                                ['Title'],
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .title2
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: Color(
                                                                      0xFF101213),
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.81, -0.18),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      20, 0, 0),
                                                          child: Text(
                                                            result,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText2
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: Color(
                                                                      0xFF57636C),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.81, 0.74),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      9, 0, 0),
                                                          child: Text(
                                                            Stat,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: Color(
                                                                      0xFFEE8B60),
                                                                  fontSize: 9,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(7, 30,
                                                                    0, 0),
                                                        child: Icon(
                                                          Icons
                                                              .chevron_left_rounded,
                                                          color:
                                                              Color(0xFF57636C),
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    )
                                  : SizedBox(
                                      height: 0,
                                    );
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
              SizedBox(
                height: 50,
              ),
              //

              //

              Row(children: [
                SizedBox(
                  width: 15,
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Future GetStudentName(snap) async {
    int count = 0;
    //  StudentName.clear();
    String n = "lllllllllllllllllll";
    List<String> StudentID = [];

    try {
      for (var i = 0; snap[i] != null; i++) {
        SnapCount += 1;
        StudentID.add(snap[i]["StudentID"]);
      }
    } catch (error) {}

    for (var j = 0; j < StudentID.length; j++) {
      await ColStudent.doc(StudentID[j]).get().then((value) {
        count = 1;

        StudentName.add(value["Name"]);
      });
    }
  }

  Future GetStudentName3(snap) async {
    int count = 0;

    String n = "lllllllllllllllllll";
    List<String> StudentID = [];

    try {
      for (var i = 0; snap[i] != null; i++) {
        SnapCount += 1;
        StudentID.add(snap[i]["StudentID"]);
      }
    } catch (error) {}

    for (var j = 0; j < StudentID.length; j++) {
      await ColStudent.doc(StudentID[j]).get().then((value) {
        // Access your after your get the data
        count = 1;

        StudentName3.add(value["Name"]);
      });
    }
  }

  Future GetStudentName4(snap) async {
    int count = 0;

    String n = "lllllllllllllllllll";
    List<String> StudentID = [];
    try {
      for (var i = 0; snap[i] != null; i++) {
        SnapCount += 1;
        StudentID.add(snap[i]["StudentID"]);
      }
    } catch (error) {}

    for (var j = 0; j < StudentID.length; j++) {
      await ColStudent.doc(StudentID[j]).get().then((value) {
        count = 1;

        StudentName4.add(value["Name"]);
      });
    }
  }

  Future getDelegatorID(snap) async {
    List<String> DelegatorUsr = [];
    List<String> ID = [];
    await FirebaseFirestore.instance
        .collection("Delegator")
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              DelegatorUsr.add(document["UserName"]);
              ID.add(document["ID"]);
            }));
  }

  Widget CreateDialog5(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: const Text(' حذف التفويض   ',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold)),
      content: const Text('هل انت متأكد انك تريد حذف التفويض ؟',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);

              Req.DeleteRequests(RID);
            },
            child: const Text("موافق",
                style: TextStyle(
                    color: Color.fromARGB(255, 197, 24, 24),
                    fontWeight: FontWeight.bold))),
        TextButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          child: const Text('إلغاء'),
        ),
      ],
    );
  }

  Future GetNames(snap) async {
    List<String> StudentID = [];

    try {
      for (var i = 0; snap[i] != null; i++) {
        SnapCount += 1;
        StudentID.add(snap[i]["StudentID"]);
      }
    } catch (error) {}

    for (var j = 0; j < StudentID.length; j++) {
      await request.doc(StudentID[j]).get().then((value) {
        count = 1;

        StudentName.add(value["Name"]);
        ParentID.add(value["ParentId"]);

        for (var i = 0; i < StudentName.length; i++) {}
      });
    }

    for (var j = 0; j < ParentID.length; j++) {
      await Parent.doc(ParentID[j]).get().then((value) {
        count = 1;

        ParentName.add(value["Name"]);
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
      content: const Text(
          'يوجد لهذا الطالب  مفوض مفعل الرجاء إلغاء التفعيل لتفويض  آخر ',
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

  Future Fill() async {
    await FirebaseFirestore.instance.collection("Requests").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
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

            //  count += 1;
          }),
        );
  }

  Widget CreateDialog3(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: const Text('حذف الطلب',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold)),
      content: const Text('هل انت متأكد انك تريد طلب التفويض هذا؟',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);

              Req.DeleteRequests(ID);
            },
            child: const Text("موافق",
                style: TextStyle(
                    color: Color.fromARGB(255, 197, 24, 24),
                    fontWeight: FontWeight.bold))),
        TextButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          child: const Text('إلغاء'),
        ),
      ],
    );
  }
}
