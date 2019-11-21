import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_v2ex/view/FeedsPageView.dart';
import 'package:flutter_v2ex/view/NodesPageView.dart';
import 'package:flutter_v2ex/view/PersonInfoPageView.dart';
import 'package:flutter_v2ex/view/ReplyPageView.dart';

void main() {
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarDividerColor: Colors.white,
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  /* List<String> titleList=[
    "首页","节点","我的"
  ];*/
  TabController _controller;
  int currentIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  int _page = 0;
  List<Widget> _pageList ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = TabController(vsync: this, length: 4)..addListener((){
      setState(() {
        currentIndex=_controller.index;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _pageList = [
      FeedsPageView(context),
      NodesPageView(context),
      PersonInfoPageView(),
      ReplyPageView()
    ];
    return new Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.black87,
        height: 50,
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(Icons.home, size: 20),
          Icon(Icons.list, size: 20),
          Icon(Icons.mail, size: 20),
          Icon(Icons.person, size: 20),
        ],
        onTap: (index) {
          setState(() {
            currentIndex=index;
          });
          _controller.animateTo(index,duration: Duration(milliseconds: 300), curve: Curves.ease);
        },
      ),

      body: TabBarView(
        controller: _controller,
        children: _pageList,

      ),

      /* body: new CupertinoTabScaffold(
        tabBar: new CupertinoTabBar(items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), title: Text("首页")),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.tags), title: Text("节点")),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.time_solid), title: Text("回复")),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_solid), title: Text("我的")),
        ]),
        tabBuilder: (BuildContext context, int index) {
          return _pageList[index];
        },
      ) ,*/
    );
  }
}
