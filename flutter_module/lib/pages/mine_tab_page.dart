// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_module/unit/http_request.dart';

class MineTabPage extends StatefulWidget {
  final String data;

  const MineTabPage({Key key, this.data}) : super(key: key);

  @override
  _MineTabPageState createState() => _MineTabPageState();
}

class _MineTabPageState extends State<MineTabPage> {
  final TextEditingController _controller = TextEditingController();

  GlobalKey<ScaffoldState> key = GlobalKey();

  // VoidCallback removeListener;

  ValueNotifier<bool> withContainer = ValueNotifier(false);

  void _getRequestData() {
    BoostChannel.instance
        .sendEventToNative("event", {'data': "event from flutter"});
  }

  @override
  void initState() {
    super.initState();

    ///这里添加监听，原生利用'event'这个key发送过来消息的时候，下面的函数会调用，
    ///这里就是简单的在flutter上弹一个弹窗
    // removeListener =
    //     BoostChannel.instance.addEventListener("event", (key, arguments) {
    //   OverlayEntry entry = OverlayEntry(builder: (_) {
    //     return Center(
    //         child: Material(
    //       color: Colors.transparent,
    //       child: Container(
    //         alignment: Alignment.center,
    //         width: 100,
    //         height: 100,
    //         decoration: BoxDecoration(
    //             color: Colors.red, borderRadius: BorderRadius.circular(4)),
    //         child: Text('这是native传来的参数：${arguments.toString()}',
    //             style: const TextStyle(color: Colors.white)),
    //       ),
    //     ));
    //   });

    //   Overlay.of(context).insert(entry);

    //   Future.delayed(const Duration(seconds: 2), () {
    //     entry.remove();
    //   });
    //   return;
    // });
  }

  @override
  void dispose() {
    ///记得解除注册
    // removeListener?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView(
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  _buildUserInfo(),
                  const ListTile(
                    leading: Icon(Icons.add),
                    title: Text('Add account'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Manage accounts'),
                  ),
                ],
                padding: const EdgeInsets.all(10),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _requestTest,
        // onPressed: () async {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void _requestTest() {
    HttpRequest.request("https://is.snssdk.com/api/news/feed/v75/?",
        method: "get", params: {}).then((res) {
      print("_requestTest");
      print(res);
    });
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 38.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ClipOval(
              child: Image.asset(
                "images/icon_user@3x.png",
                width: 80,
              ),
            ),
          ),
          _userInfoDataWidget(),
        ],
      ),
    );
  }

//内容超出边界要使用
  Widget _userInfoDataWidget() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _containerText("dddd", 1, TextOverflow.ellipsis),
          _containerText(
              "发的酸辣粉就到了撒方拉萨来的发的酸辣粉到拉萨饭店时飒飒舒服啦", 2, TextOverflow.ellipsis),
          _containerText("433433443", 1, TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _containerText(String textStr, int maxLines, TextOverflow overflow) {
    return Text(
      textStr,
      style: const TextStyle(fontWeight: FontWeight.bold),
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  Widget emptyBox(double width, double height) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: width,
        height: height,
      ),
    );
  }
}
