

import 'dart:convert';

import 'package:fluttereyertizer/model/issue_model.dart';
import 'package:fluttereyertizer/util/app_manager.dart';
import 'package:fluttereyertizer/util/constant.dart';

class HistoryRepository{

  static saveWatchHistory(Item item) async{
    List<String> watchList = AppManager.prefs.getStringList(Contant.watchHistoryList);

    if (watchList == null) {
      watchList = List();
    }

    var jsonParm = item.toJson();
    var jsonStr = json.encode(jsonParm);
    if (!watchList.contains(jsonStr)) {

      watchList.add(json.encode(jsonParm));
      AppManager.prefs.setStringList(Contant.watchHistoryList, watchList);
    }
  }


  static Future<List<String>> loadHistoryData() async{

    return AppManager.prefs.getStringList(Contant.watchHistoryList);
  }

  static saveHistoryData(List<String> watchHistoryList) async {
    AppManager.prefs.setStringList(Contant.watchHistoryList,watchHistoryList);
  }

}