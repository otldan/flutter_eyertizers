

import 'package:flutter/cupertino.dart';
import 'package:fluttereyertizer/api/api_service.dart';
import 'package:fluttereyertizer/model/issue_model.dart';
import 'package:fluttereyertizer/util/toast_util.dart';

class VideoDetailPageModel with ChangeNotifier{
  List<Item> itemList = [];
  bool loading = true;

  void loadVideoRelateData(int id){
    ApiService.getData('${ApiService.video_related_url}$id',
        success: (result) {
          Issue issue = Issue.fromJson(result);
          itemList = issue.itemList;
          loading = false;
        },
        fail: (e) {
          ToastUtil.showError(e.toString());
          loading = false;
        },
        complete: () => notifyListeners());
  }
}