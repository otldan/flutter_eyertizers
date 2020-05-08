import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttereyertizer/model/issue_model.dart';

class VideoRelateWidgetItem extends StatelessWidget {
  final Item item;
  final VoidCallback callback;
  final Color titleColor;
  final Color categoryColor;
  final bool openHero;

  const VideoRelateWidgetItem(
      {Key key,
      this.item,
      this.callback,
      this.titleColor = Colors.white,
      this.categoryColor = Colors.white,
      this.openHero = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: _coverWidget(),
                ),
                Positioned(
                  right: 5,
                  bottom: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(color: Colors.black54),
                      child: Text(
                        DateUtil.formatDateMs(item.data.duration * 1000,
                            format: 'mm:ss'),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(item.data.title,
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                          '#${item.data.category} / ${item.data.author?.name}',
                          style: TextStyle(
                            color: categoryColor,
                            fontSize: 12,
                          )),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _coverWidget() {
    if (openHero) {
      return Hero(
        tag: '${item.data.id}${item.data.time}',
        child: _imageWidget(),
      );
    } else {
      return _imageWidget();
    }
  }

  Widget _imageWidget() {
    return CachedNetworkImage(
        imageUrl: item.data.cover.detail,
        errorWidget: (context, url, error) =>
            Image.asset('images/img_load_fail.png'),
        width: 135,
        height: 80,
        fit: BoxFit.cover);
  }
}
