import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttereyertizer/model/rank_list_page_model.dart';
import 'package:fluttereyertizer/widget/loading_container.dart';
import 'package:fluttereyertizer/widget/provoder_widget.dart';
import 'package:fluttereyertizer/widget/rank_widget_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RankListPage extends StatefulWidget {
  final String apiUrl;

  const RankListPage({Key key, this.apiUrl}) : super(key: key);

  @override
  _RankListPageState createState() {
    // TODO: implement createState
    return _RankListPageState();
  }
}

class _RankListPageState extends State<RankListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<RankListPageModel>(
      model: RankListPageModel(),
      builder: (cotext, model, child) {
        return LoadingContainer(
          loading: model.loading,
          child: SmartRefresher(
            controller: model.refreshController,
            enablePullUp: true,
            enablePullDown: true,
            onRefresh: model.loadData,
            child: ListView.separated(itemBuilder: (context,index){
              return RankWidgetItem(item: model.itemList[index],);
            }, separatorBuilder: (context,index){
              return Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Divider(height: 0.5));
            }, itemCount:model.itemList.length),

          ),
        );
      },
      onModelInit: (model) {
        model.init(widget.apiUrl);
        model.loadData();
      },
    );
  }
}
