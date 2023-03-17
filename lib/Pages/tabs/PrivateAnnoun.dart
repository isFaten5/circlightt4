import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:circlight/Pages/Nav.dart';
import 'package:circlight/Pages/Admin.dart';

class PrivateAnnoun extends StatefulWidget {
  @override
  State<PrivateAnnoun> createState() => _PrivateAnnoun();
}

class _PrivateAnnoun extends State<PrivateAnnoun>
    with TickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();

  //Controllers
  TextEditingController Address = TextEditingController();
  TextEditingController content = TextEditingController();
  TextEditingController sendto = TextEditingController();
  //
  List<String> listParentName = [];
  List<String> listSearch = [];
  List<String> listParentId = [];
  List<String> chosenparent = [];
  bool ischecked = false;
  String searchname = "";
  bool found = true;
  String ParentId = "";

  Future getParentsList() async {
    await FirebaseFirestore.instance.collection("Parent").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            listSearch.add(document.id);
            // print("parentids are${listParentId}");
            listParentName.add(document["UserName"]);
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    getParentsList();
    CollectionReference Announ =
        FirebaseFirestore.instance.collection("Announcement");
    return Container(
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
                    onChanged: (val) => formKey.currentState?.validate(),
                    controller: Address, //..text = parentx.Name,

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
                      labelText: "العنوان",
                      hintText: "العنوان",
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 12),
                      labelStyle: const TextStyle(
                          color: const Color(0xff42c98d),
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                      prefixIcon: Padding(
                        padding:
                            const EdgeInsets.only(right: 12, top: 9, left: 9),
                        child: Container(
                          //  padding: const EdgeInsets.only(right: 5),

                          child: Column(children: [
                            Icon(
                              Icons.title,
                              color: Color(0xff42c98d),
                            ),
                            /* Image.asset(
                              "assets/icons/name.png",
                              width: 20,
                              height: 20,
                              color: const Color(0xff42c98d),
                            )*/
                          ]),
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xff42c98d), width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      floatingLabelStyle: const TextStyle(
                          color: const Color(0xff42c98d),
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color(0xff42c98d), width: 2),
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
                  height: 10,
                ),

                // ******************************************************************************
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    maxLines: 10,
                    minLines: 1,
                    controller: sendto,
                    onChanged: (value) {
                      formKey.currentState?.validate();

                      setState(() {
                        searchname = value;
                      });

                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            //  return ListView.builder(
                            // itemCount: listParentName.length,
                            //itemBuilder: (BuildContext context, int index2) {*/
                            return StreamBuilder<QuerySnapshot>(
                              stream: (searchname != "" && searchname != null)
                                  ? FirebaseFirestore.instance
                                      .collection("Parent")
                                      .where("Search",
                                          arrayContains: searchname)
                                      .snapshots()
                                  : FirebaseFirestore.instance
                                      .collection("Parent")
                                      .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  final snap = snapshot.data!.docs;
                                  return FutureBuilder(
                                      future: Future.wait(
                                          [Admin().ParentListView()]),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            primary: false,
                                            itemCount: snap.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  sendto.text =
                                                      snap[index]['Name'];
                                                  found = true;
                                                  ParentId = snap[index].id;
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                    height: 70,
                                                    width: double.infinity,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 1),
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.black12),
                                                      ),
                                                    ),
                                                    child: Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(),
                                                          ),

                                                          Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Container(
                                                              width: 90,
                                                              height: 100,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          10,
                                                                      top: 10),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .white60
                                                                  //color:
                                                                  // Color(0xffD6D6D6),
                                                                  ),
                                                              child: Center(
                                                                  child: Icon(
                                                                      Icons
                                                                          .person,
                                                                      size: 40,
                                                                      color: Color(
                                                                              0xff57d77a)
                                                                          .withOpacity(
                                                                              0.4))),
                                                            ),
                                                          ), //to only show the allowed people to admin

                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 90),
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              snap[index]
                                                                  ['Name'],
                                                              style:
                                                                  const TextStyle(
                                                                color: Color(
                                                                    0xff0da6c2),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          //container for button
                                                        ])),
                                              );
                                            },
                                          );
                                        } else {
                                          found = false;
                                          return Center(
                                              child:
                                                  Text("لايوجد شخص بهذا الاسم")

                                              // "لايوجد شخص بهذا الاسم";
                                              //child: CircularProgressIndicator(),
                                              );
                                        }
                                      });
                                } else {
                                  found = false;
                                  return Center(
                                      child: Text("لايوجد شخص بهذا الاسم")
                                      // "لايوجد شخص بهذا الاسم";
                                      //child: CircularProgressIndicator(),
                                      );
                                }
                              },
                            );

                            /////////////////////////////////////////////////////
                            /*ListTile(
                                    onTap: () async {
                                      /* await assignParentToStudent(studentId: snap[index].id, parentId: listParentId[index2]);
                                                                                Navigator.pop(context);
                                                                                ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
                                      //print(listParentName[index2]);
                                      sendto.text = listParentName[index2];
                                        Navigator.pop(context);
                                    },
                                    title:
                                        (searchname != "" && searchname != null)
                                            ? Text(listParentName[index2])
                                            : Text(listSearch[index2]));*/
                            ///////////////////////////////////////////////
                            /* });*/
                            // },
                          });
                    },
                    // onChanged: (val) => formKey.currentState?.validate(),
                    //..text = parentx.Name,

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
                      labelText: "المرسل اليه",
                      hintText: "المرسل اليه",
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 12),
                      labelStyle: const TextStyle(
                          color: const Color(0xff42c98d),
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                      prefixIcon: Padding(
                        padding:
                            const EdgeInsets.only(right: 12, top: 9, left: 9),
                        child: Container(
                          //  padding: const EdgeInsets.only(right: 5),

                          child: Column(children: [
                            Icon(
                              Icons.person,
                              color: Color(0xff42c98d),
                            ),
                          ]),
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xff42c98d), width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      floatingLabelStyle: const TextStyle(
                          color: const Color(0xff42c98d),
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color(0xff42c98d), width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty)
                        return "أرجو منك تعبئه الحقل الفارغ ";
                      else {
                        if (found == false)
                          return "ارجو منك اختيار اسم من القائمه";
                        ;
                      }
                      return null;
                    },
                  ),
                ),

                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    maxLines: 10,
                    minLines: 1,

                    onChanged: (val) => formKey.currentState?.validate(),
                    controller: content, //..text = parentx.Name,

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
                      labelText: "المحتوى",
                      hintText: "المحتوى",
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 12),
                      labelStyle: const TextStyle(
                          color: const Color(0xff42c98d),
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                      prefixIcon: Padding(
                        padding:
                            const EdgeInsets.only(right: 12, top: 9, left: 9),
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
                              color: const Color(0xff42c98d), width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      floatingLabelStyle: const TextStyle(
                          color: const Color(0xff42c98d),
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color(0xff42c98d), width: 2),
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
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: CheckboxListTile(
                      title: Text("هل ترغب في وضع الإعلان ذا أولوية عالية؟"),
                      value: ischecked,
                      onChanged: (newValue) {
                        setState(() {
                          ischecked = newValue!;
                        });
                      },
                      //  <-- leading Checkbox
                    ) /*CheckboxListTile(
                    title: Text("هل ترغب في جعل الاعلان مهم؟"),
                    value: ischecked,
                    onChanged: (value) {
                      setState(() {
                        ischecked = value!;
                      });
                    },
                  ),*/
                    ),
                const SizedBox(
                  height: 40,
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
                              await Announ.add({
                                "Address": Address.text,
                                "important": ischecked,
                                "message": content.text,
                                "ParentID": ParentId,
                                "status": "Private",
                                "Date": DateTime.now(),
                                //img
                              });

                              await showCupertinoDialog(
                                  context: context, builder: CreateDialog);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 18,
                              right: 18,
                            ),
                            child: Text(
                              "إرسال ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
            //////////////////////////////////////////////
            ///
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget CreateDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: Text("إرسال المحتوى",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Color.fromRGBO(31, 31, 31, 1),
              fontWeight: FontWeight.bold)),
      content: Text(
        "تم إرسال المحتوى بنجاح",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              /* Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) => Nav(
                  TabValue: 0,
                  documentId: "",
                ),
              ));*/
            },
            child: Text("موافق",
                style: TextStyle(
                    color: const Color(0xff57d77a),
                    fontWeight: FontWeight.bold))),
      ],
    );
  }
}
