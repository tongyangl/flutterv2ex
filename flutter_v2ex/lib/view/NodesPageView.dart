import 'package:cached_network_image/cached_network_image.dart';
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

class _NodesPageView extends State<NodesPageView>
    with AutomaticKeepAliveClientMixin {
  var _context;

  _NodesPageView(this._context);

  List<NodesItemData> _list = new List();

  @override
  void initState() {
    GetDataPresenter presenter = new GetDataPresenter();
    presenter.getLocalNodeList().then((onValue) {
      setState(() {
        _list = onValue;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    return new StaggeredGridView.countBuilder(
      crossAxisCount: 8,
      itemCount: _list.length,
      itemBuilder: (BuildContext context, int index) => Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 60,
            height: 60,
            margin: EdgeInsets.only(top: 3, right: 4, left: 5),
            child: new ClipOval(
              child: new CachedNetworkImage(
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  imageUrl: _list[index].avatar_normal),
            ),
          ),
          Text(_list[index].name),
          Text(_list[index].stars.toString()+"个关注")
        ],
      )),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(4, index == 0 ? 1.5 : 3),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
