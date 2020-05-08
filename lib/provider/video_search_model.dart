import 'package:flutter/material.dart';
import 'package:fluttereyertizer/api/api_service.dart';
import 'package:fluttereyertizer/model/issue_model.dart';
import 'package:fluttereyertizer/util/toast_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VideoSearchModel extends ChangeNotifier {
  bool loading = true;
  bool hideKeyWord = false;
  bool hideEmpty = true;
  List<Item> dataList = [];
  String _nextPageUrl;
  List<String> keyWords = [];
  String query = '';
  int total = 0;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  getKeyWords() {
    ApiService.getData(ApiService.keyword_url, success: (result) {
      List responseList = result as List;
      keyWords = responseList.map((value) {
        return value.toString();
      }).toList();
      notifyListeners();
    }, fail: (e) {
      ToastUtil.showError(e.toString());
    });
  }

  loadMore({loadMore = true}) {
    String url;
    if (loadMore) {
      if (_nextPageUrl == null) {
        refreshController.loadNoData();
        return;
      }
      url = _nextPageUrl;
      getData(loadMore, url);
    } else {
      loading = true;
      url = ApiService.search_url + query;
      getData(loadMore, url);
    }
  }

  getData(bool loadMore, String url) {
    ApiService.getData(url,
        success: (result) {
          Issue issue = Issue.fromJson(result);

          loading = false;
          total = issue.total;
          if (!loadMore) {
            dataList.clear();
            dataList.addAll(issue.itemList);
            hideEmpty = dataList.length > 0;
          } else {
            dataList.addAll(issue.itemList);
            hideEmpty = true;
          }
          _nextPageUrl = issue.nextPageUrl;
          hideKeyWord = true;

          refreshController.loadComplete();
        },
        fail: (e) {
          ToastUtil.showError(e.toString());
          loading = false;
          refreshController.loadFailed();
        },
        complete: () => notifyListeners());
  }
}
