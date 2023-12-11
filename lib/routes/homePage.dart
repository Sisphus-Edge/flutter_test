/// homepage 只有login按钮
/// 已弃用

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:untitled/common/global.dart';
import 'package:untitled/models/index.dart';

class HomeRoute extends StatefulWidget{
  // const HomeRoute({super.key});
  const HomeRoute({super.key});

  // final String title;

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}
class _HomeRouteState extends State<HomeRoute> {
  static const loadingTag = "##loading##"; //表尾标记
  var _items = <Repo>[Repo()..name = loadingTag];
  bool hasMore = true;
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        // title: Text("Widget.title"),
      ),
        body:_buildBody(),

      // drawer: MyDrawer(),
    );
  }

  Widget _buildBody(){
    UserModel userModel = Provider.of<UserModel>(context);
    if(!userModel.isLogin){
      return Center(
        child: ElevatedButton(
          child: const Text("Login"),
          onPressed: () => Navigator.of(context).pushNamed("login"),
        ),
      );
    }else{
      return Container(
          alignment:Alignment.center,
          padding: const EdgeInsets.all(16.0),
          child:const Text(
            "test 2023/12/4",
            style: TextStyle(color: Colors.black54),
          )
      );
    }
  }


}
