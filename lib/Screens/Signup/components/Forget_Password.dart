import 'package:circlight/Pages/Nav.dart';
import 'package:flutter/material.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
//import 'Nav.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPassword();
}

class _ForgetPassword extends State<ForgetPassword>
    with TickerProviderStateMixin {
  //defining a lists
  List<String> docEmails = [];
  List<String> docUserName = [];

  //for Email uniqueness
  Future getEmail() async {
    await FirebaseFirestore.instance.collection("Delegator").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            // print(document["Email"]);
            docEmails.add(document["Email"]);
          }),
        );
  }

  //for username uniqueness
  Future getUserName() async {
    await FirebaseFirestore.instance.collection("Delegator").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            docUserName.add(document["UserName"]);
          }),
        );
  }

//conntrollers
  final _key = GlobalKey<FormState>();
  TextEditingController _emailContoller = TextEditingController();

  late Animation _colorTween, _iconColorTween, _icon2ColorTween;
  late TextEditingController controller;
  var Real;
  late FixedExtentScrollController scrollController;
  late AnimationController _ColorAnimationController;
  late AnimationController _TextAnimationController;
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
  }

  bool _passwordVisible = false;
  bool _passwordVisible2 = false;
  var loading = false;
  @override
  void dispose() {
    _emailContoller.dispose();
    super.dispose();
  }

  Future PasswordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailContoller.text.trim());
      await showCupertinoDialog(context: context, builder: CreateDialog1);
    } on FirebaseAuthException catch (e) {
      print(e);
      await showCupertinoDialog(context: context, builder: CreateDialog);
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference Parent =
        FirebaseFirestore.instance.collection("Delegator");
    getEmail();
    getUserName();
    return Form(
      key: _key,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                onChanged: (val) => _key.currentState?.validate(),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: _emailContoller,
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!))
                    return "أرجو منك تعبئه الحقل بطريقه صحيحة مثل something@gmail.com ";
                  else {
                    for (var i = 0; i < docEmails.length; i++) {
                      if (value == docEmails[i]) {
                        return "البريد الإلكتروني مستخدم مسبقا ";
                      }
                    }
                    return null;
                  }
                },
                onSaved: (email) {},
                showCursor: true,
                cursorColor: const Color(0xff42c98d),
                decoration: InputDecoration(
                  filled: true, //<-- SEE HERE
                  fillColor: Colors.white,
                  hintText: "البريد الالكتروني",
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: const Color(0xff42c98d), width: 1),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: const Color(0xff57d77a), width: 1),
                      borderRadius: BorderRadius.circular(22)),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Icon(
                      Icons.mail,
                      color: const Color(0xff42c98d),
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: Center(
              child: Container(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        const Color(0xff57d77a),
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
                      primary: Colors.transparent,
                      onSurface: Colors.transparent,
                      shadowColor: Colors.transparent,
                      //make color or elevated button transparent
                    ),
                    onPressed: () {
                      PasswordReset();
                      if (_key.currentState != null &&
                          _key.currentState!.validate()) {}
                      /* Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => Nav(
                          TabValue: 0,
                          documentId: "",
                        ),
                      ));*/
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 18,
                        bottom: 18,
                      ),
                      child: Text(
                        "إعادة تعيين كلمة المرور ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget CreateDialog(BuildContext context) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    title: Text(" إعاده تعيين كلمة المرور",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(31, 31, 31, 1),
            fontWeight: FontWeight.bold)),
    content: Text(
      "يرجى التحقق من البريد الإلكتروني المدخل",
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

Widget CreateDialog1(BuildContext context) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    title: Text(" إعاده تعيين كلمة المرور",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(31, 31, 31, 1),
            fontWeight: FontWeight.bold)),
    content: Text(
      "!تم إرسال البريد الإلكتروني بنجاح",
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
