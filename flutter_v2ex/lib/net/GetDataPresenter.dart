import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_v2ex/StringData.dart';
import 'package:flutter_v2ex/modle/FeedDetailData.dart';
import 'package:flutter_v2ex/modle/FeedItemData.dart';
import 'package:flutter_v2ex/modle/NodeItemData.dart';
import 'package:flutter_v2ex/modle/NodesItemData.dart';
import 'package:html/dom.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:html/parser.dart' show parse;
import 'package:path_provider/path_provider.dart';

class GetDataPresenter {
  Dio dio = Dio();
  String html = '''<h1>HTML2MD Demo</h1>

<p>This demonstrates <a href="https://github.com/jarontai/html2md">html2md</a> – an HTML to Markdown converter in Dart.</p>

<h2>Usage</h2>

<pre><code class="language-dart">import 'package:html2md/html2md.dart' as html2md;
void main() {
  print(html2md.convert('&lt;h1&gt;Hello world&lt;/h1&gt;'));
}</code></pre>

<hr />

<p>It aims to be <a href="http://commonmark.org/">CommonMark</a> compliant, and includes options to style the output. These options include:</p>

<ul>
  <li>headingStyle (setext or atx)</li>
  <li>horizontalRule (*, -, or _)</li>
  <li>bullet (*, -, or +)</li>
  <li>codeBlockStyle (indented or fenced)</li>
  <li>fence (` or ~)</li>
  <li>emDelimiter (_ or *)</li>
  <li>strongDelimiter (** or __)</li>
  <li>linkStyle (inlined or referenced)</li>
  <li>linkReferenceStyle (full, collapsed, or shortcut)</li>
</ul>''';

  Future<List<FeedItemData>> getFeedsListData(String tab) async {
    String url = StringData.baseFeedUrl + "$tab";
    print(url);
    Response response = await dio.get(url);
    Document document = parse(response.data.toString());
    List<Element> elementList = document.getElementsByClassName("cell item");
    List<FeedItemData> resultList = List();
    for (Element element in elementList) {
      FeedItemData data = new FeedItemData();
      List<Element> list =
          element.querySelector("tr").getElementsByTagName("td");
      for (int i = 0; i < list.length; i++) {
        if (i == 0) {
          String image = list[i].querySelector("img").attributes["src"];
          String img = "https://" + image.substring(2, image.length);
          data.avatarUrl = img;
        } else if (i == 2) {
          Element e = list[i];
          String url = e
              .querySelector("span[class=item_title]")
              .querySelector("a")
              .attributes["href"];
          String title =
              e.querySelector("span[class=item_title]").querySelector("a").text;
          String tag = e
              .querySelector("span[class=topic_info]")
              .querySelector("a[class=node]")
              .text;
          String time =
              e.querySelector("span[class=topic_info]").text.split("•")[2];
          String username =
              e.querySelector("span[class=topic_info]").text.split("•")[1];
          data.title = title;
          data.url = url;
          data.tag = tag;
          data.userName = username.trim();
          data.time = time.trim();
          if (e.querySelector("span[class=topic_info]").text.split("•").length >
              3) {
            data.lastReplay =
                e.querySelector("span[class=topic_info]").text.split("•")[3];
          }
        } else if (i == 3) {
          String count = "0";
          if (list[3].getElementsByClassName("count_livid").length > 0) {
            count = list[3].getElementsByClassName("count_livid")[0].text;
          }
          data.replyCount = count;
        }
      }
      resultList.add(data);
    }
    return resultList;
  }

  Future<FeedDetailData> getDetail(String url) async {
    FeedDetailData data = new FeedDetailData();
    String _url = StringData.baseUrl + url.substring(1, url.length);
    Response response = await dio.get(_url);
    Document document = parse(response.data.toString());
    List<Element> e = document.getElementsByClassName("markdown_body");

    if (e.length > 0) {
      data.content = e[0].text;
      print(e[0].text);
    }

    List<Element> subList = document.getElementsByClassName("subtle");
    for (int i = 0; i < subList.length; i++) {
      data.subContent.add(subList[i].text);
    }
    print(html2md.convert(html));
    return data;
  }

  Future<List<NodesItemData>> getNodsList() async {
    String _url = StringData.baseUrl + "api/nodes/all.json";
    Response response = await dio.get(_url);
    List mlist = response.data;

    List<NodesItemData> list = new List();

    list = mlist.map((m) => new NodesItemData.formJson(m)).toList();
    return list;
  }

  Future<List<NodesItemData>> getLocalNodeList() async {
    String text;

    text = await rootBundle.loadString('assets/nodes.txt');
    print(text);

    //   final file = File('${directory.path}/lib/modle/nodes');
    // text = await file.readAsString();
    print(text);
    List mlist = json.decode(text);

    List<NodesItemData> list = new List();

    list = mlist.map((m) => new NodesItemData.formJson(m)).toList();
    return list;
  }

  Future<List<NodeItemData>> getHomePageNodesList() async {
    String url = StringData.baseUrl;
    print(url);
    Response response = await dio.get(url);
    Document document = parse(response.data.toString());
    List<NodeItemData> result = new List();
    List<Element> list = document
        .getElementById('Main')
        .getElementsByClassName('box')[1]
        .getElementsByClassName('cell');
    for (int i = 1; i < list.length; i++) {
      NodeItemData nodesItemData = new NodeItemData();
      nodesItemData.title = list[i].getElementsByClassName('fade')[0].text;
      List<Element> subList = list[i].querySelectorAll('a');
      List<NodeData> nodeList = new List();
      for (int i = 0; i < subList.length; i++) {
        NodeData data = new NodeData();
        data.name = subList[i].text;
        data.url = subList[i].attributes['href'];
        nodeList.add(data);
        print(data.url);
      }
      nodesItemData.list = nodeList;
      result.add(nodesItemData);
    }
    return result;
  }
}
