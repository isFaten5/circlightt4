import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import 'Dashboard.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      preferences = value;
      setState(() {});
    });
    super.initState();
  }

  TextEditingController search = TextEditingController();
  int tabIndex = 1;
  SharedPreferences? preferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 233, 233),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                'لوحة المتابعة',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  // Color.fromARGB(255, 30, 34, 76),
                  fontSize: 22,
                ),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          tabIndex = 1;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 85,
                        decoration: BoxDecoration(
                          borderRadius: (BorderRadius.circular(20)),
                          color: tabIndex == 1
                              ? Color.fromARGB(195, 13, 167, 194)
                              : Color.fromARGB(0, 255, 255, 255),
                        ),
                        child: Center(
                          child: Text(
                            "عملية اصطحاب الاطفال",
                            style: TextStyle(
                                color: tabIndex == 1
                                    ? Colors.white
                                    : Color(0xff0da6c2),
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          tabIndex = 2;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 85,
                        decoration: BoxDecoration(
                          borderRadius: (BorderRadius.circular(20)),
                          color: tabIndex == 2
                              ? Color.fromARGB(195, 13, 167, 194)
                              : Color.fromARGB(0, 255, 255, 255),
                        ),
                        child: Center(
                          child: Text(
                            "اولياء الأمور المتأخرين",
                            style: TextStyle(
                                color: tabIndex == 2
                                    ? Colors.white
                                    : Color(0xff0da6c2),
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                ],
              ),
              tabIndex == 1 ? Expanded(child: PanelCenterPage()) : Container(),
              tabIndex == 2 ? Expanded(child: Container()) : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Color kGreyColor = Colors.grey;
  Color kTabOffColor = Color(0xff97999B);
  Color kSkipColor = Color(0xff989898);
  Color kFillColor = Color(0xFFF8F8F8);
}
