import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:circlight/Pages/Admin.dart';
import 'package:circlight/Pages/Nav.dart';

class GeneralSearch extends StatefulWidget {
  const GeneralSearch({Key? key}) : super(key: key);

  @override
  State<GeneralSearch> createState() => _GeneralSearch();
}

class _GeneralSearch extends State<GeneralSearch>
    with TickerProviderStateMixin {
  String searchname = "";

  @override
  Widget build(BuildContext context) {
    //double _headerHeight = 150;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: NotificationListener<ScrollNotification>(
          // onNotification: _scrollListener,
          child: Container(
            height: double.infinity,
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        //height: 230,
                        child: Stack(
                          children: [
                            Container(
                              //height: 230,
                              padding:
                                  EdgeInsets.only(right: 20, top: 20, left: 20),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: 20, top: 20, left: 20),
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      searchname = value;
                                    });
                                  },
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                      hintText: "..بحث",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade600),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Colors.grey.shade600,
                                        size: 20,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                      contentPadding: EdgeInsets.all(8),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade100)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade100))),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                      /* this was the float button Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FloatingActionButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ParentAddform()));
                            },
                            child: const Icon(Icons.add),
                            backgroundColor: const Color(0xff57d77a),
                          ),
                        ),
                      ),*/

                      // width: Get.width,

                      StreamBuilder<QuerySnapshot>(
                        stream: (searchname != "" && searchname != null)
                            ? FirebaseFirestore.instance
                                .collection("Parent")
                                .where("Search", arrayContains: searchname)
                                .snapshots()
                            : FirebaseFirestore.instance
                                .collection("Parent")
                                .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            final snap = snapshot.data!.docs;
                            return FutureBuilder(
                                future: Future.wait([
                                  Admin().getAdminID(),
                                  Admin().ParentListView()
                                ]),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: snap.length,
                                      itemBuilder: (context, index) {
                                        //dynamic v = docIDS[index];

                                        return Container(
                                            height: 70,
                                            width: double.infinity,
                                            margin: const EdgeInsets.only(
                                                bottom: 1),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.black12),
                                              ),
                                            ),
                                            child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Container(
                                                      width: 90,
                                                      height: 100,
                                                      margin: EdgeInsets.only(
                                                          bottom: 10, top: 10),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.white60
                                                          //color:
                                                          // Color(0xffD6D6D6),
                                                          ),
                                                      child: Center(
                                                          child: Icon(
                                                              Icons.person,
                                                              size: 40,
                                                              color: Color(
                                                                      0xff57d77a)
                                                                  .withOpacity(
                                                                      0.4))),
                                                    ),
                                                  ),
                                                  //to only show the allowed people to admin

                                                  InkWell(
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 90),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        snap[index]['Name'],
                                                        style: const TextStyle(
                                                          color: const Color(
                                                              0xff0da6c2),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      int Tab = 5;
                                                      Navigator.of(context).push(
                                                          CupertinoPageRoute(
                                                        builder: (context) =>
                                                            Nav(
                                                          TheValue: "",
                                                          index: 1,
                                                          whichpag: 0,
                                                          DropDown: false,
                                                          Confirm: false,
                                                          documentId: snapshot
                                                              .data![1][index],
                                                          TabValue: 14,
                                                        ),
                                                      ));
                                                    },
                                                  ),
                                                ]));
                                      },
                                    );
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                });
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: (searchname != "" && searchname != null)
                            ? FirebaseFirestore.instance
                                .collection("Student")
                                .where("Search", arrayContains: searchname)
                                .snapshots()
                            : FirebaseFirestore.instance
                                .collection("Student")
                                .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            final snap = snapshot.data!.docs;
                            return FutureBuilder(
                                future: Future.wait([
                                  Admin().getAdminID(),
                                  Admin().StudentListveiw()
                                ]),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: snap.length,
                                      itemBuilder: (context, index) {
                                        //dynamic v = docIDS[index];
                                        Map<String, dynamic>? mapid =
                                            snap[index].data()
                                                as Map<String, dynamic>;
                                        // print("mapcheck ${mapid}");
                                        String? adminId = mapid['AdminID'];

                                        String? adminIdnew =
                                            snapshot.data![0][0];
                                        bool isAdmin = adminIdnew == adminId;
                                        //(snap[index]['AdminID'] == AdminID[0])
                                        return isAdmin
                                            ? Container(
                                                height: 70,
                                                width: double.infinity,
                                                margin: const EdgeInsets.only(
                                                    bottom: 1),
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors.black12),
                                                  ),
                                                ),
                                                child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(),
                                                      ),

                                                      Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: Container(
                                                          width: 90,
                                                          height: 100,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 10,
                                                                  top: 10),
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  Colors.white60
                                                              //color:
                                                              // Color(0xffD6D6D6),
                                                              ),
                                                          child: Center(
                                                              child: Icon(
                                                                  Icons.person,
                                                                  size: 40,
                                                                  color: Color(
                                                                          0xff57d77a)
                                                                      .withOpacity(
                                                                          0.4))),
                                                        ),
                                                      ), //to only show the allowed people to admin

                                                      InkWell(
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 90),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            snap[index]['Name'],
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
                                                        onTap: () {
                                                          int Tab = 15;
                                                          Navigator.of(context)
                                                              .push(
                                                                  CupertinoPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Nav(
                                                              documentId:
                                                                  snapshot.data![
                                                                      1][index],
                                                              TabValue: 15,
                                                              TheValue: "",
                                                              whichpag: 0,
                                                              DropDown: false,
                                                              Confirm: false,
                                                              index: 1,
                                                            ),
                                                          ));
                                                        },
                                                      ),
                                                      //container for button
                                                    ]))
                                            : const SizedBox();
                                      },
                                    );
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                });
                          } else {
                            return const SizedBox();
                          }
                        },
                      )
                      /* StreamBuilder<QuerySnapshot>(
                        stream: (searchname != "" && searchname != null)
                            ? FirebaseFirestore.instance
                                .collection("Student")
                                .where("Search", arrayContains: searchname)
                                .snapshots()
                            : FirebaseFirestore.instance
                                .collection("Studdent")
                                .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            final snap12 = snapshot.data!.docs;
                            return FutureBuilder(
                                future: Future.wait([
                                  Admin().getAdminID(),
                                  Admin().StudentListveiw()
                                ]),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: snap12.length,
                                      itemBuilder: (context, index12) {
                                        //dynamic v = docIDS[index];

                                        return Container(
                                            height: 70,
                                            width: double.infinity,
                                            margin: const EdgeInsets.only(
                                                bottom: 1),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.black12),
                                              ),
                                            ),
                                            child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(

                                                      //for profile image

                                                      ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Container(
                                                      width: 90,
                                                      height: 100,
                                                      margin: EdgeInsets.only(
                                                          bottom: 10, top: 10),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.white60
                                                          //color:
                                                          // Color(0xffD6D6D6),
                                                          ),
                                                      child: Center(
                                                          child: Icon(
                                                              Icons.person,
                                                              size: 40,
                                                              color: Color(
                                                                      0xff57d77a)
                                                                  .withOpacity(
                                                                      0.4))),
                                                    ),
                                                  ),
                                                  //to only show the allowed people to admin

                                                  InkWell(
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 90),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        snap12[index12]['Name'],
                                                        style: const TextStyle(
                                                          color: const Color(
                                                              0xff0da6c2),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      int Tab = 15;
                                                      Navigator.of(context).push(
                                                          CupertinoPageRoute(
                                                        builder: (context) =>
                                                            Nav(
                                                          documentId:
                                                              snapshot.data![1]
                                                                  [index12],
                                                          TabValue: 15,
                                                          TheValue: "",
                                                          whichpag: 0,
                                                          DropDown: false,
                                                          Confirm: false,
                                                          index: 1,
                                                        ),
                                                      ));
                                                    },
                                                  ),
                                                ]));
                                      },
                                    );
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                });
                          } else {
                            return const SizedBox();
                          }
                        },
                      )*/
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
