import 'package:circlight/Pages/Student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:circlight/utils/app_colors.dart';
import 'package:circlight/Pages/header_widget.dart';
import 'Nav.dart';
import 'Parent.dart';
import 'constants.dart';
import 'displayParent.dart';
import 'package:country_picker/country_picker.dart';

class CreateStudent extends StatefulWidget {
  var index;
  var Blood;
  var Class;
  var Name;
  var username;
  var SID;
  var ID;
  var nationality;
  var phone1;
  var phone2;
  var job;
  var documentId;
  var header;

  CreateStudent(
      {super.key,
      this.index,
      this.Class,
      this.Blood,
      this.ID,
      this.Name,
      this.username,
      this.SID,
      this.nationality,
      this.job,
      required this.documentId,
      this.header});

  @override
  State<CreateStudent> createState() => _CreateStudentState();
}

class _CreateStudentState extends State<CreateStudent>
    with TickerProviderStateMixin {
  int _changedNumber = 0, _selectedNumber = 1;
  late String Numvalue = "-";
  final ClassNum = ["-", "1", "2", "3", "4", "5", "6"];
  final Blood = ["-", "O+", "A+", "B+", "AB+", "O-", "A-", "B-", "AB-"];
  late var blood = "-";
  Student Studentx = new Student(
    Name: "",
    Class: "",
    SNationalID: "",
    SNationality: "",
    SUserName: "",
    SBloodType: "",
  );
  String currentID = "";
  List<String> docIDs = [];
  List<String> docUserName = [];
  List<String> docAdmin = [];
// to get admin id
  Future getAdminID() async {
    await FirebaseFirestore.instance.collection("Admin").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            // print(document["Email"]);
            docAdmin.add(document.reference.id);
          }),
        );
  }

