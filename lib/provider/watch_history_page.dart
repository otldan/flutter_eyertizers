

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttereyertizer/model/issue_model.dart';
import 'package:fluttereyertizer/repository/history_repository.dart';

class WatchHistoryPageModel extends ChangeNotifier{
  List<Item> itemList = [];
  List<String>watchList = [];

  void loadData () async{
    watchList = await HistoryRepository.loadHistoryData();

    if (watchList != null) {
      var list = watchList.map((value){
        return Item.fromJson(json.decode(value));
      }).toList();
      itemList = list;
      notifyListeners();
    }
  }

  void remove(int dex )async{

    watchList.removeAt(dex);
    HistoryRepository.saveHistoryData(watchList);
    loadData();

  }
}