import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v2ex/modle/FeedItemData.dart';
import 'package:flutter_v2ex/net/GetDataPresenter.dart';
import 'package:flutter_v2ex/view/FeedListItemView.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'ContentTitleView.dart';

class DetailView extends StatefulWidget {
  FeedItemData _data;

  DetailView(this._data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DetailView(_data);
  }
}

class _DetailView extends State<DetailView> {
  FeedItemData _data;
  GetDataPresenter presenter;
  String _content = " ";
  List<String> subContent;

  _DetailView(this._data);

  @override
  void initState() {
    super.initState();
    presenter = new GetDataPresenter();
    presenter.getDetail(_data.url).then((onValue) {
      setState(() {
        _content = onValue.content;
        subContent = onValue.subContent;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = new List();
    list.add(ContentTitleView(_data, context));
    list.add(HtmlWidget(
      _content,
      config: new HtmlWidgetConfig(hyperlinkColor: Colors.blue),
    ));
    if (subContent != null && subContent.length > 0) {
      for (int i = 0; i < subContent.length; i++) {
        list.add(HtmlWidget(subContent[i]));
      }
    }
    // TODO: implement build
    return CupertinoApp(
        home: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              leading: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              trailing: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              middle: Text("话题"),
            ),
            child: SingleChildScrollView(
                child: Container(
              margin: EdgeInsets.only(top: 90, left: 15, right: 15),
              child: Column(
                children: list,
              ),
            ))));
  }
}
