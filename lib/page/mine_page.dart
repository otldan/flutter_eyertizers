import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttereyertizer/page/watch_history_page.dart';
import 'package:fluttereyertizer/util/navigator_manager.dart';
import 'package:image_picker/image_picker.dart';

/**
 * 我的
 */
class MinePage extends StatefulWidget {
  @override
  _MinePage createState() => _MinePage();
}

class _MinePage extends State<MinePage> with AutomaticKeepAliveClientMixin {
  var _imageFile;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  _showSelectPhotoDialog(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 44,
                    backgroundImage: _imageFile == null
                        ? AssetImage('images/ic_img_avatar.png')
                        : FileImage(_imageFile),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Divider(
                  height: 0.5,
                  color: Colors.black87,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    NavigatorManager.to(WatchHistoryPage());
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "观看记录",
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  )),
              Divider(
                height: 0.5,
                color: Colors.black87,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _showSelectPhotoDialog(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context) {

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _bottomWidget('拍照',(){
            NavigatorManager.back();
            _getImage(ImageSource.camera);
          }),
          _bottomWidget('相册',(){
            NavigatorManager.back();
            _getImage(ImageSource.gallery);
          }),
          _bottomWidget('取消',(){
            NavigatorManager.back();
          }),
        ],
      );
    });
  }
  Widget _bottomWidget(String text,VoidCallback callback){

    return ListTile(
      title: Text(text,textAlign: TextAlign.center,),
      onTap: callback,
    );
  }

  //模拟头像选择修改，目前存储在本地，实际开发应当上传到云存储平台
  Future _getImage(ImageSource source) async {
    var imageFile = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = imageFile;
    });
//    MineRepository.saveAvatarPath(imageFile);//保存到本地
  }
}
