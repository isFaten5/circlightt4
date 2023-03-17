import 'package:circlight/Screens/login_screen.dart';
import 'package:circlight/Widgets/background_widget.dart';
import 'package:circlight/Widgets/responsive_widget.dart';
import 'package:circlight/Widgets/sign_up_top_image.dart';
import 'package:flutter/material.dart';

import '../Widgets/signup_form.dart';
import '../Widgets/sign_up_top_image.dart';
import '../constants.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({required this.user});

  String user;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileSignupScreen(
            userData: user,
          ),
          desktop: Row(
            children: [
              Expanded(
                child: SignUpScreenTopImage(
                  userData: user,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen(user: user)),
                        );
                      },
                      child: Text("Already have account? SignIn Here."),
                    ),
                    SizedBox(
                      width: 450,
                      child: SignUpForm(
                        userData: user,
                      ),
                    ),
                    SizedBox(height: defaultPadding / 2),
                    // SocalSignUp()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MobileSignupScreen extends StatelessWidget {
  String userData;
  MobileSignupScreen({
    required this.userData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SignUpScreenTopImage(
          userData: userData,
        ),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: SignUpForm(
                userData: userData,
              ),
            ),
            Spacer(),
          ],
        ),
        // const SocalSignUp()
      ],
    );
  }
}
