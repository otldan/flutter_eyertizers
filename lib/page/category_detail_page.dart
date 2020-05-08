import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttereyertizer/model/category_model.dart';
import 'package:fluttereyertizer/provider/category_detail_model.dart';
import 'package:fluttereyertizer/util/navigator_manager.dart';
import 'package:fluttereyertizer/widget/loading_container.dart';
import 'package:fluttereyertizer/widget/provoder_widget.dart';
import 'package:fluttereyertizer/widget/rank_widget_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * 发现  分类 详情
 */
class CategoryDetailPage extends StatefulWidget {
  final CategoryModel categoryModel;

  const CategoryDetailPage({Key key, this.categoryModel}) : super(key: key);

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: ProviderWidget<CategoryDetailModel>(
        model: CategoryDetailModel(widget.categoryModel.id),
        onModelInit: (model) {
          model.loadMore(loadMore: false);
        },
        builder: (context, model, child) {
          return LoadingContainer(
            loading: model.loading,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    leading: GestureDetector(
                        onTap: () => NavigatorManager.back(),
                        child: Icon(Icons.arrow_back, color: Colors.black)),
                    elevation: 0,
                    brightness: Brightness.light,
                    backgroundColor: Colors.white,
                    expandedHeight: 200.0,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        widget.categoryModel.name,
                        style: TextStyle(color: Colors.black),
                      ),
                      centerTitle: true,
                      background: CachedNetworkImage(
                          imageUrl: widget.categoryModel.bgPicture,
                          fit: BoxFit.cover),
                    ),
                  ),
                ];
              },
              body: SmartRefresher(
                enablePullDown: false,
                enablePullUp: true,
                onLoading: model.loadMore,
                controller: model.refreshController,
                child: ListView.builder(
                    itemCount: model.itemList.length,
                    itemBuilder: (context, index) {
                      return RankWidgetItem(item: model.itemList[index],showCategory: false,showDivider: false,);
                    }),
              ),
            ),
          );
        },
      ),
    );
  }
}