// to get all the user name
  Future getUserName() async {
    await FirebaseFirestore.instance.collection("Student").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            docUserName.add(document["UserName"]);
          }),
        );
  }

  late TextEditingController controller;
  var Real;
  late FixedExtentScrollController scrollController;
  late AnimationController _ColorAnimationController;
  late AnimationController _TextAnimationController;
  late Animation _colorTween, _iconColorTween, _icon2ColorTween;
  late Animation<Offset> _transTween;
  int NumIndex = 0;
  void initState() {
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
    scrollController = FixedExtentScrollController(initialItem: NumIndex);
    controller = TextEditingController(text: ClassNum[NumIndex]);
    super.initState();
  }

  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  String name = "";

  double _headerHeight = 250;
  TextEditingController studentName = TextEditingController();
  TextEditingController Studentusername = TextEditingController();
  TextEditingController StudentIDNo = TextEditingController();
  TextEditingController StudentNationality = TextEditingController();
  TextEditingController StudentNationalID = TextEditingController();
  TextEditingController Studentclass = TextEditingController();
  TextEditingController StudentBloodType = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Real = List<String>.filled(5, "");
    getUserName();
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    CollectionReference student =
        FirebaseFirestore.instance.collection("Student");

    return Scaffold(
      backgroundColor: Color.fromRGBO(252, 253, 255, 1),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      // appBar: AppBar(title: Text("Faten")),
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
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: formKey,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                      controller: studentName,
                                      //  controller: parentUserName..text = parentx.PUserName,
                                      //to take text from user input
                                      textAlign: TextAlign.right,

                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          //fontWeight: FontWeight.w600,
                                          color: Colors.grey),
                                      showCursor: true,
                                      cursorColor: const Color(0xff57d77a),

                                      decoration: InputDecoration(
                                        labelText: "أدخل أسم الطالب",
                                        hintText: " اسم الطالب ",
                                        hintStyle: const TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                        labelStyle: const TextStyle(
                                            color: const Color(0xff57d77a),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 12, top: 9, left: 9),
                                          child: Container(
                                            //  padding: const EdgeInsets.only(right: 5),

                                            child: Column(children: [
                                              Image.asset(
                                                  "assets/icons/name.png",
                                                  width: 20,
                                                  height: 20,
                                                  color: Color(0xff42c98d)),
                                            ]),
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xff57d77a),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        floatingLabelStyle: const TextStyle(
                                            color: const Color(0xff57d77a),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: const Color(0xff57d77a),
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty)
                                          return "أرجو منك تعبئه الحقل الفارغ ";
                                        else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                      controller: Studentusername,
                                      //  controller: parentUserName..text = parentx.PUserName,
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
                                        hintStyle: const TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                        labelStyle: const TextStyle(
                                            color: const Color(0xff57d77a),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                        prefixIcon: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Icon(
                                            Icons.person,
                                            size: 22,
                                            color: const Color(0xff42c98d),
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xff57d77a),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        floatingLabelStyle: const TextStyle(
                                            color: const Color(0xff57d77a),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: const Color(0xff57d77a),
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty)
                                          return "أرجو منك تعبئه الحقل الفارغ ";
                                        else {
                                          for (var i = 0;
                                              i < docUserName.length;
                                              i++) {
                                            if (value == docUserName[i]) {
                                              return "اسم المستخدم مستخدم مسبقا ";
                                            }
                                          }
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                      onTap: () {
                                        showCountryPicker(
                                          exclude: [""],

                                          context: context,

                                          showPhoneCode:
                                              false, // optional. Shows phone code before the country name.

                                          onSelect: (Country country) {
                                            StudentNationality.text = country
                                                .displayNameNoCountryCode;

                                            print(
                                                'Select country: ${country.displayName}');
                                          },
                                        );
                                      },

                                      readOnly: true,
                                      controller: StudentNationality,
                                      //  controller: parentUserName..text = parentx.PUserName,
                                      //to take text from user input
                                      textAlign: TextAlign.right,

                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          //fontWeight: FontWeight.w600,
                                          color: Colors.grey),
                                      showCursor: true,
                                      cursorColor: const Color(0xff57d77a),

                                      decoration: InputDecoration(
                                        hintText: "ماهي جنسيتك؟",
                                        labelText: "الجنسية",
                                        hintStyle: const TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                        labelStyle: const TextStyle(
                                            color: const Color(0xff57d77a),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 12, top: 9, left: 9),
                                          child: Container(
                                            //  padding: const EdgeInsets.only(right: 5),

                                            child: Column(children: [
                                              Image.asset(
                                                  "assets/icons/Nationality.png",
                                                  width: 20,
                                                  height: 20,
                                                  color: Color(0xff42c98d)),
                                            ]),
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xff57d77a),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        floatingLabelStyle: const TextStyle(
                                            color: const Color(0xff57d77a),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: const Color(0xff57d77a),
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty)
                                          return "أرجو منك تعبئه الحقل الفارغ ";
                                        else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                      controller: StudentNationalID,
                                      //  controller: parentUserName..text = parentx.PUserName,
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
                                        labelText: "رقم الهوية /الإقامة",
                                        hintText: "أدخل رقم الهوية /الإقامة",
                                        hintStyle: const TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                        labelStyle: const TextStyle(
                                            color: const Color(0xff57d77a),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 12, top: 9, left: 9),
                                          child: Container(
                                            //  padding: const EdgeInsets.only(right: 5),

                                            child: Column(children: [
                                              Image.asset("assets/icons/ID.png",
                                                  width: 20,
                                                  height: 20,
                                                  color: Color(0xff42c98d)),
                                            ]),
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xff57d77a),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        floatingLabelStyle: const TextStyle(
                                            color: const Color(0xff57d77a),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: const Color(0xff57d77a),
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            !RegExp(r'^[0-9]{10}$')
                                                .hasMatch(value!))
                                          return "أرجو منك تعبئه الحقل بطريقه صحيحه حيث يتكون من 10 ارقام";
                                        else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: new Wrap(
                                        spacing: 5.0,
                                        runSpacing: 5.0,
                                        direction: Axis
                                            .vertical, // main axis (rows or columns)
                                        children: <Widget>[
                                          CupertinoButton(
                                            child: Expanded(
                                              child: Container(
                                                width: 307,
                                                margin:
                                                    EdgeInsets.only(right: 20),
                                                // padding:
                                                //width: 300,
                                                // padding: EdgeInsets.only(right: 4),
                                                //   EdgeInsets.symmetric(horizontal: 120),
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                        width: 1.0,
                                                        color: const Color(
                                                            0xff57d77a)),
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
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              // padding: EdgeInsets.only(right: 4),
                                                              child: Positioned(
                                                                left: 0,
                                                                child: Icon(
                                                                  Icons
                                                                      .arrow_circle_down_rounded,
                                                                  // Icons.arrow_downward_outlined,
                                                                  color: const Color(
                                                                      0xff57d77a),
                                                                  size: 16,
                                                                ),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Container(
                                                                width: 22,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                //  padding: EdgeInsets.only(right: 120),
                                                                child: Text(
                                                                  style: GoogleFonts.poppins(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: const Color(
                                                                          0xff57d77a)),
                                                                  Numvalue,
                                                                  maxLines: 2,
                                                                  // textAlign: TextAlign.left,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 150,
                                                            ),
                                                            Row(children: [
                                                              Text(
                                                                style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        17,
                                                                    color: const Color(
                                                                        0xff57d77a)),
                                                                'صف الطالب',
                                                                maxLines: 2,
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Image.asset(
                                                                  "assets/icons/Class.png",
                                                                  width: 15,
                                                                  height: 15,
                                                                  color: Color(
                                                                      0xff42c98d)),
                                                            ]),
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
                                                  builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                      height: 200.0,
                                                      color: Colors.white,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          CupertinoButton(
                                                            child: Text(
                                                              "إلغاء",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 17,
                                                                color: Color(
                                                                    0xffA7A7A7),
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                          Expanded(
                                                            child:
                                                                CupertinoPicker(
                                                              scrollController:
                                                                  scrollController,
                                                              looping: false,
                                                              itemExtent: 64,
                                                              backgroundColor:
                                                                  Colors.white,
                                                              onSelectedItemChanged:
                                                                  (index) {
                                                                print(index);

                                                                widget.index =
                                                                    index;
                                                                print(widget
                                                                    .index);
                                                                final item =
                                                                    ClassNum[widget
                                                                        .index];
                                                                widget.index =
                                                                    index;
                                                                controller
                                                                        .text =
                                                                    item;
                                                                Numvalue = item;
                                                              },
                                                              children: ClassNum
                                                                  .map((item) =>
                                                                      Center(
                                                                          child:
                                                                              Text(
                                                                        item,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20),
                                                                      ))).toList(),
                                                            ),
                                                          ),
                                                          CupertinoButton(
                                                            child: Text("موافق",
                                                                style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        17,
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
                                                              Navigator.pop(
                                                                  context);
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
                                  Center(
                                    child: new Wrap(
                                        spacing: 5.0,
                                        runSpacing: 5.0,
                                        direction: Axis
                                            .vertical, // main axis (rows or columns)
                                        children: <Widget>[
                                          CupertinoButton(
                                            child: Expanded(
                                              child: Container(
                                                width: 307,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                        width: 1.0,
                                                        color: const Color(
                                                            0xff57d77a)),
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
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right: 4),
                                                              child: Positioned(
                                                                left: 0,
                                                                child: Icon(
                                                                  Icons
                                                                      .arrow_circle_down_rounded,
                                                                  // Icons.arrow_downward_outlined,
                                                                  color: const Color(
                                                                      0xff57d77a),
                                                                  size: 16,
                                                                ),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            120),
                                                                child: Text(
                                                                  style: GoogleFonts.poppins(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: const Color(
                                                                          0xff57d77a)),
                                                                  blood,
                                                                  maxLines: 2,
                                                                  // textAlign: TextAlign.left,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 30,
                                                            ),
                                                            Row(children: [
                                                              Text(
                                                                style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        14,
                                                                    color: const Color(
                                                                        0xff57d77a)),
                                                                'فصيلة الدم ',
                                                                maxLines: 2,
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Image.asset(
                                                                  "assets/icons/Blood.png",
                                                                  width: 15,
                                                                  height: 15,
                                                                  color: Color(
                                                                      0xff42c98d)),
                                                            ]),
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
                                                  builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                      height: 200.0,
                                                      color: Colors.white,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          CupertinoButton(
                                                            child: Text("لغاء",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xffA7A7A7),
                                                                    fontSize:
                                                                        16)),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                          Expanded(
                                                            child:
                                                                CupertinoPicker(
                                                              scrollController:
                                                                  scrollController,
                                                              looping: false,
                                                              itemExtent: 64,
                                                              backgroundColor:
                                                                  Colors.white,
                                                              onSelectedItemChanged:
                                                                  (index) {
                                                                print(index);

                                                                widget.index =
                                                                    index;

                                                                final item =
                                                                    Blood[widget
                                                                        .index];
                                                                widget.index =
                                                                    index;
                                                                controller
                                                                        .text =
                                                                    item;
                                                                blood = item;
                                                              },
                                                              children: Blood
                                                                  .map((item) =>
                                                                      Center(
                                                                          child:
                                                                              Text(
                                                                        item,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20),
                                                                      ))).toList(),
                                                            ),
                                                          ),
                                                          CupertinoButton(
                                                            child: Text("موافق",
                                                                style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        17,
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
                                                              Navigator.pop(
                                                                  context);
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
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                              //////////////
                              ///
                              ///
                              ///
                              ///
                              Hero(
                                tag: "btn",
                                child: Center(
                                  child: Container(
                                    height: 50,
                                    width: 400,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            const Color(0xff42c98d),
                                            const Color(0xff42c98d),
                                            const Color(0xff0da6c2),

                                            //add more colors
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color: Color.fromRGBO(0, 0, 0,
                                                    0.57), //shadow for button
                                                blurRadius:
                                                    5) //blur radius of shadow
                                          ]),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              Color.fromARGB(0, 255, 255, 255),
                                          onSurface: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          //make color or elevated button transparent
                                        ),
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            await Studentx.addStudent(
                                                widget.documentId,
                                                studentName.text,
                                                Studentusername.text,
                                                StudentNationalID.text,
                                                StudentNationality.text,
                                                Numvalue,
                                                blood,
                                                "gqvxZab1CsHCgT9kZgel");

                                            showCupertinoDialog(
                                                context: context,
                                                builder: CreateDialog);
                                          }
                                        }
                                        //  if (formKey.currentState!.validate()) {}
                                        ,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 18,
                                            right: 18,
                                          ),
                                          child: Text(
                                            "أضافة",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          )),
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
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: widget.header
                                      ? CupertinoButton(
                                          child: Text(
                                            "إضافة",
                                            style: TextStyle(
                                                color: _icon2ColorTween.value,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onPressed: () async {
                                            if (formKey.currentState!
                                                .validate()) {
                                              await Studentx.addStudent(
                                                  widget.documentId,
                                                  widget.Name,
                                                  widget.username,
                                                  StudentNationalID.text,
                                                  widget.nationality,
                                                  Numvalue,
                                                  blood,
                                                  "gqvxZab1CsHCgT9kZgel");

                                              showCupertinoDialog(
                                                  context: context,
                                                  builder: CreateDialog);
                                            }
                                            //  if (formKey.currentState!.validate()) {}
                                          },
                                        )
                                      : Text("         "),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      "إنشاء معلومات الطالب",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: _iconColorTween.value),
                                    ),
                                  ),
                                ),
                              ]),
                        ]),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => Nav(
                                        TabValue: 10,
                                      )));
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: _iconColorTween.value,
                        ),
                        color: _iconColorTween.value,
                      ),
                    ],
                    backgroundColor: _colorTween.value,
                    elevation: 0,
                    titleSpacing: 0.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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

  Widget greenButton(String title, Function onPressed) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xff348379),
            const Color(0xff305565),
            const Color(0xff2d2e53)
          ],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: MaterialButton(
        minWidth: Get.width,
        height: 50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onPressed: () => onPressed(),
        child: Text(
          title,
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget GetWidget(Index) {
    Widget Fields = Text("");

    switch (Index) {
      case 1:
        Fields = Column(
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: studentName,
                //  controller: parentUserName..text = parentx.PUserName,
                //to take text from user input
                textAlign: TextAlign.right,

                style: GoogleFonts.poppins(
                    fontSize: 14,
                    //fontWeight: FontWeight.w600,
                    color: Colors.grey),
                showCursor: true,
                cursorColor: const Color(0xff57d77a),

                decoration: InputDecoration(
                  labelText: "أدخل أسم الطالب",
                  hintText: " اسم الطالب ",
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
                  if (value!.isEmpty)
                    return "أرجو منك تعبئه الحقل الفارغ ";
                  else {
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: Studentusername,
                //  controller: parentUserName..text = parentx.PUserName,
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
                  if (value!.isEmpty)
                    return "أرجو منك تعبئه الحقل الفارغ ";
                  else {
                    for (var i = 0; i < docUserName.length; i++) {
                      if (value == docUserName[i]) {
                        return "اسم المستخدم مستخدم مسبقا ";
                      }
                    }
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: StudentNationality,
                //  controller: parentUserName..text = parentx.PUserName,
                //to take text from user input
                textAlign: TextAlign.right,

                style: GoogleFonts.poppins(
                    fontSize: 14,
                    //fontWeight: FontWeight.w600,
                    color: Colors.grey),
                showCursor: true,
                cursorColor: const Color(0xff57d77a),

                decoration: InputDecoration(
                  hintText: "ماهي جنسيتك؟",
                  labelText: "الجنسية",
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
                        Image.asset("assets/icons/Nationality.png",
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
                  if (value!.isEmpty)
                    return "أرجو منك تعبئه الحقل الفارغ ";
                  else {
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment(-0.99, 0.9),
              child: Container(
                height: 40.0,
                width: 40.0,
                child: FittedBox(
                  child: FloatingActionButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => Nav(
                            TabValue: 8,
                            documentId: widget.documentId,
                            index: 2,
                            Name: studentName.text,
                            username: Studentusername.text,
                            nationality: StudentNationality.text,
                            header: true,
                          ),
                        ));
                      }
                    },
                    elevation: 0,
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(90),
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xff0da6c2),
                            const Color(0xff57d77a)
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Color.fromARGB(0, 255, 253, 253),
                  ),
                ),
              ),
            ),
          ],
        );

        break;
      case 2:
        Fields = Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: StudentNationalID,
                //  controller: parentUserName..text = parentx.PUserName,
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
                  labelText: "رقم الهوية /الإقامة",
                  hintText: "أدخل رقم الهوية /الإقامة",
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
                  if (value!.isEmpty ||
                      !RegExp(r'^[0-9]{10}$').hasMatch(value!))
                    return "أرجو منك تعبئه الحقل بطريقه صحيحه حيث يتكون من 10 ارقام";
                  else {
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: new Wrap(
                  spacing: 5.0,
                  runSpacing: 5.0,
                  direction: Axis.vertical, // main axis (rows or columns)
                  children: <Widget>[
                    CupertinoButton(
                      child: Expanded(
                        child: Container(
                          width: 307,
                          margin: EdgeInsets.only(right: 20),
                          // padding:
                          //width: 300,
                          // padding: EdgeInsets.only(right: 4),
                          //   EdgeInsets.symmetric(horizontal: 120),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1.0, color: const Color(0xff57d77a)),
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
                                        // padding: EdgeInsets.only(right: 4),
                                        child: Positioned(
                                          left: 0,
                                          child: Icon(
                                            Icons.arrow_circle_down_rounded,
                                            // Icons.arrow_downward_outlined,
                                            color: const Color(0xff57d77a),
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: 22,
                                          alignment: Alignment.center,
                                          //  padding: EdgeInsets.only(right: 120),
                                          child: Text(
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xff57d77a)),
                                            Numvalue,
                                            maxLines: 2,
                                            // textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 150,
                                      ),
                                      Row(children: [
                                        Text(
                                          style: GoogleFonts.poppins(
                                              fontSize: 17,
                                              color: const Color(0xff57d77a)),
                                          'صف الطالب',
                                          maxLines: 2,
                                          textAlign: TextAlign.right,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset("assets/icons/Class.png",
                                            width: 15,
                                            height: 15,
                                            color: Color(0xff42c98d)),
                                      ]),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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

                                          Index = index;
                                          print(Index);
                                          final item = ClassNum[Index];
                                          Index = index;
                                          controller.text = item;
                                          Numvalue = item;
                                        },
                                        children: ClassNum.map((item) => Center(
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
                                              color: const Color(0xff57d77a))),
                                      onPressed: () {
                                        scrollController =
                                            FixedExtentScrollController(
                                                initialItem: _changedNumber);
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
            Center(
              child: new Wrap(
                  spacing: 5.0,
                  runSpacing: 5.0,
                  direction: Axis.vertical, // main axis (rows or columns)
                  children: <Widget>[
                    CupertinoButton(
                      child: Expanded(
                        child: Container(
                          width: 307,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1.0, color: const Color(0xff57d77a)),
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
                                        padding: EdgeInsets.only(right: 4),
                                        child: Positioned(
                                          left: 0,
                                          child: Icon(
                                            Icons.arrow_circle_down_rounded,
                                            // Icons.arrow_downward_outlined,
                                            color: const Color(0xff57d77a),
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(right: 120),
                                          child: Text(
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xff57d77a)),
                                            blood,
                                            maxLines: 2,
                                            // textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Row(children: [
                                        Text(
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: const Color(0xff57d77a)),
                                          'فصيلة الدم ',
                                          maxLines: 2,
                                          textAlign: TextAlign.right,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset("assets/icons/Blood.png",
                                            width: 15,
                                            height: 15,
                                            color: Color(0xff42c98d)),
                                      ]),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    CupertinoButton(
                                      child: Text("لغاء",
                                          style: TextStyle(
                                              color: Color(0xffA7A7A7),
                                              fontSize: 16)),
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

                                          Index = index;
                                          print(Index);
                                          final item = Blood[Index];
                                          Index = index;
                                          controller.text = item;
                                          blood = item;
                                        },
                                        children: Blood.map((item) => Center(
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
                                              color: const Color(0xff57d77a))),
                                      onPressed: () {
                                        scrollController =
                                            FixedExtentScrollController(
                                                initialItem: _changedNumber);
                                        //scrollController.dispose();
                                        setState(() {
                                          _selectedNumber = _changedNumber;
                                        });
                                        Navigator.pop(context);
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
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text("            "),
                const SizedBox(
                  width: 100,
                ),
                const SizedBox(
                  width: 100,
                ),
                /*const SizedBox(
                  width: 100,
                ),*/
                Align(
                  alignment: Alignment(0.80, 0.9),
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    child: FittedBox(
                      child: FloatingActionButton(
                        onPressed: () async {
                          Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => Nav(
                                TabValue: 8,
                                documentId: widget.documentId,
                                index: 1,
                                Name: studentName.text,
                                username: Studentusername.text,
                                nationality: widget.nationality,
                                header: false),
                          ));

                          //  if (formKey.currentState!.validate()) {}
                        },
                        elevation: 0,
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 6,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(90),
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xff0da6c2),
                                const Color(0xff57d77a)
                              ],
                            ),
                          ),
                          child: Icon(
                            Icons.arrow_forward_outlined,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Color.fromARGB(0, 255, 253, 253),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 50,
            ),
            const SizedBox(
              width: 50,
            ),
          ],
        );

        break;
    }
    return Fields;
  }

  Widget CreateDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: Text("إضافة طالب",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Color.fromRGBO(31, 31, 31, 1),
              fontWeight: FontWeight.bold)),
      content: Text(
        "تم إضافة المعلومات بنجاح",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => Nav(
                          TabValue: 10,
                          documentId: widget.documentId,
                        ))),
            child: Text("موافق",
                style: TextStyle(
                  color: const Color(0xff57d77a),
                  fontWeight: FontWeight.bold,
                ))),
      ],
    );
  }
}
