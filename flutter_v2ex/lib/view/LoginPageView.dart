import 'package:flutter/material.dart';

class LoginPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPageView();
  }
}

class _LoginPageView extends State<LoginPageView> {
  TextEditingController _passwordController ,_userNameController,codeController;

  @override
  void initState() {
    _userNameController = new TextEditingController();
    _passwordController = new TextEditingController();
    codeController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: Scaffold(
        body: Container(
          child: Form(
              child: Column(
            children: <Widget>[
              TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  //键盘回车键的样式
                  textInputAction: TextInputAction.next,
                  controller: _userNameController,
                  decoration: InputDecoration(
                      labelText: "用户名或邮箱",
                      hintText: "用户名或邮箱",
                      icon: Icon(Icons.person)),
                  // 校验用户名
                  validator: (v) {
                    return v.trim().length > 0 ? null : "用户名不能为空";
                  }),
            ],
          )),
        ),
      ),
    );
  }
}
