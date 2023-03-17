import 'package:circlight/Controller/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';
import 'dart:async';

import 'package:intl/intl.dart';

class Personclass {
  String? name;
  String? deviceid;
  Personclass({this.deviceid, this.name});
}

// ignore: deprecated_member_use
final DBref = FirebaseDatabase.instance.reference();
int ledStatus = 0;
bool isLoading = false;

class FeaturedScreenX extends StatefulWidget {
  const FeaturedScreenX({Key? key}) : super(key: key);

  @override
  _FeaturedScreenState createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreenX> {
  var pickUpController = Get.put(PickupController());

//to add new person

  List<Personclass> selectedPersonList = [];
  // var nameList = [];
  // List<Personclass> personlist = [];
  //create a funcution where list of selected name in and personlist is out
  List<Personclass> getSelectedPersonList(List<Personclass> selectedNameList) {
    List<Personclass> selectedPersonList = [];
    setState(() {
      for (int i = 0; i < pickUpController.personList.length; i++) {
        setState(() {
          if (selectedNameList.contains(pickUpController.personList[i])) {
            selectedPersonList.add(pickUpController.personList[i]);
          }
        });
      }
    });
    return selectedPersonList;
  }

  Future getDocs() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("Student").get();
    setState(() {
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        FirebaseFirestore.instance
            .collection("Student")
            .doc(querySnapshot.docs[i].id)
            .get()
            .then((value) {
          //nameList.add(value.data()!["Name"]);
          pickUpController.personList.add(Personclass(
              name: value.data()!["Name"],
              deviceid: value.data()!["DeviceId"]));
        });

        var a = querySnapshot.docs[i];
        print("*************************");
        print(a.id);
        print("Renad");
        print(a);
        print("*************************");
      }
    });
  }

  addPerson(String name, String deviceid) async {
    await FirebaseFirestore.instance.collection("Student").add({
      "Name": name,
      "DeviceId": deviceid,
    });

    setState(() {
      getDocs();
    });
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      getSelectedPersonList(selectedPersonList);
      getDocs();
      //nameList.length;
    });
  }

  CollectionReference ref2 = FirebaseFirestore.instance.collection("Pickup");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
              child: SizedBox(
                  height: Get.height * 0.12,
                  child: Obx(() {
                    return ListView.builder(
                        itemCount: pickUpController.personList.length + 1,
                        scrollDirection: pickUpController.personList.isEmpty
                            ? Axis.horizontal
                            : Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: index == 0
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          pickUpController
                                              .updateDataHome("all");
                                          pickUpController
                                              .updateCategoryIndex(index);
                                          pickUpController.selectedname.clear();
                                          selectedPersonList.clear();
                                        });
                                        print(
                                            "this is all ${pickUpController.categoryIndex.value}");
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.07,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.07,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: pickUpController
                                                                .categoryIndex
                                                                .value ==
                                                            index
                                                        ? Color.fromRGBO(
                                                            90, 180, 168, 1)
                                                        : Colors.transparent,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(80),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.asset(
                                                  'assets/images/person.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                          SizedBox(
                                            height: 5, // <-- SEE HERE
                                          ),
                                          Text(
                                            "الجميع",
                                            style: TextStyle(
                                                color: pickUpController
                                                            .categoryIndex
                                                            .value ==
                                                        index
                                                    ? Color.fromRGBO(
                                                        90, 180, 168, 1)
                                                    : Colors.black,
                                                fontSize: Get.height * 0.018),
                                          )
                                        ],
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        pickUpController.updateDataHome("all");

                                        if (pickUpController.selectedname
                                            .contains(pickUpController
                                                .personList[index - 1])) {
                                          pickUpController.selectedname.remove(
                                              pickUpController
                                                  .personList[index - 1]);
                                        } else {
                                          pickUpController.selectedname.add(
                                              pickUpController
                                                  .personList[index - 1]);
                                        }

                                        pickUpController
                                            .updateCategoryIndex(-1);

                                        selectedPersonList =
                                            getSelectedPersonList(
                                                pickUpController.selectedname);

                                        for (int i = 0;
                                            i < selectedPersonList.length;
                                            i++) {
                                          print(selectedPersonList[i].name);
                                        }

                                        print(pickUpController
                                            .personList[index - 1].name);
                                        setState(() {});
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(80),
                                              border: Border.all(
                                                  color: pickUpController
                                                          .selectedname
                                                          .contains(
                                                              pickUpController
                                                                      .personList[
                                                                  index - 1])
                                                      ? Color.fromRGBO(
                                                          90, 180, 168, 1)
                                                      : Colors.transparent,
                                                  width: 2),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(80),
                                              child: Image.network(
                                                "",
                                                fit: BoxFit.fill,
                                                errorBuilder: (context,
                                                    exception, stackTrace) {
                                                  return ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: Image.asset(
                                                      'assets/images/person.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5, // <-- SEE HERE
                                          ),
                                          Text(
                                            pickUpController
                                                .personList[index - 1].name!,
                                            style: TextStyle(
                                                color: pickUpController
                                                        .selectedname
                                                        .contains(
                                                            pickUpController
                                                                    .personList[
                                                                index - 1])
                                                    ? Color.fromRGBO(
                                                        90, 180, 168, 1)
                                                    : Colors.black,
                                                fontSize: Get.height * 0.018),
                                          )
                                        ],
                                      ),
                                    ));
                        });
                  })),
            ),
            SizedBox(
              height: 10, // <-- SEE HERE
            ),
            Obx(() {
              return Row(
                children: [
                  pickUpController.data.value == "all"
                      ? Expanded(
                          child: GestureDetector(
                            onTap: () {
                              LightBlue();
                            },
                            child: Container(
                              height: 120.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image:
                                        AssetImage("assets/icons/BlueZone.png"),
                                  )),
                            ),
                          ),
                        )
                      : Expanded(
                          child: Container(
                            height: 120.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(10), //HERE is
                                image: DecorationImage(
                                  colorFilter: new ColorFilter.mode(
                                      Color.fromARGB(0, 255, 255, 255)
                                          .withOpacity(0.2),
                                      BlendMode.dstATop),
                                  image:
                                      AssetImage("assets/icons/BlueZone.png"),
                                )),
                          ),
                        ),
                  pickUpController.data.value == "all"
                      ? Expanded(
                          child: GestureDetector(
                            onTap: () {
                              LightYellow();
                            },
                            child: Container(
                              height: 120.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/icons/YellowZone.png"))),
                            ),
                          ),
                        )
                      : Expanded(
                          child: Container(
                            height: 120.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    colorFilter: new ColorFilter.mode(
                                        Color.fromARGB(0, 255, 255, 255)
                                            .withOpacity(0.2),
                                        BlendMode.dstATop),
                                    image: AssetImage(
                                        "assets/icons/YellowZone.png"))),
                          ),
                        ),
                ],
              );
            }),
            SizedBox(
              height: 25, // <-- SEE HERE
            ),
            Row(
              children: [
                pickUpController.data.value == "all"
                    ? Expanded(
                        child: GestureDetector(
                          onTap: () {
                            LightGreen();
                          },
                          child: Container(
                            height: 120.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                "assets/icons/GreenZone.png",
                              ),
                            )),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Container(
                          height: 120.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            colorFilter: new ColorFilter.mode(
                                Color.fromARGB(0, 255, 255, 255)
                                    .withOpacity(0.2),
                                BlendMode.dstATop),
                            image: AssetImage(
                              "assets/icons/GreenZone.png",
                            ),
                          )),
                        ),
                      ),
                pickUpController.data.value == "all"
                    ? Expanded(
                        child: GestureDetector(
                          onTap: () {
                            LightRed();
                          },
                          child: Container(
                            height: 120.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                              'assets/icons/RedZone.png',
                            ))),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Container(
                          height: 120.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  colorFilter: new ColorFilter.mode(
                                      Color.fromARGB(0, 255, 255, 255)
                                          .withOpacity(0.2),
                                      BlendMode.dstATop),
                                  image: AssetImage(
                                    'assets/icons/RedZone.png',
                                  ))),
                        ),
                      ),
              ],
            ),
          ],
        ));
  }

  Future LightBlue() async {
    setrbgcolors(Colors.blue);

    var SName;
    // for (int i = 0; i < personlist.length; i++) {
    SName = pickUpController.personList[0].name;
    print(SName);
    //}
    //print(SName);
    final now = DateTime.now();
    //final current = now.toIso8601String();
    DateTime date = new DateTime(now.year, now.month, now.day);

    //DateTime dateT = new DateTime(now.hour, now.minute, now.second);

    final currentD = date.toString().replaceAll("00:00:00.000", "");
    final currentT = DateFormat.jms().format(DateTime.now());

    await FirebaseFirestore.instance.collection("Pickup").add({
      "Date": currentD,
      "PName": "RenadXD",
      "SName": SName,
      "Time": currentT,
      "ZoneColor": "Blue"
    });

    //final now = DateTime.now();
    final current = now.toIso8601String();
    print(current);
    //setrbgcolors(Color.fromARGB(255, 171, 23, 13));
    // var headers = {
    //   'Authorization': 'Basic UmVuYWQ6UmVuYWQzMjExMjMq',
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/vnd.com.nsn.cumulocity.event+json',
    // };
    // var request = http.Request(
    //     'POST', Uri.parse('https://iotccis21.cumulocity.com/event/events'));
    // request.body = json.encode({
    //   "source": {"id": "7361393"},
    //   "type": "Parent Arrived!",
    //   "text": "Parent arrived at Blue zone! ",
    //   "time": current
    // });
    // request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }
  }

  Future LightGreen() async {
    setrbgcolors(Color.fromARGB(255, 23, 170, 28));

    var SName;
    for (int i = 0; i < selectedPersonList.length; i++) {
      SName = selectedPersonList[i].name;
    }

    final now = DateTime.now();
    final current = now.toIso8601String();
    //print(current);

    DateTime date = new DateTime(now.year, now.month, now.day);
    //DateTime dateT = new DateTime(now.hour, now.minute, now.second);

    final currentD = date.toString().replaceAll("00:00:00.000", "");
    final currentT = DateFormat.jms().format(DateTime.now());

    await FirebaseFirestore.instance.collection("Pickup").add({
      "Date": currentD,
      "PName": "Bandar",
      "SName": SName,
      "Time": currentT,
      "ZoneColor": "Green"
    });

    //setrbgcolors(Color.fromARGB(255, 171, 23, 13));

    //----------------------------- Cumulocity --------------------------------
    // var headers = {
    //   'Authorization': 'Basic UmVuYWQ6UmVuYWQzMjExMjMq',
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/vnd.com.nsn.cumulocity.event+json',
    // };
    // var request = http.Request(
    //     'POST', Uri.parse('https://iotccis21.cumulocity.com/event/events'));
    // request.body = json.encode({
    //   "source": {"id": "7361393"},
    //   "type": "Parent Arrived!",
    //   "text": "Parent arrived at Green zone! ",
    //   "time": current
    // });
    // request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }

    //----------------------------- Cumulocity --------------------------------
  }

  Future LightRed() async {
    setrbgcolors(Color.fromARGB(255, 236, 23, 23));
    var SName;
    for (int i = 0; i < selectedPersonList.length; i++) {
      SName = selectedPersonList[i].name;
    }

    final now = DateTime.now();
    final current = now.toIso8601String();
    //print(current);

    //final current = now.toIso8601String();
    DateTime date = new DateTime(now.year, now.month, now.day);
    //DateTime dateT = new DateTime(now.hour, now.minute, now.second);

    final currentD = date.toString().replaceAll("00:00:00.000", "");
    final currentT = DateFormat.jms().format(DateTime.now());

    await FirebaseFirestore.instance.collection("Pickup").add({
      "Date": currentD,
      "PName": "Bandar",
      "SName": SName,
      "Time": currentT,
      "ZoneColor": "Red"
    });

    //setrbgcolors(Color.fromARGB(255, 171, 23, 13));

//----------------------------- Cumulocity --------------------------------

    // var headers = {
    //   'Authorization': 'Basic UmVuYWQ6UmVuYWQzMjExMjMq',
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/vnd.com.nsn.cumulocity.event+json',
    // };
    // var request = http.Request(
    //     'POST', Uri.parse('https://iotccis21.cumulocity.com/event/events'));
    // request.body = json.encode({
    //   "source": {"id": "7361393"},
    //   "type": "Parent Arrived!",
    //   "text": "Parent arrived at Red zone! ",
    //   "time": current
    // });
    // request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }
//----------------------------- Cumulocity --------------------------------
  }

  Future LightYellow() async {
    setrbgcolors(Colors.yellow);
    var SName;
    for (int i = 0; i < selectedPersonList.length; i++) {
      SName = selectedPersonList[i].name;
    }
    print(SName);

    final now = DateTime.now();
    final current = now.toIso8601String();
    //print(current);

    //final current = now.toIso8601String();
    DateTime date = new DateTime(now.year, now.month, now.day);
    //DateTime dateT = new DateTime(now.hour, now.minute, now.second);

    final currentD = date.toString().replaceAll("00:00:00.000", "");
    final currentT = DateFormat.jms().format(DateTime.now());

    await FirebaseFirestore.instance.collection("Pickup").add({
      "Date": currentD,
      "PName": "Bandar",
      "SName": SName,
      "Time": currentT,
      "ZoneColor": "Yellow"
    });

//----------------------------- Cumulocity --------------------------------
    // var headers = {
    //   'Authorization': 'Basic UmVuYWQ6UmVuYWQzMjExMjMq',
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/vnd.com.nsn.cumulocity.event+json',
    // };
    // var request = http.Request(
    //     'POST', Uri.parse('https://iotccis21.cumulocity.com/event/events'));
    // request.body = json.encode({
    //   "source": {"id": "7361393"},
    //   "type": "Parent Arrived!",
    //   "text": "Parent arrived at Yellow zone! ",
    //   "time": current
    // });
    // request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }
//----------------------------- Cumulocity --------------------------------
  }

  final ref = FirebaseDatabase.instance.ref();

//setpower
  setstatusofpower({bool value = false}) {
    ref.child("/power").set(value ? 1 : 0);
  }

  setrbgcolors(Color color) {
    for (int i = 0; i < selectedPersonList.length; i++) {
      print("hellrbg");

      print("hellrbg");
      print(selectedPersonList[i].name);
      print(pickUpController.personList[i]);
      print(selectedPersonList[i].deviceid);

      String path = "/deviceData/" +
          selectedPersonList[i].deviceid.toString() +
          "/readings" +
          "/rbg";

      String value = color.red.toString() +
          "," +
          color.blue.toString() +
          "," +
          color.green.toString();
      ref.child(path).set(value);
    }
  }
}
