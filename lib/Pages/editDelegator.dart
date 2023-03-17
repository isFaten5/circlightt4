import 'package:circlight/Pages/DelegatorHome.dart';
import 'package:circlight/Pages/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

import 'package:circlight/Pages/Delegator.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'Nav.dart';
import 'base_screen.dart';
import 'displayParent.dart';

import 'header_widget.dart';

// this is the edit for parent
class editDelegator extends StatefulWidget {
  var isChanged = "";
  var isDropDown = false;
  var whichpag = 0;
  var Index = 1;
  var TheValue = "";

  bool Confirm;
  bool DropDown;
  String documentId;

  editDelegator({
    Key? key,
    required this.documentId,
    required this.whichpag,
    // ignore: non_constant_identifier_names
    required this.Index,
    required this.TheValue,
    required this.Confirm,
    required this.DropDown,
  }) : super(key: key);

  @override
  State<editDelegator> createState() => _editDelegator();
  getData(change) {
    isChanged = change;
  }
}

class _editDelegator extends State<editDelegator>
    with TickerProviderStateMixin {
  int t = 0;
  bool isFieldChange = false;
  late bool isDrop = widget.DropDown;
  bool isDropDown = false;
  var IsSave;
  double _headerHeight = 250;
  int _changedNumber = 0, _selectedNumber = 1;
  var DropValue;
  int C = 0;
  late String DBvalue = "";
  // this is the list for the relatives
  final State = ["متاح", "متأخر"];
  String OldValue = "";

  String isDiscard = "false";
  final formKey = GlobalKey<FormState>();
  Delegator parentx = new Delegator(
    Name: "",
    Email: "",
    DUserName: "",
    DNationalID: "",
    Password: "",
    State: "",
  );

  bool RelativeCh = false;
//for username uniqueness
  List<String> docEmails = [];

  List<String> docUserName = [];

  List<String> docAdmin = [];
  bool check = true;

  get Name => Name;

  Future getEmail() async {
    await FirebaseFirestore.instance.collection("Delegator2").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            // print(document["Email"]);

            docEmails.add(document["Email"]);
          }),
        );
  }

