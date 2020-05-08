import 'package:flutter/material.dart';
import 'package:fluttereyertizer/api/api_service.dart';
import 'package:fluttereyertizer/model/category_model.dart';
import 'package:fluttereyertizer/util/toast_util.dart';

class CategoryPageModel with ChangeNotifier {
  List<CategoryModel> list = [];
  bool loading = true;

  void loadData() async {
    ApiService.getData(ApiService.category_url,
        success: (result) {
          List responseList = result as List;
          List<CategoryModel> categoryList = responseList
              .map((model) => CategoryModel.fromJson(model))
              .toList();
          this.list = categoryList;
          loading = false;
        },
        fail: (e) {
          ToastUtil.showError(e.toString());
          loading = false;
        },
        complete: () => notifyListeners());
  }
}
