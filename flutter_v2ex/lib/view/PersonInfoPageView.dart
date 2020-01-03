import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v2ex/view/LoginPageView.dart';

class PersonInfoPageView extends StatefulWidget {
  var _context;

  PersonInfoPageView(this._context);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PersonInfoPageView(_context);
  }
}

class _PersonInfoPageView extends State<PersonInfoPageView> {
  var _context;

  _PersonInfoPageView(this._context);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new LoginPageView();
  }
}
