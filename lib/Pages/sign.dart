import 'package:circlight/Pages/Nav.dart';
import 'package:flutter/material.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
//import 'Nav.dart';

class SignUpFrm extends StatefulWidget {
  const SignUpFrm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpFrm> createState() => _SignUpForm();
}

class _SignUpForm extends State<SignUpFrm> with TickerProviderStateMixin {
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

  //signup method
  Future _signup() async {
    setState(() {
      loading = true;
    });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailContoller.text, password: _passwordController.text);
      //}

      await FirebaseFirestore.instance.collection("Delegator").add({
        "Email": _emailContoller.text,
        "UserName": _UsernamelContoller.text,
        "Password": _passwordController.text,
      });
      await showCupertinoDialog(context: context, builder: CreateDialog);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    /*showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("تم التسجيل بنجاح"),
              content: Text("تم تسجبل حسابك بإمكانك الدخول لحسابك "),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("موافق "),
                )
              ],
            ));*/

    Navigator.of(context).pop();
    /* on FirebaseAuthException catch (e) {
      _handlesignupError(e);
      setState(() {
        loading = false;
      });
    }*/
  }

  /*void _handlesignupError(FirebaseAuthException e) {
    String messagetodisplay;
    switch (e.code) {
      case "email-already-in-use":
        messagetodisplay = "البريد الالكتروني مستخدم مسبقا";
        break;
      case "invalid-email":
        messagetodisplay = "البريد الالكتروني المدخل غير صحيح";
        break;

      case "operation-not-allowed":
        messagetodisplay = "هذه العمليه غير مسموح بها ";
      
        break

    }
  }*/
