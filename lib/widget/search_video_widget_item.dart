import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttereyertizer/model/issue_model.dart';
import 'package:fluttereyertizer/page/video_detail_page.dart';
import 'package:fluttereyertizer/util/navigator_manager.dart';

class SearchVideoWidgetItem extends StatelessWidget {
  final Item item;

  const SearchVideoWidgetItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        NavigatorManager.to(VideoDetailPage(
          item: item,
        ));
      },
      child: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Hero(
                tag: '${item.data.id}${item.data.time}',
                child: CachedNetworkImage(
                  width: double.infinity, //撑满整个屏幕
                  height: 220,
                  imageUrl: item.data.cover.feed,
                  fit: BoxFit.cover,
                )),
            Positioned(
              child: Column(
                children: <Widget>[
                  Text(
                    item.data.title,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.black54),
                        padding: EdgeInsets.all(5),
                        child:  Text(
                          DateUtil.formatDateMs(item.data.duration * 1000,
                              format: 'mm:ss'),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
