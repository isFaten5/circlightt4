import 'package:circlight/Pages/editStudent.dart';
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
import 'package:connectivity_plus/connectivity_plus.dart';
import 'Parent.dart';
import 'constants.dart';
import 'displayParent.dart';
import 'dart:math';
import 'package:share_plus/share_plus.dart';
import 'package:country_picker/country_picker.dart';

class Createparent5 extends StatefulWidget {
  int index;
  var Realtion;
  var Name;
  var username;
  var email;
  var ID;
  var nationality;
  var phone1;
  var phone2;
  var job;
  var header;

  Createparent5(
      {super.key,
      required this.index,
      this.Realtion,
      this.ID,
      this.Name,
      this.username,
      this.email,
      this.nationality,
      this.job,
      this.phone1,
      this.phone2,
      this.header});

  @override
  State<Createparent5> createState() => _CreateState();
}

class _CreateState extends State<Createparent5> with TickerProviderStateMixin {
  int _changedNumber = 0, _selectedNumber = 1;
  late String value = "-";
  final Relation = ["-", "أم", "أب", "أخت", "أخ", "خالة", "خال", "عمة", "عم"];
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
  //defining a lists
  List<String> docEmails = [];
  List<String> docUserName = [];
  List<String> docAdmin = [];
  var isAdded = true;

//for Email uniqueness
  Future getEmail() async {
    await FirebaseFirestore.instance.collection("Parent").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            // print(document["Email"]);
            docEmails.add(document["Email"]);
          }),
        );
  }

//for username uniqueness
  Future getUserName() async {
    await FirebaseFirestore.instance.collection("Parent").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            docUserName.add(document["UserName"]);
          }),
        );
  }

  //get admin ID
  Future getAdminID() async {
    await FirebaseFirestore.instance.collection("Admin").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            // print(document["Email"]);
            docAdmin.add(document.reference.id);
          }),
        );
  }

