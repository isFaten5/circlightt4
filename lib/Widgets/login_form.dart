import 'package:circlight/Pages/DelegatorHome.dart';
import 'package:circlight/Pages/featuerd_screen.dart';
import 'package:circlight/Screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/signup_screen.dart';
import '../constants.dart';
import 'already_account.dart';

class LoginForm extends StatefulWidget {
  String userroll;

  LoginForm({
    required this.userroll,
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailControllerForSignIn =
      TextEditingController();

  final TextEditingController passwordControllerForSignIn =
      TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final formKey = GlobalKey<FormState>();
  bool isFirstTime = false;
  Future signIn(BuildContext context) async {
    print(widget.userroll.toString());
    try {
      // isLoading.value = true;

      await auth
          .signInWithEmailAndPassword(
              email: emailControllerForSignIn.text.trim(),
              password: passwordControllerForSignIn.text.trim())
          .then((value) {
        if (widget.userroll == "Admin") {
          FirebaseFirestore.instance
              .collection("Admin")
              .doc(value.user!.uid)
              .get()
              .then((value) {
            if (value.exists) {
              print("1");
              var name = value.get("SchoolName");

              Navigator.of(context).push(
                  CupertinoPageRoute(builder: (context) => FeaturedScreen()));
              // Navigator.of(context).push(CupertinoPageRoute(
              //     builder: (context) => StudentScreen(userName: name, user: widget.userData)
              // ));
            } else {
              print("1");
              const snackBar = SnackBar(
                content: Text('هذا الحساب غير مسجل حاول مره أخرى'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          });
        } else if (widget.userroll == "Parent") {
          bool isFirstTime = true;
          FirebaseFirestore.instance
              .collection("Parent")
              .doc(value.user!.uid)
              .get()
              .then((value) {
            if (value.exists) {
              Map<String, dynamic> dataa = {};
              dataa.addAll(value.data() as Map<String, dynamic>);
              if (dataa["PfirstTime"] == false) {
                isFirstTime = false;
                FirebaseFirestore.instance
                    .collection("Parent")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .set({"PfirstTime": true}, SetOptions(merge: true));
              }
              print("2");
              var name = value.get("Name");

              if (isFirstTime == false) {
                print("Yes successfully");
                // Navigator.of(context).push(CupertinoPageRoute(
                //   builder: (context) =>
                //       HomeScreen(user: widget.userroll, userName: name)));
              } else {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) =>
                        HomeScreen(user: widget.userroll, userName: name)));
              }

              // Navigator.of(context).push(CupertinoPageRoute(
              //     builder: (context) => ParentScreen(userName: name, user: widget.userData)
              // ));
            } else {
              const snackBar = SnackBar(
                content: Text('هذا الحساب غير مسجل حاول مره أخرى'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          });
        } else {
          FirebaseFirestore.instance
              .collection("Delegator")
              .doc(value.user!.uid)
              .get()
              .then((value) {
            if (value.exists) {
              print("3");

              var name = value.get("UserName");
              // DocumentSnapshot user = snapshot.data.documents[index];
              // String documentId = user.id;
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => DelegatorHome(
                        userName: name,
                        user: widget.userroll,
                      )));
              // Navigator.of(context).push(CupertinoPageRoute(
              //     builder: (context) => DelegatorScreen(userName: name, user: widget.userData)
              // ));
            } else {
              const snackBar = SnackBar(
                content: Text('هذا الحساب غير مسجل حاول مره أخرى'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          });
        }
      });
    } on FirebaseAuthException catch (e) {
      // isLoading.value = false;
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('خطأ في تسجيل الدخول '),
      //     action: SnackBarAction(
      //       label: 'Undo',
      //       onPressed: () {
      //         // Some code to undo the change.
      //       },
      //     ),
      //   ),
      // );
      if (e.code == 'user-not-found') {
        print('لم يتم العثور على البريد الإلكتروني');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('لم يتم العثور على البريد الإلكتروني'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('الرمز السري المدخل خاطئ'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          ),
        );
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              controller: emailControllerForSignIn,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              // onSaved: (email) {},
              showCursor: true,
              cursorColor: const Color(0xff42c98d),
              decoration: InputDecoration(
                filled: true, //<-- SEE HERE
                fillColor: Colors.white,
                hintText: "البريد الإلكتروني",
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
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(
                    Icons.mail,
                    color: const Color(0xff42c98d),
                    size: 22,
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
                // textDirection: TextDirection.RTL,
                controller: passwordControllerForSignIn,
                textInputAction: TextInputAction.next,
                obscureText: true,
                showCursor: true,
                cursorColor: const Color(0xff42c98d),
                decoration: InputDecoration(
                  filled: true, //<-- SEE HERE
                  fillColor: Colors.white,
                  hintText: " الرقم السري",
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
          ),
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
                    onPressed: () async {
                      await signIn(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 18,
                        bottom: 18,
                      ),
                      child: Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) {
                    return SignUpScreen(
                      user: widget.userroll,
                    );
                  },
                ),
              );
            },
          ),
          // ************************** To TEST ************************

          // ************************** To TEST ************************

          SizedBox(
            height: 400,
          )
        ],
      ),
    ));
  }
}
