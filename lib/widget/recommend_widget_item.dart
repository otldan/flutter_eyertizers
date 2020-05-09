

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttereyertizer/model/recommend_model.dart';
import 'package:fluttereyertizer/page/recommend_photo_gallery_page.dart';
import 'package:fluttereyertizer/page/recommend_video_play_page.dart';
import 'package:fluttereyertizer/util/navigator_manager.dart';

class RecommendWidgetItem extends StatelessWidget{
  final RecommendItem item;

  const RecommendWidgetItem({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: (){
        if (item.data.content.type == 'video') {
          NavigatorManager.to(RecommendVideoPlayPage(playUrl: item.data.content.data.playUrl,));
        }
        else {
          NavigatorManager.to(RecommendPhotoGalleryPage(
            galleryItems: item.data.content.data.urls,
          ));
        }
      },
      child: Card(
        //和ClipRRect 区别多个 阴影
        child: PhysicalModel(
          color: Colors.white,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _imageItem(context),
              _contentTextItem(),
              _infoTextItem()
            ],
          ),
        ),
      ),
    );
  }

  _contentTextItem(){

    return Container(
      padding: EdgeInsets.fromLTRB(6, 10, 6, 10),
      child: Text(item.data.content.data.description,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: TextStyle(fontSize: 14,color: Colors.black87),),
    );
  }

  _imageItem(BuildContext context){
    var maxWidth = MediaQuery.of(context).size.width/2;
    var maxHeight = MediaQuery.of(context).size.height/2;
    var height = (item.data.content.data.height == 0 ? maxHeight /2 : item.data.content.data.height) * (maxWidth / item.data.content.data.width);

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth,maxHeight: maxHeight),
      child: Stack(
        children: <Widget>[
          CachedNetworkImage(
              imageUrl: item.data.content.data.cover.feed,
              fit: BoxFit.cover,
              width: maxWidth,
              height: height),
          Positioned(
            top: 5,
            right: 5,
            child: Offstage(
                offstage: item.data.content.data.urls != null &&
                    item.data.content.data.urls.length == 1,
                child: Icon(
                  item.data.content.type == 'video'
                      ? Icons.play_circle_outline
                      : Icons.photo_library,
                  color: Colors.white,
                  size: 18,
                )
            ),
          )
        ],
      ),
    );
  }

  _infoTextItem(){

    return Container(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween ,
        children: <Widget>[
         Row(
           children: <Widget>[
             PhysicalModel(
               //类似于ClipRRect
               color: Colors.transparent,
               clipBehavior: Clip.antiAlias,
               borderRadius: BorderRadius.circular(12),
               child: CachedNetworkImage(
                   width: 24,
                   height: 24,
                   imageUrl: item.data.content.data.owner.avatar),
             ),
             Container(
               padding: EdgeInsets.all(5),
               width: 80,
               child: Text(
                 item.data.content.data.owner.nickname,
                 maxLines: 1,
                 overflow: TextOverflow.ellipsis,
                 style: TextStyle(fontSize: 12),
               ),
             )
           ],
         ),
          Row(
            children: <Widget>[
              Icon(
                Icons.thumb_up,
                size: 14,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(left: 3),
                child: Text(
                  '${item.data.content.data.consumption.collectionCount}',
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}