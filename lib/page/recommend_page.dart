

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttereyertizer/model/recommend_model.dart';
import 'package:fluttereyertizer/provider/recommend_page_model.dart';
import 'package:fluttereyertizer/widget/loading_container.dart';
import 'package:fluttereyertizer/widget/provoder_widget.dart';
import 'package:fluttereyertizer/widget/recommend_widget_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RecommendPage extends StatefulWidget {
  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin {


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<RecommendPageModel>(
      model: RecommendPageModel(),
    onModelInit: (model){
        model.refresh();
    },
    builder: (context,model,child){
        return Scaffold(
          body: LoadingContainer(
            loading: model.loading,
            child: Container(
              decoration: BoxDecoration(color: Color(0xfff2f2f2)),
              child: SmartRefresher(
                controller: model.refreshController,
                onRefresh: model.refresh,
                onLoading: model.loadMore,
                enablePullUp: true,
                child: StaggeredGridView.countBuilder(
                itemCount: model.itemList.length
                  ,crossAxisCount: 4, itemBuilder: (BuildContext context,int index){
                  return RecommendWidgetItem(item: model.itemList[index],);
                }, staggeredTileBuilder: (int index){
                  return StaggeredTile.fit(2);
                },
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,),

              ),
            ),
          ),
        );
    },);
  }

}