import 'package:flutter/material.dart';
import 'package:web/control/content.dart';
import 'package:web/model/content.dart';
import 'Content/contentPage.dart';

class Body extends StatefulWidget {
  const Body({required this.textFiledMap, Key? key, required this.userId}) : super(key: key);
  final Map textFiledMap;
  final String userId;

  static _BodyState? of(BuildContext context) => context.findAncestorStateOfType<_BodyState>();

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool reloadCheck = true;

  set setBool(bool check) {
    reload();
  }

  void reload() async {
    setState(() {
      reloadCheck = false;
    });
    await Future.delayed(Duration(milliseconds: 5));
    setState(() {
      reloadCheck = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        width: 1050,
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
                padding: EdgeInsets.all(15),
                height: 100,
                color: Colors.black,
                child: Text('검색내용 : ${widget.textFiledMap.values.join('getTextFiledMap')}', textScaleFactor: 2, style: TextStyle(color: Colors.white))),
            Container(
                padding: EdgeInsets.all(15),
                height: 100,
                color: Colors.black,
                child: Text('검색결과 : ${widget.textFiledMap.values.join('getTextFiledMap')}', textScaleFactor: 2, style: TextStyle(color: Colors.white)))
          ]),
          if (reloadCheck)
            FutureBuilder(
                future: MainContentControl.getContent2(),
                builder: (context, snap) {
                  if (!snap.hasData) {
                    return Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ));
                  } else {
                    return AllContentPage(data: snap.data as List<MainContentDataModel>, userId: widget.userId);
                  }
                })
        ]));
  }
}
