//import 'package:education_app/constants/color.dart';
//import 'package:education_app/constants/size.dart';
//import 'package:education_app/main.dart';
//import 'package:education_app/models/category.dart';

//import 'package:education_app/screens/details_screen.dart';
//import 'package:education_app/widgets/circle_button.dart';
//import 'package:education_app/widgets/lesson_card.dart';
import 'package:circlight/Pages/Nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import '../widgets/search_testfield.dart';
import 'base_screen.dart';
import 'displayParent.dart';
import 'displayStudent.dart';

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({Key? key}) : super(key: key);

  @override
  _FeaturedScreenState createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  @override
  Widget build(BuildContext context) {
    const kBottomNavigationBarItemSize = 24.0;
    const kCategoryCardImageSize = 120.0;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(252, 253, 255, 1),
        body: Column(
          children: const [
            AppBar(),
            Body(),
          ],
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 90, left: 20, right: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "إدارة الحسـابـات",
                style: const TextStyle(
                  color: Color.fromRGBO(67, 171, 186, 1),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 4.0,
                    spreadRadius: .05,
                  ), //BoxShadow
                ],
              ),
              child: Container(
                child: Align(
                  //alignment: Alignment.center,
                  // child: Image.asset(
                  //   'assets/icons/parent.png',
                  //   height: kCategoryCardImageSize, //image size
                  // ),

                  child: GestureDetector(
                    child: Image.asset(
                      "assets/icons/parent.png",
                      height: 120.0,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => Nav(
                                    TabValue: 10,
                                    Name: "",
                                    username: "",
                                    Blood: "",
                                    Class: "",
                                    ID: "",
                                    Realtion: "",
                                    documentId: "",
                                    email: "",
                                  )));
                    },
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 40,
            // ),

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 4.0,
                    spreadRadius: .05,
                  ), //BoxShadow
                ],
              ),
              child: Container(
                child: Align(
                  child: GestureDetector(
                    child: Image.asset(
                      'assets/icons/student_icon.png',
                      height: 120.0,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => Nav(
                                    TabValue: 11,
                                    documentId: "",
                                    Blood: "",
                                    Confirm: "",
                                    TheValue: "",
                                    header: "",
                                  )));
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// class CategoryCard extends StatelessWidget {
//   final Category category;
//   const CategoryCard({
//     Key? key,
//     required this.category,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const CourseScreen(),
//         ),
//       ),
//     );
//   }
// }

class AppBar extends StatelessWidget {
  const AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding:
      //     const EdgeInsets.only(top: 0, left: 0, right: 0), //here is مرحبًا ;

      height: 300,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          //topRight: Radius.circular(20),
          //topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.5],
          colors: [const Color(0xff42c98d), const Color(0xff0da6c2)],
        ),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/3D.png",
                height: 280,
                width: 280,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  "مرحبًا!",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 30, color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
              SizedBox(
                //Hereeee
                width: 40,
              ),

              //CircleButton(
              //icon: Icons.notifications,
              //onPressed: () {},
              //),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
