import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class AddNewBlock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _AddNewBlockState();
  }
}

class _AddNewBlockState extends State<AddNewBlock> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Add New Block',
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(
                left: 16.0,
                top: 24.0,
                bottom: 8.0,
              ),
              child: new Text(
                'Add New Block',
                style: new TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[300],
                ),
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
              child: new Text('Block Name'),
            ),
            new Container(
              margin: const EdgeInsets.fromLTRB(16.0, 8.0, 0.0, 8.0),
              child: new Text(
                'Block A1',
                style:
                    new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
            new Divider(
              color: Colors.grey,
            ),
            new Container(
              margin: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
              child: new Text(
                'NO. OF FLOORS',
                style: new TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
            new Container(
              child: new Row(
                children: <Widget>[
                  new Flexible(
                    child: new CustomScrollView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      slivers: <Widget>[
                        new SliverPadding(
                          padding: const EdgeInsets.all(20.0),
                          sliver: new SliverList(
                            delegate: new SliverChildListDelegate(
                              <Widget>[
                                const Text('this'),
                                const Text('is'),
                                const Text('scroll'),
                                const Text('view'),
                                const Text('inside'),
                                const Text('list'),
                                const Text('view'),
                                const Text('in'),
                                const Text('horizontal'),
                                const Text('direction')
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
