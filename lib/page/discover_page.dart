import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttereyertizer/page/category_page.dart';
import 'package:fluttereyertizer/page/follow_page.dart';
import 'package:fluttereyertizer/page/recommend_page.dart';

const TAB_LABEL = ['关注', '分类', '推荐'];

/**
 * 发现
 */
class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryState createState() => _DiscoveryState();
}

class _DiscoveryState extends State<DiscoveryPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '发现',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
      ),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Color(0xff9a9a9a),
              labelStyle: TextStyle(fontSize: 14),
              unselectedLabelStyle: TextStyle(fontSize: 14),
              indicatorColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: TAB_LABEL.map((String tab) {
                return Tab(
                  text: tab,
                );
              }).toList(),
              onTap: (index) {
                _pageController.animateToPage(index,
                    duration: kTabScrollDuration, curve: Curves.ease);
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index){
                _tabController.index= index;
              },
              children: <Widget>[
                FollowPage(),
                CategoryPage(),
                RecommendPage(),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: TAB_LABEL.length, vsync: this);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