//conntrollers
  final _key = GlobalKey<FormState>();
  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _UsernamelContoller = TextEditingController();
  TextEditingController _ConformpasswordController = TextEditingController();
  TextEditingController _ID = TextEditingController();
  TextEditingController _Phonenumber = TextEditingController();
  TextEditingController _Name = TextEditingController();

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
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                controller: _Name,
                validator: (value) {
                  if (value!.isEmpty)
                    return "أرجو منك تعبئه الحقل الفارغ ";
                  else {
                    return null;
                  }
                },
                onSaved: (email) {},
                showCursor: true,
                cursorColor: const Color(0xff42c98d),
                decoration: InputDecoration(
                  filled: true, //<-- SEE HERE
                  fillColor: Colors.white,
                  hintText: "الاسم",
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
                      Icons.person,
                      color: const Color(0xff42c98d),
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ////////////////////////////////////////////////
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                onChanged: (val) => _key.currentState?.validate(),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                controller: _UsernamelContoller,
                validator: (value) {
                  if (value!.isEmpty)
                    return "أرجو منك تعبئه الحقل الفارغ ";
                  else {
                    return null;
                    /*
                      A valid username should start with an alphabet so, [A-Za-z].
All other characters can be alphabets, numbers or an underscore so, [A-Za-z0-9_].
Since length constraint was given as 8-30 and we had already fixed the first character, so we give {7,29}.
We use ^ and $ to specify the beginning and end of matching.*/
                  }
                },
                onSaved: (email) {},
                showCursor: true,
                cursorColor: const Color(0xff42c98d),
                decoration: InputDecoration(
                  filled: true, //<-- SEE HERE
                  fillColor: Colors.white,
                  hintText: "اسم المستخدم",
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
                      Icons.person,
                      color: const Color(0xff42c98d),
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                onChanged: (val) => _key.currentState?.validate(),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                controller: _ID,
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$').hasMatch(value!))
                    return "أرجو منك تعبئه الحقل بطريقه صحيحه حيث يتكون من 10 ارقام";
                  else {
                    return null;
                  }
                },
                maxLength: 10,
                onSaved: (email) {},
                showCursor: true,
                cursorColor: const Color(0xff42c98d),
                decoration: InputDecoration(
                  filled: true, //<-- SEE HERE

                  fillColor: Colors.white,
                  hintText: "أدخل رقم الهوية /الإقامة",
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
                      Icons.person,
                      color: const Color(0xff42c98d),
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                onChanged: (val) => _key.currentState?.validate(),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                controller: _Phonenumber,
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$').hasMatch(value!))
                    return "أرجو منك تعبئه الحقل بطريقه صحيحه حيث يتكون من 10 ارقام";
                  else {
                    return null;
                  }
                },
                maxLength: 10,
                onSaved: (email) {},
                showCursor: true,
                cursorColor: const Color(0xff42c98d),
                decoration: InputDecoration(
                  filled: true, //<-- SEE HERE

                  fillColor: Colors.white,
                  hintText: "رقم الجوال ",
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
                      Icons.phone,
                      color: const Color(0xff42c98d),
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          ),

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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                onChanged: (val) => _key.currentState?.validate(),
                controller: _passwordController,
                obscureText:
                    !_passwordVisible, //This will obscure text dynamically
                validator: (value) {
                  if (value!.isEmpty) {
                    return "أرجو منك تعبئه الحقل الفارغ ";
                  }
                  if (!RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                      .hasMatch(value!)) {
                    return "يجب عليك الالتزام بشروط الرقم السري التالية من فضلك:\n - حرف واحد كبيرة على الأقل\n - حرف واحد صغير على الاقل\n - رقم واحد على الاقل  \n  - حرف واحد خاص على الاقل (! @ # \$ & * ~) \n -يجب ان يتكون الرقم السري من 6 خانات";
                  } else
                    return null;
                },
                textInputAction: TextInputAction.next,
                // obscureText: true,
                showCursor: true,
                cursorColor: const Color(0xff42c98d),
                decoration: InputDecoration(
                  filled: true, //<-- SEE HERE
                  fillColor: Colors.white,

                  hintText: " الرقم السري",
                  // Here is key idea
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
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
                      Icons.lock,
                      color: const Color(0xff42c98d),
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
            /*child: TextFormField(
              controller: _passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password cannot be empty';
                } else
                  return null;
              },
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: " الرقم السري",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),*/
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                onChanged: (val) => _key.currentState?.validate(),
                controller: _ConformpasswordController,
                obscureText:
                    !_passwordVisible2, //This will obscure text dynamically
                validator: (value) {
                  if (value!.isEmpty) {
                    return "أرجو منك تعبئه الحقل الفارغ ";
                  }
                  if (_passwordController.text !=
                      _ConformpasswordController.text) {
                    return 'الرقم السري غير متطابق ';
                  } else
                    return null;
                },
                textInputAction: TextInputAction.next,
                //obscureText: true,
                showCursor: true,
                cursorColor: const Color(0xff42c98d),
                decoration: InputDecoration(
                  filled: true, //<-- SEE HERE
                  fillColor: Colors.white,
                  //for hide show the password
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible2
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible2 = !_passwordVisible2;
                      });
                    },
                  ),
                  hintText: "تأكيد الرقم السري",
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
                      Icons.lock,
                      color: const Color(0xff42c98d),
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
            /*child: TextFormField(
              controller: _ConformpasswordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password cannot be empty';
                }
                if (_passwordController.text !=
                    _ConformpasswordController.text) {
                  return 'الرقم السري غير متطابق ';
                } else
                  return null;
              },
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "تأكيد الرقم السري ",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),*/
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
                      if (_key.currentState != null &&
                          _key.currentState!.validate()) {
                        _signup();
                      }
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
                        "التسجيل  ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          /* ElevatedButton(
            onPressed: () {},
            child: Text("تسجيل الدخول "),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),*/
        ],
      ),
    );
  }
  /*void signInUser() async {
    dynamic authResult =
        await _auth.loginUser(_emailContoller.text, _passwordController.text);
    if (authResult == null) {
      print('Sign in error. could not be able to login');
    } else {
      _emailContoller.clear();
      _passwordController.clear();
      //Navigator.pushNamed(context, '/dashboard');
    }
  }*/
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
