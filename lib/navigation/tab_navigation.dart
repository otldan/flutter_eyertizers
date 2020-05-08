

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttereyertizer/page/discover_page.dart';
import 'package:fluttereyertizer/page/home_page.dart';
import 'package:fluttereyertizer/page/mine_page.dart';
import 'package:fluttereyertizer/page/rank_page.dart';
import 'package:get/get.dart';

class TabNavigation extends StatefulWidget{
  @override
  _TabNavigationState createState() =>_TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  PageController _controller = PageController(initialPage: 0);
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomePage(),DiscoveryPage(),RankPage(),MinePage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        _bottomItem('日报', 'images/ic_home_normal.png',
            'images/ic_home_selected.png', 0),
        _bottomItem('发现', 'images/ic_discovery_normal.png',
            'images/ic_discovery_selected.png', 1),
        _bottomItem('热门', 'images/ic_hot_normal.png',
            'images/ic_hot_selected.png', 2),
        _bottomItem('我的', 'images/ic_mine_normal.png',
            'images/ic_mine_selected.png', 3)
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: (index){
        _controller.jumpToPage(index);
        setState(() {
          _currentIndex = index;
        });
      },),
    );
  }


  _bottomItem(String title,String normalIcon,String selectIon,int index){

    return BottomNavigationBarItem(
      icon: Image.asset(normalIcon,width: 22,height: 22,),
      activeIcon: Image.asset(selectIon,width: 22,height: 22,),
      title: Padding(
        padding: EdgeInsets.only(top: 5),
        child: Text(title,style: TextStyle(color: Color(_currentIndex == index ?0xff000000 : 0xff9a9a9a),fontSize: 12),),
      ),
    );
  }
}