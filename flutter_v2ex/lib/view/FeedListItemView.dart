import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v2ex/modle/FeedItemData.dart';
import 'package:flutter_v2ex/view/FeedsAvatarView.dart';

import 'DetailView.dart';

class FeedListItemView extends StatefulWidget {
  FeedItemData _data;
  var context;

  FeedListItemView(this._data, this.context);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FeedListItemView(_data, context);
  }
}

class _FeedListItemView extends State<FeedListItemView> {
  FeedItemData _data;
  var parentContext;

  _FeedListItemView(this._data, this.parentContext);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new GestureDetector(
      onTap: onClickItem,
      child: Container(
        margin: EdgeInsets.only(left: 5,top: 2,bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new FeedsAvatarView(_data.avatarUrl),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 3),
                          child: Text(
                            _data.userName,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          width: 16,
                          height: 16,
                          child: Image.asset("images/tag.png"),
                        ),
                        Text(_data.tag),
                      ],
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 4, left: 3),
                      child: new Row(
                        children: <Widget>[
                          new Text(
                            _data.time,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 13),
                          ),
                          /*
                      new Text(
                        _data.lastReplay == null ? "" : _data.lastReplay,
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      )*/

                          Container(
                            margin: EdgeInsets.only(left: 5),
                            width: 16,
                            height: 16,
                            child: Image.asset("images/comment.png"),
                          ),
                          Text(_data.replyCount),
                        ],
                      ),
                    )
                  ],
                ),
                /* new Expanded(
                  child: new Align(
                alignment: FractionalOffset.centerRight,
                child: Container(
                  height: 30,
                  margin: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Text(_data.replyCount),
                ),
              )),*/
              ],
            ),
            new Container(
              margin: EdgeInsets.only(right: 5, left: 5, top: 2),
              child: Text(
                _data.title,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    color: Colors.black87),
              ),
            ),
            new Container(
              margin: EdgeInsets.only(top: 6, bottom: 6),
              height: 0.5,
              color: Colors.black12,
            )
          ],
        ),
      ),
    );
  }

  onClickItem() {
    Navigator.push(
      parentContext,
      new MaterialPageRoute(builder: (parentContext) => new DetailView(_data)),
    );
  }
}
