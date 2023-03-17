import 'package:circlight/flutter_flow/flutter_flow_icon_button.dart';
import 'package:circlight/flutter_flow/flutter_flow_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:circlight/Pages/Requests.dart';

import 'package:circlight/Pages/Nav.dart';

class SentAnnouncement extends StatefulWidget {
  @override
  State<SentAnnouncement> createState() => _SentAnnouncement();
}

class _SentAnnouncement extends State<SentAnnouncement> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  CollectionReference Announ =
      FirebaseFirestore.instance.collection('Announcement');
  CollectionReference Parent = FirebaseFirestore.instance.collection('Parent');

//////////////////////////////////////////////////i think i do not need

  bool ShowAnnoun = false;

///////////////////////////////////////////////////////////////////////////////////////////////
  late AnimationController _ColorAnimationController;
  late AnimationController _TextAnimationController;
  late Animation _colorTween, _iconColorTween, _icon2ColorTween;
  late Animation<Offset> _transTween;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(295, 6, 0, 0),
                    child: Text(
                      "الإعلانات العامة",
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                          ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 7,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Announcement")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final snap = snapshot.data!.docs;
                    return FutureBuilder(
                        future: Future.wait([
                          //GetNames(snap),
                        ]),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              primary: false,
                              itemCount: snap.length,
                              itemBuilder: (context, index) {
                                //print("CountStudent");
                                // print(CountStudent);
                                /*if (CountStudent < SnapCount) {
                                  CountStudent += 1;
                                }*/
                                // print(snap[index]["status"]);

                                if (snap[index]["status"] == "Public")
                                  ShowAnnoun = true;
                                else
                                  ShowAnnoun = false;

                                //  print(ShowAnnoun);
                                return ShowAnnoun
                                    ? Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 5, 5, 5),
                                        child: Container(
                                          width: 367.6,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 4,
                                                color: Color(0x33000000),
                                                offset: Offset(0, 2),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Stack(
                                            children: [
                                              snap[index]["important"] == true
                                                  ? Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              -0.58, -0.19),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(0, 0,
                                                                    400, 0),
                                                        child:
                                                            FlutterFlowIconButton(
                                                          /* borderColor:
                                                              Color(0xFFE32121),*/
                                                          borderRadius: 8,
                                                          borderWidth: 4,
                                                          buttonSize: 35,
                                                          /* fillColor:
                                                              Color(0xFFE32121),*/
                                                          icon: Icon(
                                                            Icons.flag,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    233,
                                                                    8,
                                                                    8),
                                                            size: 16,
                                                          ),
                                                          onPressed: () {
                                                            /* print(
                                                      snap[index].reference.id);
                                                  ID = snap[index].reference.id;

                                                  showCupertinoDialog(
                                                      context: context,
                                                      builder: CreateDialog3);*/
                                                          },
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox(),
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: Text(
                                                  " العنوان:" +
                                                      snap[index]['Address'] +
                                                      "\n",
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            Color(0xFF101213),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 15, 0, 0),
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.5, -0.60),
                                                  child: Text(
                                                    snap[index]['message'],
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          color:
                                                              Color(0xFF101213),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -0.78, 0.59),
                                                child: Text(
                                                  FormattedDatesnap(
                                                      snap[index]['Date']),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color: Color.fromARGB(
                                                            255, 87, 89, 90),
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.94, 0.08),
                                                child: Container(
                                                  width: 3,
                                                  height: 42,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF29294D),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                    : SizedBox();
                              },
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }); /////////////
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(295, 6, 0, 0),
                    child: Text(
                      "الإعلانات الخاصة",
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                          ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 7,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Announcement")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final snap = snapshot.data!.docs;
                    return FutureBuilder(
                        future: Future.wait([
                          //GetNames(snap),
                        ]),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              primary: false,
                              itemCount: snap.length,
                              itemBuilder: (context, index) {
                                //print("CountStudent");
                                // print(CountStudent);
                                /*if (CountStudent < SnapCount) {
                                  CountStudent += 1;
                                }*/
                                // print(snap[index]["status"]);

                                if (snap[index]["status"] == "Private")
                                  ShowAnnoun = true;
                                else
                                  ShowAnnoun = false;

                                //  print(ShowAnnoun);
                                return ShowAnnoun
                                    ? Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 5, 5, 5),
                                        child: Container(
                                          width: 367.6,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 4,
                                                color: Color(0x33000000),
                                                offset: Offset(0, 2),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Stack(
                                            children: [
                                              snap[index]["important"] == true
                                                  ? Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              -0.58, -0.19),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(0, 0,
                                                                    400, 0),
                                                        child:
                                                            FlutterFlowIconButton(
                                                          /* borderColor:
                                                              Color(0xFFE32121),*/
                                                          borderRadius: 8,
                                                          borderWidth: 4,
                                                          buttonSize: 35,
                                                          /* fillColor:
                                                              Color(0xFFE32121),*/
                                                          icon: Icon(
                                                            Icons.flag,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    233,
                                                                    8,
                                                                    8),
                                                            size: 16,
                                                          ),
                                                          onPressed: () {
                                                            /* print(
                                                      snap[index].reference.id);
                                                  ID = snap[index].reference.id;

                                                  showCupertinoDialog(
                                                      context: context,
                                                      builder: CreateDialog3);*/
                                                          },
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox(),
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: Text(
                                                  " العنوان:" +
                                                      snap[index]['Address'] +
                                                      "\n",
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            Color(0xFF101213),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 15, 0, 0),
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.5, -0.60),
                                                  child: Text(
                                                    snap[index]['message'],
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          color:
                                                              Color(0xFF101213),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 40,
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -0.78, 0.59),
                                                child: Text(
                                                  FormattedDatesnap(
                                                      snap[index]['Date']),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color: Color.fromARGB(
                                                            255, 87, 89, 90),
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.94, 0.08),
                                                child: Container(
                                                  width: 3,
                                                  height: 42,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF29294D),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                    : SizedBox();
                              },
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }); /////////////
                  } else {
                    return const SizedBox();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

String FormattedDatesnap(timeStamp) {
  var DateFromtimestamp =
      DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
  return DateFormat('dd-MM-yyyy  hh:mm a').format(DateFromtimestamp);
}
