import 'package:circlight/Screens/login_screen.dart';
import 'package:circlight/Screens/signup_screen.dart';
import 'package:flutter/material.dart';

import '../Widgets/background_widget.dart';

class WelcomeScreen extends StatelessWidget {
  String admin = "Admin";
  String parent = "Parent";
  String delegator = "Delegator";

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                onPressed: () {
                  goToSignInScreen(context, admin);
                },
                child: Text("الاستمرار ك ادمن"),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  goToSignInScreen(context, parent);
                },
                child: Text("الاستمرار ك ولي أمر "),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  goToSignInScreenForDelegator(context, delegator);
                },
                child: Text("الاستمرار ك مفوض"),
              ),
              // Text("A"),
              // Text("B"),
              // Text("C"),
            ]),
          ),
        ),
      ),
    );
  }
}

void goToSignInScreenForDelegator(BuildContext context, String user) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => SignUpScreen(
              user: user,
            )),
  );
}

void goToSignInScreen(BuildContext context, String user) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => LoginScreen(
              user: user,
            )),
  );
}
