

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttereyertizer/api/api_service.dart';
import 'package:fluttereyertizer/model/tab_info_model.dart';
import 'package:fluttereyertizer/page/rank_list_page.dart';
import 'package:fluttereyertizer/util/toast_util.dart';

/**
 * 热门
 */
class RankPage extends StatefulWidget {
  @override
  _RankPage createState() => _RankPage();
}

class _RankPage extends State<RankPage> with TickerProviderStateMixin,AutomaticKeepAliveClientMixin{
  TabController _tabController;
  PageController _pageController;
  List<TabInfoItem> _tabList = [];

  @override
  void initState() {
    _tabController = TabController(vsync: this,length:_tabList.length );
    _pageController = PageController();
    _loadData();
  }

  @override
  void dispose(){
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        title: Text('人气榜',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),),
        brightness: Brightness.light,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          TabBar(
            controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Color(0xff9a9a9a),
          labelStyle: TextStyle(fontSize: 14),
          unselectedLabelStyle: TextStyle(fontSize: 14),
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: _tabList.map((TabInfoItem tabInfoItem){
            return Tab(text: tabInfoItem.name,);
          }).toList(),
          onTap: (index){
              _pageController.animateToPage(index, duration: kTabScrollDuration, curve: Curves.ease);
          },),
          Expanded(child: PageView(
            controller: _pageController,
            onPageChanged: (indexl){
              _tabController.index= indexl;
            },
            children: _tabList.map((TabInfoItem item){
              return RankListPage(apiUrl: item.apiUrl,);
            }).toList(),
          ),)
        ],
      ),
    );
  }

  void _loadData() async {
    await ApiService.getData(ApiService.rank_url,success: (result){
      TabInfoModel tabInfoModel = TabInfoModel.fromJson(result);

      if (mounted) {
        setState(() {
          _tabList = tabInfoModel.tabInfo.tabList;
          _tabController = TabController(length: _tabList.length, vsync: this);
        });
      }
    },fail: (e){
      ToastUtil.showError(e.toString());
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}