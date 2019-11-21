import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v2ex/view/FeedsListPageView.dart';

class FeedsPageView extends StatefulWidget {
  var _context;

  FeedsPageView(this._context);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FeedsPageView(_context);
  }
}

class _FeedsPageView extends State<FeedsPageView>
    with TickerProviderStateMixin {
  var parentContext;

  _FeedsPageView(this.parentContext);

  List<Widget> _tabList = [
    Tab(text: "全部"),
    Tab(text: "热门"),
    Tab(text: "技术"),
    Tab(text: "创意"),
    Tab(text: "酷工作"),
    Tab(text: "Apple"),
    Tab(text: "交易"),
    Tab(text: "城市"),
  ];
  List<String> _tabKeyList = [
    "all",
    "hot",
    "tech",
    "creative",
    "jobs",
    "apple",
    "deals",
    "city"
  ];
  List<Widget> _tabViewList;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabList.length, vsync: this);
    _tabViewList = List();
    for (int i = 0; i < _tabList.length; i++) {
      _tabViewList.add(new FeedsListPageView(_tabKeyList[i],parentContext));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoTabView(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: TabBar(
            isScrollable: true,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            unselectedLabelColor: Colors.black26,
            unselectedLabelStyle:
                TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
            tabs: _tabList,
            controller: _tabController,
          ),
        ),
        body: TabBarView(controller: _tabController, children: _tabViewList),
      );
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
