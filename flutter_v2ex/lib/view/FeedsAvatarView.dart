import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedsAvatarView extends StatefulWidget {
  String _url;

  FeedsAvatarView(this._url);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AvatarView(_url);
  }
}

class _AvatarView extends State<FeedsAvatarView> {
  String _url;

  _AvatarView(this._url);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      width: 45,
      height: 45,
      margin: EdgeInsets.only(top: 3, right: 4, left: 5),
      child: new ClipOval(
        child: new CachedNetworkImage(
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Icon(Icons.error),
            placeholder: (context, url) => new CircularProgressIndicator(),
            imageUrl: _url),
      ),
    );
  }
}