// to control the apearance of the buttons
  bool issahre = false;
  bool isshowadd = true;
  //to generate a random password
  var k = Random().nextInt(10000) + 10000000000000000;
  late TextEditingController controller;
  var Real;
  late FixedExtentScrollController scrollController;
  late AnimationController _ColorAnimationController;
  late AnimationController _TextAnimationController;
  late Animation _colorTween, _iconColorTween, _icon2ColorTween;
  late Animation<Offset> _transTween;
  int Index = 0;
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
    scrollController = FixedExtentScrollController(initialItem: Index);
    controller = TextEditingController(text: Relation[Index]);
    super.initState();
  }

  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   scrollController.dispose();
  //   controller.dispose();
  //   parentName.dispose();
  //   Parentusername.dispose();
  //   email.dispose();
  //   Parentusername.dispose();
  //   ParentIDNo.dispose();
  //   nationality.dispose();
  //   jobTitle.dispose();
  //   phoneNumber.dispose();
  //   altphoneNumber.dispose();
  //   RelativeRelation.dispose();
  // }

  String name = "";

  double _headerHeight = 250;
  TextEditingController parentName = TextEditingController();
  TextEditingController Parentusername = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController ParentIDNo = TextEditingController();
  TextEditingController nationality = TextEditingController();
  TextEditingController jobTitle = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController altphoneNumber = TextEditingController();
  TextEditingController RelativeRelation = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Real = List<String>.filled(5, "");

    final double height = MediaQuery.of(context).size.height;
    //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    CollectionReference Parent =
        FirebaseFirestore.instance.collection("Parent");
    getEmail();
    getUserName();
    getAdminID();
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
                        key: formKey,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextFormField(
                                    onChanged: (val) =>
                                        formKey.currentState?.validate(),
                                    controller:
                                        parentName, //..text = parentx.Name,

                                    //  controller: parentUserName..text = parentx.PUserName,
                                    //to take text from user input
                                    textAlign: TextAlign.right,

                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        //fontWeight: FontWeight.w600,
                                        color: Colors.grey),
                                    showCursor: true,
                                    cursorColor: const Color(0xff42c98d),

                                    decoration: InputDecoration(
                                      labelText: "اسم ولي الامر",
                                      hintText: "اسم ولي الامر",
                                      hintStyle: const TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                      labelStyle: const TextStyle(
                                          color: const Color(0xff42c98d),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
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
                                              color: const Color(0xff42c98d),
                                            )
                                          ]),
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: const Color(0xff42c98d),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      floatingLabelStyle: const TextStyle(
                                          color: const Color(0xff42c98d),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xff42c98d),
                                            width: 2),
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
                                    onChanged: (val) =>
                                        formKey.currentState?.validate(),
                                    controller: Parentusername,
                                    //  controller: parentUserName..text = parentx.PUserName,
                                    //to take text from user input
                                    textAlign: TextAlign.right,

                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        //fontWeight: FontWeight.w600,
                                        color: Colors.grey),
                                    showCursor: true,
                                    cursorColor: const Color(0xff42c98d),

                                    decoration: InputDecoration(
                                      hintText: " أدخل اسم المستخدم",
                                      labelText: "اسم المستخدم",
                                      hintStyle: const TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                      labelStyle: const TextStyle(
                                          color: const Color(0xff42c98d),
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
                                              color: const Color(0xff42c98d),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      floatingLabelStyle: const TextStyle(
                                          color: const Color(0xff42c98d),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xff42c98d),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty)
                                        return "أرجو منك تعبئه الحقل الفارغ ";
                                      else {
                                        var Duser = true;
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
                                    controller: email,
                                    onChanged: (val) =>
                                        formKey.currentState?.validate(),
                                    //  controller: parentUserName..text = parentx.PUserName,
                                    //to take text from user input
                                    textAlign: TextAlign.right,

                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        //fontWeight: FontWeight.w600,
                                        color: Colors.grey),
                                    showCursor: true,
                                    cursorColor: const Color(0xff42c98d),

                                    decoration: InputDecoration(
                                      labelText: "البريد الإلكتروني",
                                      hintText: "أدخل البريد الإلكتروني",
                                      hintStyle: const TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                      labelStyle: const TextStyle(
                                          color: const Color(0xff42c98d),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300),
                                      prefixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Icon(
                                          Icons.email,
                                          size: 18,
                                          color: const Color(0xff42c98d),
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: const Color(0xff42c98d),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      floatingLabelStyle: const TextStyle(
                                          color: const Color(0xff42c98d),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xff42c98d),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(value!))
                                        return "أرجو منك تعبئه الحقل بطريقه صحيحة مثل something@gmail.com ";
                                      else {
                                        for (var i = 0;
                                            i < docEmails.length;
                                            i++) {
                                          if (value == docEmails[i]) {
                                            return "البريد الإلكتروني مستخدم مسبقا ";
                                          }
                                        }
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            //////////////////////////////////////////////
                            ///
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextFormField(
                                    onChanged: (val) =>
                                        formKey.currentState?.validate(),
                                    controller: phoneNumber,
                                    //  controller: parentUserName..text = parentx.PUserName,
                                    //to take text from user input
                                    textAlign: TextAlign.right,

                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        //fontWeight: FontWeight.w600,
                                        color: Colors.grey),
                                    showCursor: true,
                                    cursorColor: const Color(0xff42c98d),
                                    maxLength: 10,
                                    decoration: InputDecoration(
                                      labelText: "رقم الجوال",
                                      hintText: "أدخل رقم الجوال",
                                      hintStyle: const TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                      labelStyle: const TextStyle(
                                          color: const Color(0xff42c98d),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300),
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 12, top: 9, left: 9),
                                        child: Container(
                                          //  padding: const EdgeInsets.only(right: 5),

                                          child: Column(children: [
                                            Image.asset(
                                                "assets/icons/phone.png",
                                                width: 15,
                                                height: 15,
                                                color: Color(0xff42c98d)),
                                          ]),
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: const Color(0xff42c98d),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      floatingLabelStyle: const TextStyle(
                                          color: const Color(0xff42c98d),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xff42c98d),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$')
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
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextFormField(
                                    onChanged: (val) =>
                                        formKey.currentState?.validate(),
                                    controller: altphoneNumber,
                                    //  controller: parentUserName..text = parentx.PUserName,
                                    //to take text from user input
                                    textAlign: TextAlign.right,
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        //fontWeight: FontWeight.w600,
                                        color: Colors.grey),
                                    showCursor: true,
                                    cursorColor: const Color(0xff42c98d),
                                    maxLength: 10,
                                    decoration: InputDecoration(
                                      labelText: "رقم جوال قريب ",
                                      hintText: "أدخل رقم جوال قريب ",
                                      hintStyle: const TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                      labelStyle: const TextStyle(
                                          color: const Color(0xff42c98d),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300),
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 12, top: 9, left: 9),
                                        child: Container(
                                          //  padding: const EdgeInsets.only(right: 5),

                                          child: Column(children: [
                                            Image.asset(
                                                "assets/icons/phone.png",
                                                width: 15,
                                                height: 15,
                                                color: Color(0xff42c98d)),
                                          ]),
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: const Color(0xff42c98d),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      floatingLabelStyle: const TextStyle(
                                          color: const Color(0xff42c98d),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xff42c98d),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$')
                                              .hasMatch(value!))
                                        return "أرجو منك تعبئه الحقل بطريقه صحيحه حيث يتكون من 10 ارقام";
                                      else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
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
                                              // padding:
                                              // padding: EdgeInsets.only(right: 4),
                                              //   EdgeInsets.symmetric(horizontal: 120),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      width: 0.5,
                                                      color: const Color(
                                                          0xff42c98d)),
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
                                                            alignment: Alignment
                                                                .center,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 4),
                                                            child: Positioned(
                                                              left: 0,
                                                              child: Icon(
                                                                Icons
                                                                    .arrow_circle_down_rounded,
                                                                // Icons.arrow_downward_outlined,
                                                                color: const Color(
                                                                    0xff42c98d),
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
                                                                    color: Colors
                                                                        .grey),
                                                                value,
                                                                maxLines: 2,
                                                                // textAlign: TextAlign.left,
                                                              ),
                                                            ),
                                                          ),
                                                          Column(
                                                            children: <Widget>[
                                                              Container(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 75,
                                                                ),
                                                                // child: Padding(
                                                                //  padding: const EdgeInsets.only(
                                                                //      right: 12, top: 9, left: 9),
                                                                child:
                                                                    Container(
                                                                  //  padding: const EdgeInsets.only(right: 5),

                                                                  child: Row(
                                                                      children: [
                                                                        Text(
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                const Color(0xff42c98d),
                                                                          ),
                                                                          'صلة القرابة',
                                                                          maxLines:
                                                                              2,
                                                                          textAlign:
                                                                              TextAlign.right,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Image.asset(
                                                                            "assets/icons/family.png",
                                                                            width:
                                                                                15,
                                                                            height:
                                                                                15,
                                                                            color:
                                                                                const Color(0xff42c98d)),
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

                                                              Index = index;
                                                              print(Index);
                                                              final item =
                                                                  Relation[
                                                                      Index];
                                                              Index = index;
                                                              controller.text =
                                                                  item;
                                                              value = item;
                                                            },
                                                            children: Relation
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
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                      fontSize:
                                                                          17,
                                                                      color: const Color(
                                                                          0xff57d77a))),
                                                          onPressed: () {
                                                            isshowadd = false;

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

                                ///////////////////////////////////
                                ///
                                ///
                                ///
                                ///
                                ///
                                ///
                                ///
                                //  setState(() {
                                //   isshowadd = showno;
                                //  }),
                                Column(children: [
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextFormField(
                                      onChanged: (val) =>
                                          formKey.currentState?.validate(),
                                      controller: ParentIDNo,
                                      //  controller: parentUserName..text = parentx.PUserName,
                                      //to take text from user input
                                      textAlign: TextAlign.right,

                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          //fontWeight: FontWeight.w600,
                                          color: Colors.grey),
                                      showCursor: true,
                                      cursorColor: const Color(0xff42c98d),
                                      maxLength: 10,
                                      decoration: InputDecoration(
                                        labelText: "رقم الهوية /الإقامة",
                                        hintText: "أدخل رقم الهوية /الإقامة",
                                        hintStyle: const TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                        labelStyle: const TextStyle(
                                            color: const Color(0xff42c98d),
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
                                                  color:
                                                      const Color(0xff42c98d)),
                                            ]),
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xff42c98d),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        floatingLabelStyle: const TextStyle(
                                            color: const Color(0xff42c98d),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: const Color(0xff42c98d),
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
                                            nationality.text = country
                                                .displayNameNoCountryCode;
                                            print(
                                                'Select country: ${country.displayName}');
                                          },
                                        );
                                      },
                                      readOnly: true,

                                      onChanged: (val) =>
                                          formKey.currentState?.validate(),
                                      //  controller: parentUserName..text = parentx.PUserName,
                                      //to take text from user input
                                      controller: nationality,
                                      textAlign: TextAlign.right,

                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          //fontWeight: FontWeight.w600,
                                          color: Colors.grey),
                                      showCursor: true,
                                      cursorColor: const Color(0xff0da6c2),

                                      decoration: InputDecoration(
                                        labelText: "الجنسية",
                                        hintText: "ماهي جنسيتك؟",
                                        hintStyle: const TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                        labelStyle: const TextStyle(
                                            color: const Color(0xff42c98d),
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
                                                  color:
                                                      const Color(0xff42c98d)),
                                            ]),
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xff42c98d),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        floatingLabelStyle: const TextStyle(
                                            color: const Color(0xff42c98d),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: const Color(0xff42c98d),
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
                                      onChanged: (val) =>
                                          formKey.currentState?.validate(),
                                      controller: jobTitle,
                                      //  controller: parentUserName..text = parentx.PUserName,
                                      //to take text from user input
                                      textAlign: TextAlign.right,

                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          //fontWeight: FontWeight.w600,
                                          color: Colors.grey),
                                      showCursor: true,
                                      cursorColor: const Color(0xff42c98d),

                                      decoration: InputDecoration(
                                        labelText: "الوظيفة ",
                                        hintText: "الوظيفة ",
                                        hintStyle: const TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                        labelStyle: const TextStyle(
                                            color: const Color(0xff42c98d),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 12, top: 9, left: 9),
                                          child: Container(
                                            //  padding: const EdgeInsets.only(right: 5),

                                            child: Column(children: [
                                              Image.asset(
                                                  "assets/icons/Jobtitle.png",
                                                  width: 20,
                                                  height: 20,
                                                  color:
                                                      const Color(0xff42c98d)),
                                            ]),
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xff42c98d),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        floatingLabelStyle: const TextStyle(
                                            color: const Color(0xff42c98d),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: const Color(0xff42c98d),
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
                                ]),
                                const SizedBox(
                                  height: 20,
                                ),

                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
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
                                borderRadius: BorderRadius.circular(22),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Color.fromRGBO(
                                          0, 0, 0, 0.57), //shadow for button
                                      blurRadius: 5) //blur radius of shadow
                                ]),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(0, 255, 255, 255),
                                onSurface: Colors.transparent,
                                shadowColor: Colors.transparent,
                                //make color or elevated button transparent
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    issahre = true;
                                    isshowadd = false;
                                  });
                                  isAdded = false;
                                  var connectivityResult = await (Connectivity()
                                      .checkConnectivity());
                                  if (connectivityResult ==
                                      ConnectivityResult.wifi) {
                                    await parentx.addParent(
                                        parentName.text,
                                        Parentusername.text,
                                        email.text,
                                        ParentIDNo.text,
                                        phoneNumber.text,
                                        altphoneNumber.text,
                                        nationality.text,
                                        k,
                                        jobTitle.text,
                                        value);

                                    await showCupertinoDialog(
                                        context: context,
                                        builder: CreateDialog);
                                    await showCupertinoDialog(
                                        context: context, builder: share1);

                                    // I am connected to a mobile network.
                                  } else if (connectivityResult ==
                                      ConnectivityResult.mobile) {
                                    await parentx.addParent(
                                        parentName.text,
                                        Parentusername.text,
                                        email.text,
                                        ParentIDNo.text,
                                        phoneNumber.text,
                                        altphoneNumber.text,
                                        nationality.text,
                                        k,
                                        jobTitle.text,
                                        value);

                                    await showCupertinoDialog(
                                        context: context,
                                        builder: CreateDialog);
                                    await showCupertinoDialog(
                                        context: context, builder: share1);

                                    // I am connected to a mobile network.
                                  } else {
                                    await showCupertinoDialog(
                                        context: context,
                                        builder: CreateDialog6);
                                  }
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 18,
                                  right: 18,
                                ),
                                child: Text(
                                  "إضافة",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    )
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
                                SizedBox(
                                  width: 80,
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      "إنشاء حساب ولي الأمر",
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

  Widget CreateDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: Text("إضافة ولي الأمر",
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
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                // showno = false;
              });
            },
            child: Text("موافق",
                style: TextStyle(
                    color: const Color(0xff57d77a),
                    fontWeight: FontWeight.bold))),
      ],
    );
  }

  Widget CreateDialog6(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: Text("عذرًا",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Color.fromRGBO(31, 31, 31, 1),
              fontWeight: FontWeight.bold)),
      content: Text(
        "لا يوجد اتصال بالانترنت",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                // showno = false;
              });
            },
            child: Text("موافق",
                style: TextStyle(
                    color: const Color(0xff57d77a),
                    fontWeight: FontWeight.bold))),
      ],
    );
  }

  Widget share1(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: Text("هل انت متأكد من رغبتك في مشاركه هذه المعلومات ؟",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Color.fromRGBO(31, 31, 31, 1))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          new Text(Parentusername.text + " :اسم المستخدم"),
          Text("الرقم السري: " + k.toString())
        ],
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () async {
              await Share.share(
                  " \nمرحبًا، هذه معلومات حساب ولي الأمر الرجاء عدم مشاركتها مع اي شخص، ويجب تغييرها فور تسجيل الدخول" +
                      "\nاسم المستخدم:" +
                      Parentusername.text +
                      "\nالرقم السري:" +
                      k.toString());

              Future.delayed(const Duration(milliseconds: 1500)).then((value) {
                Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => Nav(
                    TabValue: 10,
                    documentId: "",
                  ),
                ));
              });
            },
            child: const Text("نعم",
                style: TextStyle(
                    color: const Color(0xff57d77a),
                    fontWeight: FontWeight.bold))),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => Nav(
                TabValue: 10,
                documentId: "",
              ),
            ));
          },
          child: const Text("لا"),
        ),
      ],
    );
  }
}
