import 'package:flutter/material.dart';
import 'package:flutter_v2ex/modle/NodeItemData.dart';

class NodeItemView extends StatefulWidget {
  var context;
  NodeItemData data;

  NodeItemView(this.data, this.context);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NodeItemView(data, context);
  }
}

class _NodeItemView extends State<NodeItemView> {
  var context;
  NodeItemData data;

  _NodeItemView(this.data, this.context);

  List<Widget> _widgetList = new List();

  @override
  void initState() {
    data.list.forEach((f) => _widgetList.add(new GestureDetector(
          child: Container(
              padding: EdgeInsets.all(5),
              child: Text(
                f.name,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(245, 245, 245, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              )),
        )));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
        child:
            /*new Row(
        children: <Widget>[
          Text(data.title),*/
            Wrap(
      direction: Axis.horizontal,
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.start,
      children: _widgetList,
    )
        //   ],
        //    ),
        );
  }
}
