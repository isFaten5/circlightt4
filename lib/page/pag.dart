import 'package:flutter/material.dart';

class Pag extends StatefulWidget {
  const Pag({Key? key}) : super(key: key);

  @override
  _PagState createState() => _PagState();
}

class _PagState extends State<Pag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Text("data"),
    );
  }
}
