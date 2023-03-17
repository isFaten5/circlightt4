import 'package:circlight/Widgets/login_form.dart';
import 'package:circlight/Widgets/login_screen_top_image.dart';

import 'package:circlight/components/background.dart';
import 'package:circlight/responsive.dart';
import 'package:flutter/material.dart';

import '../Widgets/login_screen_top_image.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({required this.user});

  String user;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileLoginScreen(userData: user),
          desktop: Row(
            children: [
              Expanded(
                child: LoginScreenTopImage(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: LoginForm(userroll: user),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  String userData;
  MobileLoginScreen({
    required this.userData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const LoginScreenTopImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginForm(userroll: userData),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
