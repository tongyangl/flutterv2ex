import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NodesPageView extends StatefulWidget {
  var _context;

  NodesPageView(this._context);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _NodesPageView(_context);
  }
}

class _NodesPageView extends State<NodesPageView> {
  var _context;

  _NodesPageView(this._context);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StaggeredGridView.countBuilder(
      crossAxisCount: 3,
      itemCount:4,
      itemBuilder: (BuildContext context, int index) =>
      new Container(
          color: Colors.green,
          child: new Center(
            child: new CircleAvatar(
              backgroundColor: Colors.white,
              child: new Text('$index'),
            ),
          )), staggeredTileBuilder: (int index) {

    },

    );
  }
}
