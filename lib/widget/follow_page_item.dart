import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttereyertizer/model/issue_model.dart';
import 'package:fluttereyertizer/widget/follow_widget_item.dart';

class FollowPageItem extends StatelessWidget {
  final Item item;

  const FollowPageItem({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          Container(
            child: ListTile(
              leading:  ClipOval(child: CachedNetworkImage(
                width: 44,
                height: 44,
                imageUrl: item.data.header.icon,
              ),),
              title: Text(item.data.header.title,style: TextStyle(fontSize: 14,color: Colors.black),),
              subtitle:Text(item.data.header.description,style: TextStyle(fontSize: 12,color: Colors.black),maxLines: 1,overflow: TextOverflow.ellipsis,) ,
              trailing: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Color(0xFFF4F4F4)),
                  child: Text('+ 关注',
                    style: TextStyle(fontSize: 12, color: Colors.grey),)
                ),
              ),
            ),
          ),
          Container(
            height: 220,
            child: ListView.builder(itemBuilder: (context,index){
              return FollowWidgetItem(item: item.data.itemList[index]);
            },
            itemCount: item.data.itemList.length,
            scrollDirection: Axis.horizontal,),
          ),

        ],
      ),
    );
  }
}