//for username uniqueness

  Future getUserName() async {
    await FirebaseFirestore.instance.collection("Delegator2").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            docUserName.add(document["UserName"]);
          }),
        );
  }

  //get admin ID

  // Future getAdminID() async {
  //   await FirebaseFirestore.instance.collection("Admin").get().then(
  //         (snapshot) => snapshot.docs.forEach((document) {
  //           // print(document["Email"]);

  //           docAdmin.add(document.reference.id);
  //         }),
  //       );
  // }

  late String Dvalue;
  late int Inx;
  CollectionReference Parents =
      FirebaseFirestore.instance.collection("Delegator2");
  final DRef = FirebaseFirestore.instance;
  List<String> docIDs = [];
  TextEditingController DName = TextEditingController();
  TextEditingController DPassword = TextEditingController();
  TextEditingController DEmail = TextEditingController();
  TextEditingController DUserName = TextEditingController();
  TextEditingController DID = TextEditingController();
  TextEditingController DState = TextEditingController();

  bool isEmailCorrect = false;
  bool isDone = false;

  String Field = "None";
  String UpdatedValue = "";
  int DEIndex = 1;
  late bool save;
  late TextEditingController controller;

  late FixedExtentScrollController scrollController;
  String Title = "";
  int DropIndex = 0;
  late bool isSaved = widget.Confirm;
  late AnimationController _ColorAnimationController;
  late AnimationController _TextAnimationController;
  late Animation _colorTween, _iconColorTween, _icon2ColorTween;
  late Animation<Offset> _transTween;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _ColorAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(_ColorAnimationController);
    _iconColorTween = ColorTween(begin: Colors.white, end: Colors.grey)
        .animate(_ColorAnimationController);

    _icon2ColorTween =
        ColorTween(begin: Colors.white, end: const Color(0xff42c98d))
            .animate(_ColorAnimationController);

    _TextAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));

    _transTween = Tween(begin: Offset(-10, 40), end: Offset(-10, 0))
        .animate(_TextAnimationController);
    scrollController = FixedExtentScrollController(initialItem: DEIndex);
    controller = TextEditingController(text: State[DEIndex]);
    Dvalue = parentx.State;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
    controller.dispose();
    DName.dispose();
    DPassword.dispose();
    DEmail.dispose();
    DUserName.dispose();
    DID.dispose();
    DState.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    getEmail();

    getUserName();

    //getAdminID();
    // ignore: deprecated_member_use
    IsSave = List<int>.filled(5, 0);
    DropValue = List<String>.generate(10, growable: true, (index) => "null");
    DropValue[DropIndex] = "متاح";
    DropIndex += 1;

    int whichpagee = widget.whichpag;
    String TheValuee = widget.TheValue;
    int WIndex = widget.Index;
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    String change = widget.isChanged;
    var size = MediaQuery.of(context).size;

    int Tab = 0;

    Widget currentScreen = BaseScreen();

    // initState();
    // dispose();
    return FutureBuilder<DocumentSnapshot>(
        future: Parents.doc(widget.documentId).get(),
        builder: ((context, snapshot) {
          try {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              final String jsonString = jsonEncode(data);
              parentx.Name = data["Name"];
              //parentx.Name = CurrentID;
              parentx.Email = data["Email"];
              print(data["UserName"]);
              parentx.DUserName = data["UserName"];

              parentx.DNationalID = data["ID"];

              parentx.Password = data["Password"];

              DropValue[DropIndex] = data["State"];
              DropIndex += 1;
              if (t == 0) {
                Dvalue = data["State"];
              }
              t += 1;
              parentx.State = data["State"];
            }
          } catch (e) {
            // print("xxxxxxxxxxxxxxxxxxxxxxxx");
          }
          if (whichpagee == 1) {
            return GetEditField(WIndex, TheValuee, height);
          } else {
            return GetMainPage(height, isSaved);
          }
        }
            // return Center(child: CircularProgressIndicator());
            ));
  }

  GetEditField(WIndex, value, height) {
    save = false;
    print("kkkkkkkkkkkkkkkkk");
    print(save);
    switch (WIndex) {
      case 1:
        Title = "اسم المفوض ";
        break;
      case 2:
        Title = "اسم المستخدم";
        break;
      case 3:
        Title = "البريد الالكتروني ";
        break;
      case 4:
        Title = "رقم الهوية/الإقامة";
        break;
      case 5:
        Title = "الرقم السري";
        break;
    }
    return Scaffold(
        backgroundColor: Color.fromRGBO(252, 253, 255, 1),
        appBar: AppBar(
          elevation: 3,
          automaticallyImplyLeading: false,
          title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                /*Container(
                  padding: const EdgeInsets.only(right: 5),
                  child: CupertinoButton(
                    child: Text(
                      "حفظ",
                      style: TextStyle(color: const Color(0xff42c98d)),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        //t(DocId, Field, Name)
                        if (save == false) {
                          Navigator.pop(context);
                        }

                        switch (Field) {
                          case "Name":
                            UpdatedValue = parentName.text;
                            break;
                          case "UserName":
                            UpdatedValue = parentUserName.text;
                            break;
                          case "Email":
                            UpdatedValue = parentEmail.text;
                            break;
                          case "JobTitle":
                            UpdatedValue = JobTitle.text;
                            break;
                          case "PhoneNumber":
                            UpdatedValue = Phone.text;
                            break;
                          case "AltPhoneNumber":
                            UpdatedValue = AltPhone.text;
                            break;
                          case "NationalID":
                            UpdatedValue = NationalID.text;
                            break;
                          case "Nationality":
                            UpdatedValue = Nationality.text;

                            break;
                          case "RelativeRelation":
                            UpdatedValue = Dvalue;
                            break;
                        }

                        if (save == true) {
                          /* Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => editparent5(
                                documentId: widget.documentId,
                                Confirm: save,
                                Index: 1,
                                TheValue: "",
                                whichpag: 0,
                              )));*/
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar); // snack
                          Future.delayed(const Duration(milliseconds: 1500))
                              .then((value) {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => editparent5(
                                          documentId: widget.documentId,
                                          Confirm: save,
                                          Index: 1,
                                          TheValue: "",
                                          whichpag: 0,
                                          DropDown: isDrop,
                                        )));
                          });
                        }
                        await parentx.UpdateParent(
                            widget.documentId, Field, UpdatedValue);

                        /* Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => editparent5(
                              documentId: widget.documentId,
                            )));*/

                        // //

                        //
                      }
                    },
                  ),
                ),*/
                SizedBox(
                  width: 80,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      Title,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black38),
                    ),
                  ),
                ),
              ]),
          actions: [
            IconButton(
              onPressed: () {
                if (check == true) {
                  if (formKey.currentState!.validate()) {
                    if (save == false) {
                      Navigator.pop(context);
                    }
                    if (save == true) {
                      print(value);

                      showCupertinoDialog(
                          context: context, builder: CreateDialog3);
                    }
                  }
                }
              },
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 16,
                color: Colors.grey,
              ),
              color: Colors.grey,
            ),
          ],
          backgroundColor: Color(0xFFffffff),
        ),
        key: _scaffoldKey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: ListView(children: [
                FutureBuilder(
                  builder: ((context, snapshot) {
                    return Container(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: Form(
                        key: formKey, //key for form
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.05,
                            ),
                            GetWidget(WIndex),
                            SizedBox(
                              height: height * 0.05,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ])),
            ],
          ),
        ));
  }

  Widget GetWidget(In) {
    Widget Fields = Text("");

    switch (In) {
      case 1:
        Field = "Name";
        OldValue = parentx.Name;

        Fields = Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            controller: DName..text = parentx.Name,
            //to take text from user input
            textAlign: TextAlign.right,
            style: GoogleFonts.poppins(
                fontSize: 14,
                //fontWeight: FontWeight.w600,
                color: Colors.grey),
            showCursor: true,
            decoration: InputDecoration(
              hintText: "أدخل اسم المفوض ",
              labelText: "اسم المفوض",
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
              labelStyle: const TextStyle(
                  color: const Color(0xff57d77a),
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 12, top: 9, left: 9),
                child: Container(
                  //  padding: const EdgeInsets.only(right: 5),

                  child: Column(children: [
                    Image.asset("assets/icons/name.png",
                        width: 20, height: 20, color: Color(0xff42c98d)),
                  ]),
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: const Color(0xff57d77a), width: 1),
                  borderRadius: BorderRadius.circular(10)),
              floatingLabelStyle: const TextStyle(
                  color: const Color(0xff57d77a),
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0xff57d77a), width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            validator: (value) {
              if (OldValue != DName.text) {
                save = true;
              }

              if (value!.isEmpty)
                return "أرجو منك تعبئه الحقل الفارغ ";
              else {
                return null;
              }
            },
          ),
        );
        break;
      case 2:
        Field = "UserName";
        OldValue = parentx.DUserName;
        Fields = Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            controller: DUserName..text = parentx.DUserName,
            //to take text from user input
            textAlign: TextAlign.right,

            style: GoogleFonts.poppins(
                fontSize: 14,
                //fontWeight: FontWeight.w600,
                color: Colors.grey),
            showCursor: true,
            cursorColor: const Color(0xff57d77a),

            decoration: InputDecoration(
              hintText: " أدخل اسم المستخدم",
              labelText: "اسم المستخدم",
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
              labelStyle: const TextStyle(
                  color: const Color(0xff57d77a),
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.person,
                  size: 22,
                  color: const Color(0xff42c98d),
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: const Color(0xff57d77a), width: 1),
                  borderRadius: BorderRadius.circular(10)),
              floatingLabelStyle: const TextStyle(
                  color: const Color(0xff57d77a),
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0xff57d77a), width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            validator: (value) {
              if (OldValue != DUserName.text) {
                save = true;
              }

              if (value!.isEmpty)
                return "أرجو منك تعبئه الحقل الفارغ ";
              else {
                for (var i = 0; i < docUserName.length; i++) {
                  if (value == docUserName[i]) {
                    if (OldValue == value) {
                      check = false;
                    }

                    if (check != false) {
                      return "اسم المستخدم مستخدم مسبقا ";
                    }
                  }
                }

                return null;
              }
            },
          ),
        );
        break;
      case 3:
        Field = "Email";
        OldValue = parentx.Email;
        Fields = Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            controller: DEmail..text = parentx.Email,
            textAlign: TextAlign.right,
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xffA7A7A7)),
            showCursor: true,
            cursorColor: const Color(0xff57d77a),
            decoration: InputDecoration(
              labelText: "البريد الالكتروني ",
              hintText: "something@email.com",
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
              labelStyle: const TextStyle(
                  color: const Color(0xff57d77a),
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.email,
                  size: 18,
                  color: const Color(0xff42c98d),
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: const Color(0xff57d77a), width: 1),
                  borderRadius: BorderRadius.circular(10)),
              floatingLabelStyle: const TextStyle(
                  color: const Color(0xff57d77a),
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0xff57d77a), width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            validator: (value) {
              if (OldValue != DEmail.text) {
                save = true;
              }

              if (value!.isEmpty)
                return "أرجو منك تعبئه الحقل الفارغ ";
              else {
                for (var i = 0; i < docEmails.length; i++) {
                  if (value == docEmails[i]) {
                    if (OldValue == value) {
                      check = false;
                    }

                    if (check != false) {
                      return "البريد الإلكتروني مستخدم مسبقا ";
                    }
                  }
                }

                return null;
              }
            },
          ),
        );
        break;
      case 4:
        Field = "ID";
        OldValue = parentx.DNationalID;
        Fields = Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            controller: DID..text = parentx.DNationalID,
            //to take text from user input
            textAlign: TextAlign.right,

            style: GoogleFonts.poppins(
                fontSize: 14,
                //fontWeight: FontWeight.w600,
                color: Colors.grey),
            showCursor: true,
            cursorColor: const Color(0xff57d77a),

            maxLength: 10,
            decoration: InputDecoration(
              hintText: "أدخل رقم الهوية/الإقامة",
              labelText: "رقم الهوية/الإقامة",
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
              labelStyle: const TextStyle(
                  color: const Color(0xff57d77a),
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 12, top: 9, left: 9),
                child: Container(
                  //  padding: const EdgeInsets.only(right: 5),

                  child: Column(children: [
                    Image.asset("assets/icons/ID.png",
                        width: 20, height: 20, color: Color(0xff42c98d)),
                  ]),
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: const Color(0xff57d77a), width: 1),
                  borderRadius: BorderRadius.circular(10)),
              floatingLabelStyle: const TextStyle(
                  color: const Color(0xff57d77a),
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0xff57d77a), width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            validator: (value) {
              if (OldValue != DID.text) {
                save = true;
              }

              if (value!.isEmpty || !RegExp(r'^[0-9]{10}$').hasMatch(value!))
                return "أرجو منك تعبئه الحقل بطريقه صحيحة حيث يتكون من 10 ارقام";
              else {
                return null;
              }
            },
          ),
        );
        break;
      case 5:
        Field = "Password";
        OldValue = parentx.Password;
        Fields = Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            controller: DPassword..text = parentx.Password,
            //to take text from user input
            textAlign: TextAlign.right,

            style: GoogleFonts.poppins(
                fontSize: 14,
                //fontWeight: FontWeight.w600,
                color: Colors.grey),
            showCursor: true,
            cursorColor: const Color(0xff57d77a),

            decoration: InputDecoration(
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
              labelStyle: const TextStyle(
                  color: const Color(0xff57d77a),
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 12, top: 9, left: 9),
                child: Container(
                  //  padding: const EdgeInsets.only(right: 5),

                  child: Column(children: [
                    Image.asset("assets/icons/padlock.png",
                        width: 20, height: 20, color: Color(0xff42c98d)),
                  ]),
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: const Color(0xff57d77a), width: 1),
                  borderRadius: BorderRadius.circular(10)),
              floatingLabelStyle: const TextStyle(
                  color: const Color(0xff57d77a),
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0xff57d77a), width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            validator: (value) {
              if (OldValue != DPassword.text) {
                save = true;
              }

              if (value!.isEmpty)
                return "أرجو منك تعبئه الحقل الفارغ ";
              else {
                return null;
              }
            },
          ),
        );
        break;
    }
    return Fields;
  }

  GetMainPage(height, isSaved) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(252, 253, 255, 1),
        extendBodyBehindAppBar: true,
        key: _scaffoldKey,
        // appBar: AppBar(title: Text("Faten")),

        body: NotificationListener<ScrollNotification>(
          onNotification: _scrollListener,
          child: Container(
            height: double.infinity,
            child: Stack(children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Get.height * 0.4,
                      child: Stack(
                        children: [
                          Container(
                            height: _headerHeight,
                            child: HeaderWidget(
                                _headerHeight,
                                false,
                                Icons
                                    .login_rounded), //let's create a common header widget
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: 120,
                              height: 120,
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 255, 244, 244),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xff57d77a).withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Center(
                                  child: Icon(
                                Icons.person,
                                size: 60,
                                color: Color(0xff57d77a).withOpacity(0.4),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Form(
                        key: formKey,
                        child: Column(children: [
                          InkWell(
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  /* Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Positioned(
                                          left: 0.0,
                                          child: Icon(
                                            Icons.arrow_back_ios_outlined,
                                            color: const Color(0xff57d77a),
                                            size: 16,
                                          ),
                                        ),
                                      ),*/
                                  Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 2, bottom: 10),
                                      child: Text(
                                        style: GoogleFonts.poppins(
                                            fontSize: 13.5,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(
                                                255, 188, 187, 187)),
                                        parentx.Name,
                                        maxLines: 2,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          right: 10, bottom: 10),
                                      child: Text(
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff57d77a)),
                                        'اسم المفوض',
                                        maxLines: 2,
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color: const Color(0xff57d77a)),
                                ),
                              ),
                            ),
                            /* onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => Nav(
                                      TabValue: 5,
                                      index: 1,
                                      documentId: widget.documentId,
                                      TheValue: parentName.text,
                                      whichpag: 1,
                                      Confirm: false,
                                      DropDown: isDrop,
                                    ),
                                  ));
                                },*/
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          InkWell(
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  /* Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Positioned(
                                          left: 0.0,
                                          child: Icon(
                                            Icons.arrow_back_ios_outlined,
                                            color: const Color(0xff57d77a),
                                            size: 16,
                                          ),
                                        ),
                                      ),*/
                                  Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 2, bottom: 10),
                                      child: Text(
                                        style: GoogleFonts.poppins(
                                            fontSize: 13.5,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(
                                                255, 188, 187, 187)),
                                        parentx.DUserName,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          right: 10, bottom: 10),
                                      child: Text(
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff57d77a)),
                                        'اسم المستخدم',
                                        maxLines: 2,
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color: const Color(0xff57d77a)),
                                ),
                              ),
                            ),
                            /*onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => Nav(
                                      TabValue: 5,
                                      index: 2,
                                      documentId: widget.documentId,
                                      TheValue: parentName.text,
                                      whichpag: 1,
                                      Confirm: false,
                                      DropDown: isDrop,
                                    ),
                                  ));
                                },*/
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          InkWell(
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  /*Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Positioned(
                                          left: 0.0,
                                          child: Icon(
                                            Icons.arrow_back_ios_outlined,
                                            color: const Color(0xff57d77a),
                                            size: 16,
                                          ),
                                        ),
                                      ),*/
                                  Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 2, bottom: 10),
                                      child: Text(
                                        style: GoogleFonts.poppins(
                                            fontSize: 13.5,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(
                                                255, 188, 187, 187)),
                                        parentx.Email,
                                        maxLines: 2,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          right: 10, bottom: 10),
                                      child: Text(
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff57d77a)),
                                        "البريد الالكتروني ",
                                        maxLines: 2,
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color: const Color(0xff57d77a)),
                                ),
                              ),
                            ),
                            /* onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => Nav(
                                      TabValue: 5,
                                      index: 3,
                                      documentId: widget.documentId,
                                      TheValue: parentName.text,
                                      whichpag: 1,
                                      Confirm: false,
                                      DropDown: isDrop,
                                    ),
                                  ));
                                },*/
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          InkWell(
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  /* Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Positioned(
                                          left: 0.0,
                                          child: Icon(
                                            Icons.arrow_back_ios_outlined,
                                            color: const Color(0xff57d77a),
                                            size: 16,
                                          ),
                                        ),
                                      ),*/
                                  Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 2, bottom: 10),
                                      child: Text(
                                        style: GoogleFonts.poppins(
                                            fontSize: 13.5,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(
                                                255, 188, 187, 187)),
                                        parentx.DNationalID,
                                        maxLines: 2,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          right: 10, bottom: 10),
                                      child: Text(
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff57d77a)),
                                        "رقم الهوية/الإقامة",
                                        maxLines: 2,
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color: const Color(0xff57d77a)),
                                ),
                              ),
                            ),
                            /* onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => Nav(
                                      TabValue: 5,
                                      index: 4,
                                      documentId: widget.documentId,
                                      TheValue: parentName.text,
                                      whichpag: 1,
                                      Confirm: false,
                                      DropDown: isDrop,
                                    ),
                                  ));
                                },*/
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          InkWell(
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  /* Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Positioned(
                                          left: 0.0,
                                          child: Icon(
                                            Icons.arrow_back_ios_outlined,
                                            color: const Color(0xff57d77a),
                                            size: 16,
                                          ),
                                        ),
                                      ),*/

                                  Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 2, bottom: 10),
                                      child: Text(
                                        style: GoogleFonts.poppins(
                                            fontSize: 13.5,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(
                                                255, 188, 187, 187)),
                                        parentx.Password,
                                        maxLines: 2,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          right: 10, bottom: 10),
                                      child: Text(
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff57d77a)),
                                        "الرقم السري",
                                        maxLines: 2,
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color: const Color(0xff57d77a)),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => Nav(
                                  TabValue: 5,
                                  index: 8,
                                  documentId: widget.documentId,
                                  TheValue: DName.text,
                                  whichpag: 1,
                                  Confirm: false,
                                  DropDown: isDrop,
                                ),
                              ));
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          )
                        ]),
                      ),
                    ),
                    Center(
                      child: new Wrap(
                          spacing: 5.0,
                          runSpacing: 5.0,
                          direction:
                              Axis.vertical, // main axis (rows or columns)
                          children: <Widget>[
                            CupertinoButton(
                              child: Expanded(
                                child: Container(
                                  // padding:
                                  // padding: EdgeInsets.only(right: 4),
                                  //   EdgeInsets.symmetric(horizontal: 120),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1.0,
                                          color: const Color(0xff57d77a)),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Flexible(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.center,
                                                padding:
                                                    EdgeInsets.only(right: 4),
                                                child: Positioned(
                                                  left: 0,
                                                  child: Icon(
                                                    Icons
                                                        .arrow_circle_down_rounded,
                                                    // Icons.arrow_downward_outlined,
                                                    color:
                                                        const Color(0xff57d77a),
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.only(
                                                      right: 120),
                                                  child: Text(
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Color.fromARGB(
                                                            255,
                                                            188,
                                                            187,
                                                            187)),
                                                    Dvalue,
                                                    maxLines: 2,
                                                    // textAlign: TextAlign.left,
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    padding: EdgeInsets.only(
                                                      left: 80,
                                                    ),
                                                    // child: Padding(
                                                    //  padding: const EdgeInsets.only(
                                                    //      right: 12, top: 9, left: 9),
                                                    child: Container(
                                                      //  padding: const EdgeInsets.only(right: 5),

                                                      child: Row(children: [
                                                        Text(
                                                          style: GoogleFonts.poppins(
                                                              fontSize: 14,
                                                              color: const Color(
                                                                  0xff57d77a)),
                                                          'الحالة',
                                                          maxLines: 2,
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Image.asset(
                                                            "assets/icons/family.png",
                                                            width: 15,
                                                            height: 15,
                                                            color: Color(
                                                                0xff42c98d)),
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
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: 200.0,
                                        color: Colors.white,
                                        child: Row(
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
                                                scrollController:
                                                    scrollController,
                                                looping: false,
                                                itemExtent: 64,
                                                backgroundColor: Colors.white,
                                                onSelectedItemChanged: (index) {
                                                  print(index);

                                                  DEIndex = index;
                                                  print(DEIndex);
                                                  final item = State[DEIndex];
                                                  DEIndex = index;
                                                  controller.text = item;
                                                  Dvalue = item;
                                                },
                                                children:
                                                    State.map((item) => Center(
                                                            child: Text(
                                                          item,
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ))).toList(),
                                              ),
                                            ),
                                            CupertinoButton(
                                              child: Text("موافق",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 17,
                                                      color: const Color(
                                                          0xff57d77a))),
                                              onPressed: () {
                                                scrollController =
                                                    FixedExtentScrollController(
                                                        initialItem:
                                                            _changedNumber);
                                                //scrollController.dispose();
                                                setState(() {
                                                  _selectedNumber =
                                                      _changedNumber;
                                                });
                                                isDrop == true;
                                                widget.isDropDown = true;
                                                Dvalue = State[DEIndex];
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
                    SizedBox(
                      height: 32.0,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
              Container(
                height: 55,
                child: AnimatedBuilder(
                  animation: _ColorAnimationController,
                  builder: (context, child) => AppBar(
                    iconTheme: IconThemeData(
                      color: _iconColorTween.value,
                    ),
                    automaticallyImplyLeading: false,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(right: 5),
                          child: CupertinoButton(
                            child: Text(
                              "حفظ",
                              style: TextStyle(
                                  color: _icon2ColorTween.value,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              if (isSaved != true) {
                                Navigator.pop(context);
                              }
                              print(isSaved);
                              if (isSaved == true || widget.isDropDown) {
                                showCupertinoDialog(
                                    context: context, builder: CreateDialog2);
                              }
                              await parentx.UpdateDelegator(
                                  widget.documentId, "State", Dvalue);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 55,
                        ),
                        /*onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => Nav(
                                      TabValue: 5,
                                      index: 5,
                                      documentId: widget.documentId,
                                      TheValue: parentName.text,
                                      whichpag: 1,
                                      Confirm: false,
                                      DropDown: isDrop,
                                    ),
                                  ));
                                },*/
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }

  Widget buildPicker() => Column(children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Positioned(
                  left: 0.0,
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Color(0xffA7A7A7),
                    size: 16,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: Text(
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffA7A7A7)),
                    'فيصل الشمري',
                    maxLines: 2,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 10, bottom: 10),
                  child: Text(
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffA7A7A7)),
                    'اسم المفوض',
                    maxLines: 2,
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Color(0xffA7A7A7)),
            ),
          ),
        ),

        /* greenButton('حفظ', () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                }),*/
      ]);

  WhichColor() {
    if (isEmailCorrect == false) {
      return Colors.grey.shade200;
    } else {
      return Colors.green;
    }
  }

  Widget IsCorrect() {
    if (isEmailCorrect == false) {
      return Text("");
    } else {
      return const Icon(
        Icons.done,
        color: Colors.green,
      );
    }
  }

  Widget CreateDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: const Text("تجاهل التغييرات",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromRGBO(31, 31, 31, 1),
              fontWeight: FontWeight.bold)),
      content: const Text("إذا عدت الآن، فستفقد التغييرات",
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => Nav(
                            TabValue: 10,
                            documentId: widget.documentId,
                          )));
            },
            child: const Text("تجاهل التغييرات",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromARGB(255, 197, 24, 24),
                    fontWeight: FontWeight.bold))),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("الاستمرار في التحرير"),
        ),
      ],
    );
  }

  Widget CreateDialog3(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: const Text("تجاهل التغييرات",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold)),
      content: const Text("إذا عدت الآن، فستفقد التغييرات",
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => Nav(
                            TabValue: 5,
                            documentId: widget.documentId,
                            index: 1,
                            Confirm: false,
                            TheValue: "",
                            whichpag: 0,
                            DropDown: isDrop,
                          )));
            },
            child: const Text("تجاهل التغييرات",
                style: TextStyle(
                    color: const Color(0xff42c98d),
                    fontWeight: FontWeight.bold))),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("الاستمرار في التحرير"),
        ),
      ],
    );
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

  dynamic snackBar = SnackBar(
    duration: const Duration(milliseconds: 1500),
    content: Row(mainAxisAlignment: MainAxisAlignment.end, children: const [
      Text(
        "المعلومات الشخصيه",
        textAlign: TextAlign.right,
        style: TextStyle(
          color: Color(0xffA7A7A7),
        ),
      ),
      Icon(
        FontAwesomeIcons.check,
        size: 16,
        color: Color(0xffA7A7A7),
      ),
    ]),
  );

  Widget CreateDialog2(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: const Text("تحديث معلومات المفوض",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromRGBO(31, 31, 31, 1),
              fontWeight: FontWeight.bold)),
      content: const Text("تم تحديث المعلومات بنجاح",
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromRGBO(31, 31, 31, 1))),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) =>
                      DelegatorHome(userName: Name, user: "Delegator")));
            },
            child: const Text("موافق",
                style: TextStyle(
                    color: const Color(0xff42c98d),
                    fontWeight: FontWeight.bold))),
      ],
    );
  }
}
