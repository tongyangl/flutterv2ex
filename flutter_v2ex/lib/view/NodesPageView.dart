import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_v2ex/modle/NodesItemData.dart';

import '../net/GetDataPresenter.dart';
import '../net/GetDataPresenter.dart';

class NodesPageView extends StatefulWidget {
  var _context;

  NodesPageView(this._context);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _NodesPageView(_context);
  }
}

class _NodesPageView extends State<NodesPageView> with AutomaticKeepAliveClientMixin {
  var _context;

  _NodesPageView(this._context);

  List<NodesItemData> _list=new List();

  @override
  void initState() {
    GetDataPresenter presenter = new GetDataPresenter();
    presenter.getNodsList().then((onValue) {
      setState(() {
        _list = onValue;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: _list.length,
      itemBuilder: (BuildContext context, int index) =>
      new Container(
          color: Colors.grey,
          child: new Center(
            child: new CircleAvatar(
              backgroundColor: Colors.white,
              child: new Text(_list[index].title),
            ),
          )),
      staggeredTileBuilder: (int index) =>
      new StaggeredTile.count(2, index.isEven ? 2 : 1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
