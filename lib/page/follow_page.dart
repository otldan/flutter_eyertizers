

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttereyertizer/provider/follow_page_model.dart';
import 'package:fluttereyertizer/widget/follow_page_item.dart';
import 'package:fluttereyertizer/widget/loading_container.dart';
import 'package:fluttereyertizer/widget/provoder_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FollowPage extends StatefulWidget{
  @override
  _FollowPageState createState() {
    // TODO: implement createState
    return _FollowPageState();
  }

}
class _FollowPageState extends State<FollowPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ProviderWidget<FollowPageModel>(
      model: FollowPageModel(),
      onModelInit: (model){
        model.refresh();
      },
      builder: (context,model,child){

        return LoadingContainer(
          loading: model.loading,
          child: SmartRefresher(
            controller: model.refreshController,
            onRefresh: model.refresh,
            onLoading: model.loadMore,
            enablePullUp: true,
            child: ListView.separated(itemBuilder: (context,index){
              return FollowPageItem(item: model.itemList[index],);
            },
                separatorBuilder: (context,index){
              return Divider(height: 0.5,);
                }, itemCount: model.itemList.length),
          ),
        );
      },
    );
  }
}
