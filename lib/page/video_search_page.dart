import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttereyertizer/provider/video_search_model.dart';
import 'package:fluttereyertizer/util/navigator_manager.dart';
import 'package:fluttereyertizer/widget/loading_container.dart';
import 'package:fluttereyertizer/widget/provoder_widget.dart';
import 'package:fluttereyertizer/widget/search_video_widget_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * 视频搜索
 */
class VideoSearchPage extends StatelessWidget {
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: SafeArea(
            child: ProviderWidget<VideoSearchModel>(
          model: VideoSearchModel(),
          onModelInit: (model) => model.getKeyWords(),
          builder: (context, model, child) {
            return Column(
              children: <Widget>[
                _searchBar(model, context),
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: <Widget>[
                      _keyWordWidget(model),
                      _searchVideoWidget(model),
                      _emptyWidget(model),
                    ],
                  ),
                )
              ],
            );
          },
        )),
      ),
    );
  }

  Widget _searchVideoWidget(VideoSearchModel model) {

    return Offstage(
      offstage: model.dataList == null
       || model.dataList.length == 0,
      child: LoadingContainer(
        loading: model.loading,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20,bottom: 20),
              child: Text('— 「${model.query}」搜索结果共${model.total}个 —',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  )),
            ),
            Expanded(
              child:SmartRefresher(
                enablePullDown: false,
                enablePullUp: true,
                onLoading: model.loadMore(),
                controller: model.refreshController,
                child: ListView.builder(itemBuilder:(context,index){
                  return SearchVideoWidgetItem(item: model.dataList[index],);
                },itemCount: model.dataList.length,),
              ) ,flex: 1,)
          ],
        ),
      ),
    );
  }
    Widget _searchBar(VideoSearchModel model, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, right: 16),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 20,
              color: Colors.black26,
            ),
            onPressed: () {
              NavigatorManager.back();
            },
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 30),
              child: TextField(
                autofocus: true,
                focusNode: focusNode,
                onSubmitted: (str) {
                  model.query = str;
                  model.loadMore(loadMore: false);
                },
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 16),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20,
                    color: Colors.black26,
                  ),
                  fillColor: Color(0x0D000000),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20)),
                  hintStyle: TextStyle(fontSize: 13),
                  hintText: '帮你找到感兴趣的视频',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _keyWordWidget(VideoSearchModel model) {
    return Offstage(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Center(
              child: Text(
                '- 热搜关键字 -',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              10,
              20,
              10,
              0,
            ),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 6,
              runSpacing: 6,
              children: _keyWordWidgets(model),
            ),
          )
        ],
      ),
      offstage: model.hideKeyWord,
    );
  }

  List<Widget> _keyWordWidgets(VideoSearchModel model) {
    return model.keyWords.map((keword) {
      return GestureDetector(
        onTap: () {
          focusNode.unfocus();
          model.query = keword;
          model.loadMore(loadMore: false);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(14, 8, 14, 8),
          decoration: BoxDecoration(
              color: Color(0x1A000000),
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            keword,
            style: TextStyle(fontSize: 12, color: Colors.black45),
          ),
        ),
      );
    }).toList();
  }


  Widget _emptyWidget(VideoSearchModel model){

    return Offstage(
      offstage: model.hideEmpty,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.sentiment_dissatisfied,
                size: 60, color: Colors.black54),
            Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  '暂无数据',
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ))
          ],
        ),
      ),
    );
  }
}
