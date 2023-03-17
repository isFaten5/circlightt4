import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  List<String> emails = [];
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Row(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(maxWidth: 200, minWidth: 0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ...emails
                            .map((email) => Chip(
                                  label: Text("lll" + email),
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                        hintText: 'EMail', fillColor: Colors.blueAccent),
                    controller: _emailController,
                    onChanged: (String val) {
                      if (val.endsWith(' '))
                        setState(() {
                          emails.add(_emailController.text);
                          _emailController.text = '';
                        });
                    },
                    onEditingComplete: () {
                      setState(() {
                        emails.add(_emailController.text);
                        _emailController.text = '';
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
