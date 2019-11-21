import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_v2ex/modle/FeedItemData.dart';
import 'package:flutter_v2ex/net/GetDataPresenter.dart';
import 'package:flutter_v2ex/view/FeedListItemView.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 *  首页每个tab下的ViewPage
 */
class FeedsListPageView extends StatefulWidget {
  String requestKey;
  var _context;

  FeedsListPageView(this.requestKey, this._context);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FeedsListPageView(requestKey, _context);
  }
}

class _FeedsListPageView extends State<FeedsListPageView>
    with AutomaticKeepAliveClientMixin {
  String _requestKey;
  var _context;
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);

  _FeedsListPageView(this._requestKey, this._context);

  List<FeedItemData> dataList = List();
  GetDataPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = new GetDataPresenter();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build

    return Container(
      child: SmartRefresher(
        enablePullDown: true,
        controller:_refreshController,
        header: WaterDropHeader(),
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                //滑动动画
                verticalOffset: 50.0,
                child: FeedListItemView(dataList[index], _context),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> _refresh() async {
    dataList.clear();
    print(_requestKey);
    return presenter.getFeedsListData(_requestKey).then((onValue) {
      setState(() {
        dataList.addAll(onValue);
        _refreshController.refreshCompleted();
      });
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
