//import 'dart:ui';
//import 'package:circlight/Pages/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../../../constants.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../models/show_data_model.dart';

class Person {
  String name;
  Color color;
  Person({required this.name, required this.color});
}

class PanelCenterPage extends StatefulWidget {
  @override
  State<PanelCenterPage> createState() => _PanelCenterPageState();
}

class _PanelCenterPageState extends State<PanelCenterPage> {
  List<ShowData> data = [];
  TextEditingController search = TextEditingController();
  //var now = new DateTime.now();
  // var nDate;
  // var nDatas;
  @override
  void initState() {
    getRecommendedLecture();
    super.initState();
  }

  getRecommendedLecture() {
    try {
      data.clear();
      setState(() {});
      FirebaseFirestore.instance
          .collection("Pickup")
          .snapshots()
          .listen((event) {
        data.clear();
        setState(() {});
        for (int i = 0; i < event.docs.length; i++) {
          ShowData dataModel = ShowData.fromJson(event.docs[i].data());
          data.add(dataModel);
        }
        setState(() {});
      });
      setState(() {});
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    // List<Person> _persons = [
    //   Person(name: "ريناد البشر", color: Color(0xfff8b250)),
    //   Person(name: "سارا الصالح", color: Color(0xffff5182)),
    //   Person(name: "لمى المجحد", color: Color(0xff0293ee)),
    //   Person(name: "أفنان الزومان", color: Color(0xfff8b250)),
    //   Person(name: "سعود السيف", color: Color(0xff13d38e)),
    //   Person(name: "يارا الخالد", color: Color(0xfff8b250)),
    //   Person(name: "تغريد لاسيف", color: Color(0xffff5182)),
    //   Person(name: "محمد البشر", color: Color(0xff0293ee)),
    //   Person(name: "احمد الصالح", color: Color(0xffff5182)),
    //   Person(name: "خالد المجحد", color: Color(0xff13d38e)),
    // ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 233, 233, 233),
        //Constants.purpleLight,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child:
                // nDatas.toString() == "2023-01-13"?
                Column(
              children: [
                // SizedBox(height: 20,),
                // Padding(
                //   padding: const EdgeInsets.only(
                //       top: Constants.kPadding / 2,
                //       right: Constants.kPadding / 2,
                //       left: Constants.kPadding / 2),
                //   //   child: Card(
                //   //     color: Constants.purpleLight,
                //   //     elevation: 3,
                //   //     shape: RoundedRectangleBorder(
                //   //       borderRadius: BorderRadius.circular(50),
                //   //     ),
                //   //     child: Container(
                //   //       width: double.infinity,
                //   //       child: ListTile(
                //   //         //leading: Icon(Icons.sell),
                //   //         title: Text(
                //   //           "Products Available",
                //   //           style: TextStyle(color: Colors.white),
                //   //         ),
                //   //         subtitle: Text(
                //   //           "82% of Products Avail.",
                //   //           style: TextStyle(color: Colors.white),
                //   //         ),
                //   //         trailing: Chip(
                //   //           label: Text(
                //   //             "20,500",
                //   //             style: TextStyle(color: Colors.white),
                //   //           ),
                //   //         ),
                //   //       ),
                //   //     ),
                //   //   ),
                // ),
                //BarChartSample2(),

                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Center(
                    child: TextFormField(
                      controller: search,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        fillColor: Color(0xffF1F1F1),
                        filled: true,
                        suffixIcon: Icon(
                          Icons.search,
                          color: Color(0xffFF9200),
                        ),
                        hintText: 'Search by PName',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: ListView.builder(
                    physics: ScrollPhysics(),
                    itemCount: data.length,
                    shrinkWrap: true,
                    itemBuilder: buildListItem,
                  ),
                ),

                // ListTile(
                //   title: Text('عملية اصطحاب الأطفال'),
                //   tileColor: Color.fromARGB(255, 255, 255, 255),
                // ),

                //  Text(
                //   'أولياء الأمور المتأخرين',
                //   style: TextStyle(
                //     color: Color.fromARGB(255, 30, 34, 76),
                //     fontSize: 16,
                //   ),
                //   textAlign: TextAlign.right,
                //   textDirection: TextDirection.rtl,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(
                //       top: Constants.kPadding,
                //       left: Constants.kPadding / 2,
                //       right: Constants.kPadding / 2,
                //       bottom: Constants.kPadding),
                //   child: Card(
                //     color: Constants.purpleLight,
                //     elevation: 3,
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(20)),
                //     child: Column(
                //       children: List.generate(
                //         _persons.length,
                //             (index) => ListTile(
                //           leading: CircleAvatar(
                //             radius: 15,
                //             child: Text(
                //               _persons[index].name.substring(0, 1),
                //               style: TextStyle(color: Colors.white),
                //             ),
                //             backgroundColor: _persons[index].color,
                //           ),
                //           title: Text(
                //             _persons[index].name,
                //             style: TextStyle(color: Colors.white),
                //           ),
                //           // trailing: IconButton(
                //           //     onPressed: () {},
                //           //     icon: Icon(
                //           //       Icons.message,
                //           //       color: Colors.white,
                //           //     )),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            )
            //: Text("Nppppp"),
            ),
      ),
    );
  }

