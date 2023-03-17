import 'package:circlight/Pages/Announcement.dart';
import 'package:circlight/Pages/CreateParent.dart';
import 'package:circlight/Pages/DelRequest.dart';
import 'package:circlight/Pages/ParentREQ.dart';
import 'package:circlight/Pages/PreviewReqParent.dart';

import 'package:circlight/Pages/constants.dart';

import 'package:circlight/Pages/displayParent.dart';
import 'package:circlight/Pages/displayStudent.dart';
import 'package:circlight/Pages/emails.dart';
import 'package:circlight/Screens/welcome_screen.dart';
//import 'package:circlight/Pages/ggggggg.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:circlight/Pages/firebase_options.dart';
import 'package:circlight/Pages/Nav.dart';
import 'Pages/AdminPreviewRequest.dart';
import 'Pages/ListReqAdmin.dart';
import 'Pages/ParentRequest2.dart';
import 'package:circlight/Pages/ParentRequest2.dart';
import 'Pages/CreateDelegator.dart';
import 'Pages/CreateStudent.dart';

import 'Pages/DelegatorHome.dart';
import 'Pages/DelegatorList.dart';
import 'Pages/DelegatorPending.dart';
import 'Pages/DelegatorStudents.dart';
import 'Pages/GenaralSearch.dart';
import 'Pages/ListDelegator.dart';
import 'Pages/ListRequest.dart';
import 'Pages/NavDelegator.dart';
import 'Pages/NavParent.dart';

import 'Pages/PreviewReqAdmin.dart';
import 'Pages/ReqMissing.dart';
import 'Pages/RequestDone.dart';
import 'Pages/base_screen.dart';

import 'Pages/edit5.dart';
import 'Pages/editStudent.dart';
import 'Pages/sign.dart';

import 'Pages/DelegatorList.dart';
import 'Pages/tabs/PublicAnnoun.dart';

import 'flutter_flow/flutter_flow_util.dart';
import 'home_page/home_page_widget.dart';

Future main() async {
//start of firebase connection
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(LoginUiApp());

  //end firebase connection
}

class LoginUiApp extends StatelessWidget {
  Color _primaryColor = const Color(0xff0da6c2);
  Color _accentColor = const Color(0xff57d77a);

  // Design color
  // Color _primaryColor= HexColor('#FFC867');
  // Color _accentColor= HexColor('#FF3CBD');

  // Our Logo Color
  // Color _primaryColor= HexColor('#D44CF6');
  // Color _accentColor= HexColor('#5E18C8');

  // Our Logo Blue Color
  //Color _primaryColor= HexColor('#651BD2');
  //Color _accentColor= HexColor('#320181');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // title: 'Flutter Login UI',
        title: 'Circlight',
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: _primaryColor,
          accentColor: _accentColor,
          primarySwatch: Colors.grey,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            bodyLarge: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            bodyMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            displayMedium: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
        home: //DelegatorHome(),
            // ListDelegator()
            //  DelegatorPending()
            //]  DelegatorStudent()
            // WelcomeScreen(),
            /* HomePage2(
          TabValue: 0,
        )*/
            //    Announcement()
            //  ParentReq()
            /*    HomePage2(
          TabValue: 0,
        )*/
            //  UploadExample()
            // ParentReqq()

            //HomePageeee2()
            //  MyHomePage5()
            /*   BottomNavBar(
          index: 0,
          documentId: "",
        )*/
            /*  PreviewReqParent(
          documentId: "QSJAovgLpD2ltRvr5glu",
        )*/
            /*    BottomNavBar(
          documentId: "",
          index: 0,
        )*/
            //  ListReqAdmin()
            /*  PreviewReqAdmin(
          documentId: "Gr7X4qC9gxrMMzxx30yQ",
        )*/
            // WelcomeScreen()
            /* NavParent(
          TabValue: 0,
        )*/
            /*  NavDel(
          TabValue: 0,
          User: "",
          UserName: "",
        )*/
            /*    NavParent(
          TabValue: 0,
        )*/
            // DelRequest()
            PRequest()
        /*   Nav(
          TabValue: 0,
        )*/
        // CreateDelegator()
        //ListReqAdmin()
        /*AdminPreviewRequest(
          documentId: "smDrrIiv0W5xBhv3UeDG",
        )*/
        //   ListReqAdmin()
        /* ReqMissing(
          documentId: "gYbEwLQD65pteu8UG47d",
        )*/
        //  ListRequest2()
        /*  PreviewReqAdmin(flu
          documentId: "evywiSmHgplRa4Ro4Qa3",
        )*/
        // CreateDelegator()
        //  ParentReqq()
        /*    PreviewPDF(
          Url:
              "https://firebasestorage.googleapis.com/v0/b/gp-695a5.appspot.com/o/Files%2F06YH3Ox5AvO4eUYahk54%2FMADD_Final_Report.pdf?alt=media&token=5fec743a-f1f8-4a50-906c-bd80e2914c86",
        )*/
        //  MyApppii3()
        //     RequestForm()
        //  NavDel(TabValue: 1),
        //    Delegatordisplay()
        // DelegatorPending()
        /*  NavParent(
        TabValue: 0,
      ),*/
        //  GeneralSearch(),
        //  CreateDelegator()
        // Paretdisplay()
        /*  NavDel(
          TabValue: 0,
        )*/
        //   DelegatorStudent()
        /*    NavParent(
          TabValue: 0,
        )*/
        //ListRequest()
        // Createparent5(index: 0),
        // Delegatordisplay(),
        );
  }
}
