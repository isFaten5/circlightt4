import 'package:flutter/material.dart';

import 'package:circlight/Pages/Admin.dart';
import 'package:circlight/Pages/Requests.dart';
import 'package:circlight/Pages/Student.dart';
import 'package:circlight/flutter_flow/flutter_flow_icon_button.dart';

import 'package:flutter/cupertino.dart';

import '../flutter_flow/flutter_flow_theme.dart';

import 'package:flutter/material.dart';

import 'CreateDelegator.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:circlight/Pages/Parent.dart';

class Delegatordisplay extends StatefulWidget {
  var SName;
  Delegatordisplay({
    super.key,
    this.SName,
  });
  @override
  _Delegatordisplay createState() => _Delegatordisplay();
}

class _Delegatordisplay extends State<Delegatordisplay>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<String> StudentName = [];
  List<String> StudentName3 = [];
  List<String> docPname = [];
  var DelegatorActive = "";
  List<bool> IsSwitch = [];
  var CountSwitch = 0;
  var IsIDExists = false;
  List<String> DelegatorID = [];
  int count = 0;
  final _selectedColor = const Color(0xff0da6c2);

  Future ParentName() async {
    await FirebaseFirestore.instance.collection("Requests").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            // print(document["Email"]);

            docPname[count] = document["DelegatorName"];
            count += 1;
          }),
        );
  }

  Future Fill() async {
    //var count = 0;
    //   print("99999999999999999999999999999999999");
    await FirebaseFirestore.instance.collection("Requests").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            // print(document["Email"]);

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

  //final _unselectedColor = Color(0xff5f6368);
  final _tabs = [
    Tab(text: 'Tab1'),
    Tab(text: 'Tab2'),
  ];
  CollectionReference reques =
      FirebaseFirestore.instance.collection('Requests');
  Future<bool> CheckForStudent(SID, RID) async {
    var ID;
    var bol = true;
    List<String> IsActive = [];

    reques.get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            //  print("fffffffffffffffffffffffff");
            //  print("StudentID");
            //  print(document["StudentID"]);
            //   print("SID:");
            //   print(CurID);
            // print(RID);
            // print(document.reference.id);
            var equal = false;

            if (RID == document.reference.id) {
              equal = false;
              // print("it should be false");
            } else if (RID != document.reference.id) {
              equal = true;
            }
            if (equal) {
              if (document["StudentID"] == SID) {
                //   print("IM IN");
                // print("222222222222222222222");
                if (document["IsActive"] == "true" &&
                    document["isAccepted"] == true) {
                  //  print("44444444444444444444444444444444");
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

  var IsSwitched;
  var status = false;
  int SnapCount = 0;
  Student Studentx = new Student(
    Name: "",
    Class: "",
    SNationalID: "",
    SNationality: "",
    SUserName: "",
    SBloodType: "",
  );

  String Active = "";
  String Accepted = "";
  late bool IsAct = true;
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
      DName: "",
      Dusername: "",
      isAccepted: "Waiting",
      isActive: "false",
      SID: "");

  var CurrentID;
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
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      appBar: AppBar(
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
      extendBodyBehindAppBar: true,
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Scaffold(
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
                              SizedBox(
                                height: 60,
                              ),

                              /* Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 80, 10, 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 180,
                                ),
                                Align(
                                  alignment: Alignment(-0.7, -0.70),
                                  child: Text(
                                    ' مرحبًا نورة البشر',
                                    textAlign: TextAlign.right,
                                    style: FlutterFlowTheme.of(context)
                                        .title1
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF101213),
                                          fontSize: 32,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () async {
                                    scaffoldKey.currentState!.openDrawer();
                                  },
                                  child: Container(
                                    width: 55,
                                    height: 55,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      'assets/images/Screenshot_(399).png',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),*/
                              /* (
                            height: 0.2,
                            thickness: 1,
                            color: Color.fromARGB(255, 209, 209, 209),
                          ),*/
                            ],
                          ),
                          SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new PreferredSize(
                                  preferredSize: new Size(8000.0, 200.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        240, 10, 0, 10),
                                    child: new Container(
                                      width: 150.0,
                                      height: 30,
                                      child: TabBar(
                                        controller: _tabController,
                                        unselectedLabelColor: Colors.grey,
                                        labelColor: _selectedColor,
                                        indicator: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          color:
                                              _selectedColor.withOpacity(0.2),
                                        ),
                                        tabs: const <Widget>[
                                          Tab(
                                            child: Text(
                                              "المفوضين",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Tab(
                                            child: Text(
                                              "الطلبات",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ), //
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 40,
                                  width: 30,
                                  padding: EdgeInsets.only(
                                      right: 0, top: 0, left: 10),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 10, top: 0, left: 10),
                                    child: TextField(
                                      onChanged: (value) {
                                        setState(() {
                                          //  searchname = value;
                                        });
                                      },
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
                                                  color: Colors.grey.shade100)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color:
                                                      Colors.grey.shade100))),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment(0.91, 0.9),
                                  child: Text(
                                    "المفوضين المتاحين",
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
                                          GetStudentName(snap),
                                          Fill(),
                                          getDelegatorID(snap)
                                        ]),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Align(
                                                child: ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              primary: false,
                                              itemCount: snap.length,
                                              itemBuilder: (context, index) {
                                                //dynamic v = docIDS[index];
                                                IsIDExists = false;
                                                //    print("dddddddddddddddd");
                                                //    print(IsSwitch[index]);
                                                //   print("CountStudent");
                                                //   print(CountStudent);

                                                RID = snap[index].reference.id;

                                                IsAct = true;
                                                SCount += 1;

                                                var Co = index;

                                                /// getDelegatorID(snap);
                                                RID = snap[index].reference.id;
                                                ShowRequest = false;
                                                // print(
                                                //     "aaaaaaaaaaaaaaaaaaaaaaaaaaa");
                                                Active =
                                                    snap[index]["IsActive"];
                                                if (Active == "true") {
                                                  IsSwitched = true;
                                                } else if (Active == "false") {
                                                  IsSwitched = false;
                                                }
                                                // print(RID);
                                                //   print(
                                                //      "+++++++++++++++++++++++++++");
                                                //print(IsAct);

                                                if (snap[index]["isAccepted"] ==
                                                        "true" &&
                                                    snap[index]["IsActive"] ==
                                                        "true") {
                                                  ShowRequest = true;
                                                }
                                                if (snap[index]["isAccepted"] ==
                                                        "true" &&
                                                    snap[index]["IsActive"] ==
                                                        "false" &&
                                                    snap[index][
                                                            "DelegatorActive"] ==
                                                        "true") {
                                                  ShowRequest = true;
                                                }
                                                if (snap[index]["isAccepted"] ==
                                                    "false") {
                                                  ShowRequest = false;
                                                }
                                                // print(index);
                                                // print("000000000000000");
                                                //  print(StudentName[index]);

                                                return ShowRequest
                                                    ? Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5, 5, 5, 5),
                                                        child: Container(
                                                          width: 367.6,
                                                          height: 58.3,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                blurRadius: 4,
                                                                color: Color(
                                                                    0x33000000),
                                                                offset: Offset(
                                                                    0, 2),
                                                              )
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Stack(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        -0.7,
                                                                        -0.19),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          4,
                                                                          0),
                                                                  child:
                                                                      new Switch(
                                                                    value:
                                                                        IsSwitched,
                                                                    onChanged:
                                                                        (value) {
                                                                      RID = snap[
                                                                              index]
                                                                          .reference
                                                                          .id;

                                                                      if (value) {
                                                                        //   print(
                                                                        //      "<<<<<<<<<<<<<<<<<<<<<<<<object>>>>>>>>>>>>>>>>>>>>>>>>");
                                                                        RID = snap[index]
                                                                            .reference
                                                                            .id;

                                                                        CurID = snap[index]
                                                                            [
                                                                            "StudentID"];

                                                                        Future
                                                                            .wait([
                                                                          CheckForStudent(
                                                                              CurID,
                                                                              RID),
                                                                        ]);

                                                                        //      print(
                                                                        //       IsIDExists);

                                                                        Future.delayed(
                                                                            Duration(seconds: 1),
                                                                            () {
                                                                          if (IsIDExists ==
                                                                              true) {
                                                                            // print(
                                                                            //     "=========================");
                                                                            showCupertinoDialog(
                                                                                context: context,
                                                                                builder: CreateDialog33);
                                                                            IsIDExists =
                                                                                false;
                                                                          } else {
                                                                            setState(() {
                                                                              Req.UpdateRequest(RID, "IsActive", "true");
                                                                            });
                                                                          }
                                                                        });
                                                                      } else if (value ==
                                                                          false) {
                                                                        RID = snap[index]
                                                                            .reference
                                                                            .id;
                                                                        setState(
                                                                            () {
                                                                          Req.UpdateRequest(
                                                                              RID,
                                                                              "IsActive",
                                                                              "false");
                                                                        });
                                                                        CountSwitch +=
                                                                            1;
                                                                        //  print(
                                                                        //      "[[[[[object]]]]]");
                                                                        // print(
                                                                        //     CountSwitch);
                                                                      }
                                                                    },
                                                                    activeTrackColor:
                                                                        Colors
                                                                            .lightGreenAccent,
                                                                    activeColor:
                                                                        Colors
                                                                            .green,
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        -0.9,
                                                                        -0.19),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          3,
                                                                          0,
                                                                          0),
                                                                  child: InkWell(
                                                                      // height: 80,

                                                                      onTap: () {
                                                                        CurrentID =
                                                                            snapshot.data![1][index];
                                                                        //   print(
                                                                        //      "llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll");
                                                                        showCupertinoDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                CreateDialog5);
                                                                      },
                                                                      child: Container(
                                                                        width:
                                                                            25,
                                                                        height:
                                                                            25,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(40),
                                                                          color:
                                                                              Color(0xFFE32121),
                                                                        ),
                                                                        child: const Center(
                                                                            child: Icon(
                                                                          Icons
                                                                              .close,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              250,
                                                                              252,
                                                                              253),
                                                                          size:
                                                                              13,
                                                                        )),
                                                                      )),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.78,
                                                                        -0.59),
                                                                child: Text(
                                                                  " المفوض" +
                                                                      " " +
                                                                      snap[index]
                                                                          [
                                                                          'DelegatorName'],
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText1
                                                                      .override(
                                                                        fontFamily:
                                                                            'Outfit',
                                                                        color: Color(
                                                                            0xFF101213),
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.77,
                                                                        0.49),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          4,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    " "
                                                                            "  لطالب" +
                                                                        " " +
                                                                        StudentName[
                                                                            index],
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText2
                                                                        .override(
                                                                          fontFamily:
                                                                              'Outfit',
                                                                          color:
                                                                              Color(0xFF57636C),
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.94,
                                                                        0.08),
                                                                child:
                                                                    Container(
                                                                  width: 3,
                                                                  height: 42,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xFF29294D),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ))
                                                    : SizedBox(
                                                        height: 0,
                                                      );
                                              },
                                            ));
                                          } else {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      ); /////////////
                                    } else {
                                      return const Text("");
                                    }
                                  },
                                ),
                                Align(
                                  alignment: Alignment(0.91, -0.70),
                                  child: Text(
                                    "المفوضين الغير المتاحين",
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
                                Align(
                                  alignment: Alignment(0.1, -0.10),
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("Requests")
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasData) {
                                        final snap = snapshot.data!.docs;

                                        return FutureBuilder(
                                          future: Future.wait(
                                              [GetStudentName3(snap)]),
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
                                                  //   IsIDExists = false;

                                                  RID =
                                                      snap[index].reference.id;
                                                  ShowRequest = false;

                                                  Accepted =
                                                      snap[index]["isAccepted"];
                                                  Active =
                                                      snap[index]["IsActive"];
                                                  DelegatorActive = snap[index]
                                                      ["DelegatorActive"];
                                                  if (Accepted == "true" &&
                                                      DelegatorActive ==
                                                          "false") {
                                                    ShowRequest = true;
                                                    //print(RID);
                                                    //print("MMMMMMMMMMMMMMM");
                                                    //print(Active);
                                                    // print(IsAct);

                                                  }

                                                  return ShowRequest
                                                      ? Container(
                                                          height: 70,
                                                          width:
                                                              double.infinity,
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 1),
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border(
                                                              bottom: BorderSide(
                                                                  color: Colors
                                                                      .black12),
                                                            ),
                                                          ),
                                                          child: Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topRight,
                                                                  child:
                                                                      Container(
                                                                    width: 4,
                                                                    height: 90,
                                                                    margin: EdgeInsets.only(
                                                                        right:
                                                                            17,
                                                                        top: 10,
                                                                        bottom:
                                                                            10),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                      color: const Color(
                                                                          0xff0da6c2),
                                                                      //color:
                                                                      // Color(0xffD6D6D6),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4),
                                                                    ),
                                                                  ),
                                                                ),
                                                                //to only show the allowed people to admin
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.78,
                                                                          -0.59),
                                                                  child: Text(
                                                                    " المفوض" +
                                                                        " " +
                                                                        snap[index]
                                                                            [
                                                                            'DelegatorName'],
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          15,
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
                                                                          0.77,
                                                                          0.49),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            4,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      " " +
                                                                          "  لطالب" +
                                                                          " " +
                                                                          StudentName3[
                                                                              index],
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .grey,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

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

                                                                  children: <
                                                                      Widget>[
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              10,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.63,
                                                                            -0.16),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              50.7,
                                                                          height:
                                                                              22,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.grey.withOpacity(0.2),
                                                                            borderRadius:
                                                                                BorderRadius.circular(20),
                                                                            shape:
                                                                                BoxShape.rectangle,
                                                                            border:
                                                                                Border.all(
                                                                              color: Colors.grey.withOpacity(0.2),
                                                                            ),
                                                                          ),
                                                                          child: Text(
                                                                              "غير متاح",
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.grey)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ]))
                                                      : SizedBox(
                                                          height: 0,
                                                        );
                                                },
                                              );
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        ); /////////////
                                      } else {
                                        return const Text("");
                                      }
                                    },
                                  ),
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
          ),
          Stack(
            children: [
              Scaffold(
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
                              SizedBox(
                                height: 50,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Align(
                                      // alignment: Alignment(-0.85, -0.45),
                                      child: Container(
                                        height: 35.0,
                                        width: 35.0,
                                        child: FittedBox(
                                          child: FloatingActionButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .push(CupertinoPageRoute(
                                                builder: (context) =>
                                                    CreateDelegator(),
                                              ));
                                            },
                                            elevation: 0,
                                            child: Container(
                                              height: 70,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    blurRadius: 6,
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(90),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    const Color(0xff0da6c2),
                                                    const Color(0xff57d77a)
                                                  ],
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                            ),
                                            backgroundColor: Color.fromARGB(
                                                0, 255, 253, 253),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  new PreferredSize(
                                    preferredSize: new Size(8000.0, 200.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          190, 20, 0, 10),
                                      child: new Container(
                                        width: 150.0,
                                        height: 30,
                                        child: TabBar(
                                          controller: _tabController,
                                          unselectedLabelColor: Colors.grey,
                                          labelColor: _selectedColor,
                                          indicator: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(80.0),
                                            color:
                                                _selectedColor.withOpacity(0.2),
                                          ),
                                          tabs: const <Widget>[
                                            Tab(
                                              child: Text(
                                                "المفوضين",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Tab(
                                              child: Text(
                                                "الطلبات",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ), //
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    height: 60,
                                  ),

                                  /* Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 80, 10, 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 180,
                                ),
                                Align(
                                  alignment: Alignment(-0.7, -0.70),
                                  child: Text(
                                    ' مرحبًا نورة البشر',
                                    textAlign: TextAlign.right,
                                    style: FlutterFlowTheme.of(context)
                                        .title1
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF101213),
                                          fontSize: 32,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () async {
                                    scaffoldKey.currentState!.openDrawer();
                                  },
                                  child: Container(
                                    width: 55,
                                    height: 55,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      'assets/images/Screenshot_(399).png',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),*/
                                  /* (
                            height: 0.2,
                            thickness: 1,
                            color: Color.fromARGB(255, 209, 209, 209),
                          ),*/
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment(0.91, -0.70),
                                      child: Text(
                                        'قيد الانتظار',
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
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          final snap = snapshot.data!.docs;

                                          return FutureBuilder(
                                            future: Future.wait(
                                                [GetStudentName(snap)]),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  primary: false,
                                                  itemCount: snap.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    //dynamic v = docIDS[index];
                                                    //   IsIDExists = false;

                                                    RID = snap[index]
                                                        .reference
                                                        .id;
                                                    ShowRequest = false;

                                                    Accepted = snap[index]
                                                        ["isAccepted"];

                                                    if (Accepted == "Waiting") {
                                                      ShowRequest = true;
                                                    }

                                                    return ShowRequest
                                                        ? Container(
                                                            height: 70,
                                                            width: double
                                                                .infinity,
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 1),
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border: Border(
                                                                bottom: BorderSide(
                                                                    color: Colors
                                                                        .black12),
                                                              ),
                                                            ),
                                                            child: Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child:
                                                                        Container(
                                                                      width: 4,
                                                                      height:
                                                                          90,
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              17,
                                                                          top:
                                                                              10,
                                                                          bottom:
                                                                              10),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .rectangle,
                                                                        color: const Color(
                                                                            0xff0da6c2),
                                                                        //color:
                                                                        // Color(0xffD6D6D6),
                                                                        borderRadius:
                                                                            BorderRadius.circular(4),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  //to only show the allowed people to admin

                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.78,
                                                                            -0.59),
                                                                    child: Text(
                                                                      " المفوض" +
                                                                          " " +
                                                                          snap[index]
                                                                              [
                                                                              'DelegatorName'],
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: const Color(
                                                                            0xff0da6c2),
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.77,
                                                                            0.49),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              4,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Text(
                                                                        " " +
                                                                            "  لطالب" +
                                                                            " " +
                                                                            StudentName[index],
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              Colors.grey,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  //container for button
                                                                  ///hola

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

                                                                    children: <
                                                                        Widget>[
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            10,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.63,
                                                                              -0.16),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                50.7,
                                                                            height:
                                                                                22,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.grey.withOpacity(0.2),
                                                                              borderRadius: BorderRadius.circular(20),
                                                                              shape: BoxShape.rectangle,
                                                                              border: Border.all(
                                                                                color: Colors.grey.withOpacity(0.2),
                                                                              ),
                                                                            ),
                                                                            child: Text('لم يقبل بعد',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.grey)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ]))
                                                        : Text("");
                                                  },
                                                );
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
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
                                      height: 10,
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
                                  'الطلبات السابقة',
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
                              SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("Requests")
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              if (snapshot.hasData) {
                                                final snap =
                                                    snapshot.data!.docs;

                                                return FutureBuilder(
                                                  future: Future.wait(
                                                      [GetStudentName3(snap)]),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return ListView.builder(
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        primary: false,
                                                        itemCount: snap.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          var NotWaiting =
                                                              false;
                                                          var RStatus = false;
                                                          //    print(
                                                          //        "sssssssssssss");
                                                          //   print(snap[index]
                                                          //       .reference
                                                          //       .id);
                                                          //   print(index);
                                                          //    print(StudentName[
                                                          //        index]);
                                                          Accepted = snap[index]
                                                              ["isAccepted"];
                                                          ShowRequest = false;
                                                          if (Accepted !=
                                                              "Waiting") {
                                                            NotWaiting = true;
                                                            RID = snap[index]
                                                                .reference
                                                                .id;

                                                            if (Accepted ==
                                                                "true") {
                                                              ShowRequest =
                                                                  true;

                                                              RStatus = true;
                                                            }

                                                            if (Accepted ==
                                                                "false") {
                                                              ShowRequest =
                                                                  true;
                                                              RStatus = false;
                                                            }
                                                          } else {
                                                            ShowRequest = false;
                                                          }

                                                          return ShowRequest
                                                              ? Container(
                                                                  height: 70,
                                                                  width: double
                                                                      .infinity,
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          1),
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border:
                                                                        Border(
                                                                      bottom: BorderSide(
                                                                          color:
                                                                              Colors.black12),
                                                                    ),
                                                                  ),
                                                                  child: Stack(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      children: [
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.topRight,
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                4,
                                                                            height:
                                                                                90,
                                                                            margin: EdgeInsets.only(
                                                                                right: 17,
                                                                                top: 10,
                                                                                bottom: 10),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              shape: BoxShape.rectangle,
                                                                              color: const Color(0xff0da6c2),
                                                                              //color:
                                                                              // Color(0xffD6D6D6),
                                                                              borderRadius: BorderRadius.circular(4),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        //to only show the allowed people to admin
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.78,
                                                                              -0.59),
                                                                          child:
                                                                              Text(
                                                                            " المفوض" +
                                                                                " " +
                                                                                snap[index]['DelegatorName'],
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 15,
                                                                              color: const Color(0xff0da6c2),
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.77,
                                                                              0.49),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                4,
                                                                                0,
                                                                                0),
                                                                            child:
                                                                                Text(
                                                                              " "
                                                                                      "  لطالب" +
                                                                                  " " +
                                                                                  StudentName3[index],
                                                                              style: const TextStyle(
                                                                                fontSize: 15,
                                                                                color: Colors.grey,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        //container for button
                                                                        ///hola
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          //mainAxisSize:
                                                                          // MainAxisSize.max,

                                                                          /* mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,*/

                                                                          children: <
                                                                              Widget>[
                                                                            RStatus
                                                                                ? Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(0.63, -0.16),
                                                                                      child: Container(
                                                                                        width: 50.7,
                                                                                        height: 22,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color.fromARGB(107, 87, 215, 121).withOpacity(0.2),
                                                                                          borderRadius: BorderRadius.circular(20),
                                                                                          shape: BoxShape.rectangle,
                                                                                          border: Border.all(
                                                                                            color: Color.fromARGB(255, 79, 198, 111).withOpacity(0.2),
                                                                                          ),
                                                                                        ),
                                                                                        child: Text("مقبوله", textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xff57d77a))),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(0.63, -0.16),
                                                                                      child: Container(
                                                                                        width: 50.7,
                                                                                        height: 22,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Colors.red.withOpacity(0.2),
                                                                                          borderRadius: BorderRadius.circular(20),
                                                                                          shape: BoxShape.rectangle,
                                                                                          border: Border.all(
                                                                                            color: Colors.red.withOpacity(0.2),
                                                                                          ),
                                                                                        ),
                                                                                        child: Text("مرفوضه", textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.red)),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                          ],
                                                                        ),
                                                                      ]))
                                                              : Text("");
                                                        },
                                                      );
                                                    } else {
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(),
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
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
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
              ),
            ],
          )
        ],
      ),
    );
  }

  Future getDelegatorID(snap) async {
    print("QQQQQQQQQQQQQQQQQQQQQQQQQQQ");
    print("DDDDDDDDDDDDDDDDDDDDDDDDDDD");
    print("EEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
    print("CCCCCCCCCCCCCCCCCCCCCCCCCCC");
    print("QQQQQQQQQQQQQQQQQQQQQQQQQQQ");
    print("DDDDDDDDDDDDDDDDDDDDDDDDDD");
    print("QQQQQQQQQQQQQQQQQQQQQQQQQQQ");
    print("VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV");
    print("QQQQQQQQQQQQQQQQQQQQQQQQQQQ");
    print("WWWWWWWWWWWWWWWWWWWWWWWWWW");
    print("QQQQQQQQQQQQQQQQQQQQQQQQQQQ");
    print("HHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
    print("QQQQQQQQQQQQQQQQQQQQQQQQQQQ");

    List<String> DelegatorUsr = [];
    List<String> ID = [];
    await FirebaseFirestore.instance
        .collection("Delegator")
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document["UserName"]);
              print(document["ID"]);
              DelegatorUsr.add(document["UserName"]);
              ID.add(document["ID"]);
            }));
  }

  Future GetStudentName3(snap) async {
    // print("Entered!");
    int count = 0;
    StudentName3.clear();
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
        //StudentName.add(value.get('Name'));
        //  print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        // print("StID");
        // print(StudentID[j]);
        // print("3333333333333333333333");
        //  print(StudentName[0]);
        // Access your after your get the data
        count = 1;
        // print(value["Name"]);

        StudentName3.add(value["Name"]);
        // print("Starteddd");
        // print("ennnnnnnnnnnnnnnddddddddddddddddddddd");
      });
    }

    // print(StudentName[0]);
  }

  Future GetStudentName(snap) async {
    // print("Entered!");
    int count = 0;
    StudentName.clear();
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
        //StudentName.add(value.get('Name'));
        //  print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        // print("StID");
        // print(StudentID[j]);
        // print("3333333333333333333333");
        //  print(StudentName[0]);
        // Access your after your get the data
        count = 1;
        // print(value["Name"]);

        StudentName.add(value["Name"]);
        // print("Starteddd");
        // print("ennnnnnnnnnnnnnnddddddddddddddddddddd");
      });
    }

    // print(StudentName[0]);
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
}