  Widget buildListItem(BuildContext context, int index) {
    // nDatas =data[index].Date.toString();
    // String now = DateFormat("yyyy-MM-dd").format(DateTime.now());
    // nDate = now;
    var dat = DateFormat('yyyy-MM-dd').format(
            DateTime.fromMillisecondsSinceEpoch(
                int.parse(data[index].Date.toString()))),
        dateForCheck = Jiffy(dat, "yyyy-MM-dd").fromNow();

    if (data[index].PName!.toLowerCase().contains(search.text.toLowerCase())) {
      return dateForCheck.toString().contains("days ago") ||
              dateForCheck.toString().contains("month ago")
          ? Container()
          : GestureDetector(
              onTap: () {
                print("p==${dateForCheck.toString()}");
                print("m==${data[index].Date.toString()}");
              },
              child: Card(
                color: Constants.purpleLight,
                //Color.fromRGBO(45, 45, 90, 1),
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            data[index].Time.toString(),
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  data[index].SName.toString(),
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                                Text(
                                  data[index].PName.toString(),
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(187, 59, 64, 111),
                                  shape: BoxShape.circle),
                              child: Center(
                                  child: Text(
                                data[index].ZoneColor.toString(),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 15,
                                ),
                              ))),
                        ],
                      ),
                    ),
                    // ListTile(
                    //   contentPadding: EdgeInsets.only(left: 15.0, right: 0.0),
                    //   leading: Text(data[index].Time.toString(),
                    //     style: TextStyle(color: Colors.black),
                    //   ),
                    //   title: Text(data[index].SName.toString(),
                    //     style: TextStyle(color: Colors.black),
                    //   ),
                    //   subtitle: Text(data[index].PName.toString(),
                    //     style: TextStyle(color: Colors.black),
                    //   ),
                    //   trailing: Container(
                    //       height: 55,
                    //       width: 55,
                    //       decoration:
                    //       BoxDecoration(color: Colors.teal, shape: BoxShape.circle),
                    //       child: Center(
                    //           child: Text(
                    //             data[index].ZoneColor.toString(),
                    //             style: TextStyle(color: Colors.white),
                    //           ))),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                  ],

                  // List.generate(
                  //   _persons.length,
                  //       (index) => ListTile(
                  //     leading: CircleAvatar(
                  //       radius: 15,
                  //       child: Text(
                  //         _persons[index].name.substring(0, 1),
                  //         textAlign: TextAlign.right,
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //       backgroundColor: _persons[index].color,
                  //     ),
                  //     title: Text(
                  //       _persons[index].name,
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //     // trailing: IconButton(
                  //     //     onPressed: () {},
                  //     //     icon: Icon(
                  //     //       Icons.message,
                  //     //       color: Colors.white,
                  //     //     )),
                  //   ),
                  // ),
                ),
              ),
              //: Container(),
            );
    } else {
      return Container();
    }
  }
}
