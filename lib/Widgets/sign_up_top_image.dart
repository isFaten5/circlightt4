import 'package:circlight/Screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SignUpScreenTopImage extends StatelessWidget {
  String userData;
  SignUpScreenTopImage({
    required this.userData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 16,
                  ),
                  color: Colors.white,
                ),
                // SizedBox(
                //   width: 100,
                // ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "إنشاء حساب المفوض",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   width: 150,
                // ),
              ],
            ),
          ),
        ]),
        ////////////////////////////
        Text(
          "".toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: defaultPadding),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 2,
              child: Image.asset("assets/icons/circlight_icon_500.png"),
            ),
            const Spacer(),
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginScreen(
                        user: userData,
                      )),
            );
          },
          child: Text(
            "هل لديك حساب ؟ تسجيل الدخول ",
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(height: defaultPadding),
      ],
    );
  }
}
