import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_v2ex/modle/NodeItemData.dart';
import 'package:flutter_v2ex/modle/NodesItemData.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../net/GetDataPresenter.dart';
import '../net/GetDataPresenter.dart';
import 'NodeItemView.dart';

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
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);

  _NodesPageView(this._context);

  List<NodeItemData> _list = new List();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    return new Container(
      margin: EdgeInsets.only(top: MediaQuery
          .of(context)
          .padding
          .top),
      child: SmartRefresher(
        controller: _refreshController,
        header: WaterDropHeader(),
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                //滑动动画
                verticalOffset: 50.0,
                child: NodeItemView(_list[index], _context),
              ),
            );
          },
        ),
      ),
    );
  }

  _refresh() {
    GetDataPresenter presenter = new GetDataPresenter();
    presenter.getHomePageNodesList().then((onValue) {
      setState(() {
        _list = onValue;
        _refreshController.refreshCompleted();
      });
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
