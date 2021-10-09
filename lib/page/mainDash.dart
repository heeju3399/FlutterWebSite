import 'package:flutter/material.dart';
import 'package:web/model/shared.dart';
import 'package:web/page/windowDash/header.dart';
import '../responsive.dart';
import 'windowDash/body.dart';

class MainDash extends StatefulWidget {
  const MainDash({Key? key, required this.userId}) : super(key: key);
  final String userId;
  static String routeName = '/MAIN_DASH';
  static _MainDashState? of(BuildContext context) => context.findAncestorStateOfType<_MainDashState>();

  @override
  _MainDashState createState() => _MainDashState(userId: userId);
}

class _MainDashState extends State<MainDash> {
  _MainDashState({required this.userId});
  String userId;
  bool floatingBTN = false;
  bool appBarCenterTitle = true;
  final List<String> items = List<String>.generate(0, (i) => 'Item $i');
  Map getTextFiledMap = {'getTextFiledMap': 'Empty'};

  bool firstCheck = true;

  set setChartPageValue(Map map) {
    print('여기 통과????????????');
    getTextFiledString(map);
  }

  @override
  void initState() {
    MyShared.setUserId(userId);

    super.initState();
  }

  // @override
  // void reassemble() async {
  //   super.reassemble();
  //   await MyShared.getUserId().then((value) => {
  //     userId = value.toString(),
  //     print(value)
  //   });
  //   print('새로고침 $userId');
  // }


  void getTextFiledString(Map map) async {
    bool mapIsEmpty = map.isNotEmpty;
    if (mapIsEmpty) {
      var firstKey = map.keys.first;
      String value = map.values.join(firstKey);
      print(value);
      getTextFiledMap = {'getTextFiledMap': value};
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    print('===Main dash build widget pass userID : $userId ===');
    return WillPopScope(
      onWillPop: () {
        print('뭐지이건?');
        Navigator.pop(context);
        return Future(() => true);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: RawScrollbar(
            thumbColor: Colors.white,
            isAlwaysShown: true,
            radius: Radius.circular(20),
            thickness: 15,
            child: SingleChildScrollView(physics: ScrollPhysics(),child: Responsive.isLarge(context) ? isWindow(context, userId) : isMobile(context)),
        ),
        floatingActionButton: floatingBTN
            ? null
            : FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.add),
              ),
      ),
    );
  }

  Widget isMobile(BuildContext context) {
    floatingBTN = false;
    appBarCenterTitle = false;
    return Center(
      child: Row(children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            color: Colors.red,
            height: 150,
            child: Text(
              'Test Site',
              textScaleFactor: 3,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ), //contents list
      ]),
    );
  }

  Widget isWindow(BuildContext context, String userId) {
    floatingBTN = true;
    appBarCenterTitle = true;
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Divider(
          height: 30,
          color: Colors.black,
          indent: 0,
        ),
        Header(
          userId: userId,
        ),
        Divider(
          height: 30,
          color: Colors.white12,
          indent: 0,
        ),
        Body(
          textFiledMap: getTextFiledMap,
        ),
      ],
    ));
  }
}
