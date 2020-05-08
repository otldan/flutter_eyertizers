import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttereyertizer/page/video_detail_page.dart';
import 'package:fluttereyertizer/provider/watch_history_page.dart';
import 'package:fluttereyertizer/util/navigator_manager.dart';
import 'package:fluttereyertizer/widget/provoder_widget.dart';
import 'package:fluttereyertizer/widget/videl_relate_widget_item.dart';

class WatchHistoryPage extends StatefulWidget {
  @override
  _WatchHistoryPageState createState() => _WatchHistoryPageState();
}

class _WatchHistoryPageState extends State<WatchHistoryPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => NavigatorManager.back(),
            child: Icon(
              Icons.arrow_back,
              size: 20,
              color: Colors.black,
            )),
        title: Text(
          '观看记录',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
      ),
      body: ProviderWidget<WatchHistoryPageModel>(
        model: WatchHistoryPageModel(),
        onModelInit: (model) {
          model.loadData();
        },
        builder: (context, model, child) {
          return Stack(
            children: <Widget>[
              Offstage(
                offstage: model.itemList == null || model.itemList.length == 0,
                child: Container(
                  child: ListView.separated(
                      itemBuilder: (context,index){
                        return Slidable(

                          actionPane: SlidableDrawerActionPane(),
                          child: VideoRelateWidgetItem(
                            item: model.itemList[index],
                            callback: (){
                              NavigatorManager.to(VideoDetailPage(item:model.itemList[index],));
                            },
                            titleColor: Colors.black87,
                            categoryColor: Colors.black26,
                            openHero: true,
                          ),
                          secondaryActions: <Widget>[
                            IconSlideAction(
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () => model.remove(index),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context,index){
                        return Padding(
                          padding: EdgeInsets.only(left: 15,top: 5,right: 15),
                          child: Divider(
                            height: 0.5,
                          ),
                        );
                      },
                      itemCount: model.itemList.length),
                  decoration: BoxDecoration(color: Colors.white),
                ),
              ),
              Offstage(
                offstage: model.itemList != null && model.itemList.length > 0,
                child: Center(
                  child: Image.asset('images/ic_no_data.png'),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
