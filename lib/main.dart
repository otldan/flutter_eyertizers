import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttereyertizer/util/app_manager.dart';
import 'package:get/get.dart';

import 'navigation/tab_navigation.dart';

void main() {
  runApp(App());
  if(Platform.isAndroid){
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent)
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    AppManager.init();
    return MaterialApp(
      title: '开眼',
      navigatorKey: Get.key,
      home: TabNavigation(),
    );

  }

  Future<void> hideSplashScreen() async{
  }
}

