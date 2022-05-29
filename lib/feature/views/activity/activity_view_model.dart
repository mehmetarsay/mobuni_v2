import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/constants/enum/hive_enum.dart';
import 'package:mobuni_v2/core/utils/helpers.dart';
import 'package:mobuni_v2/feature/models/activity/activity_model.dart';
import 'package:mobuni_v2/feature/views/activity/service/activity_service.dart';
import 'package:stacked/stacked.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as refresh;

class ActivityViewModel extends BaseViewModel {
  ActivityService activityService = locator<ActivityService>();
  refresh.RefreshController refreshController =
  refresh.RefreshController(initialRefresh: true);

  int _newQuestionSize = 0;
  int get newActivitySize => _newQuestionSize;
  set newActivitySize(int value) {
    _newQuestionSize = value;
    notifyListeners();
  }
  Timer? timer;
  @override
  dispose() {
    if (timer != null) timer!.cancel();
    super.dispose();
  }
  int pageIndex = 1;
  bool hasNextPage = false;

  late Box _data;
  Box get data => _data;
  set data(Box value) {
    _data = value;
    notifyListeners();
  }

  init() async {
    setInitialised(false);
    data = await Hive.openBox(HiveBox.data.name);
    setInitialised(true);
    timer = Timer.periodic(Duration(seconds: 100), (Timer t) {
      newActivitySzieCalculate();
    });
    notifyListeners();
  }

  Future newActivitySzieCalculate() async {
    if(data.get(HiveBoxKey.activitiesUpdateDate.name)!=null){
      DateTime? dateTime = DateTime.tryParse(data.get(HiveBoxKey.activitiesUpdateDate.name));
      ///TODO fdü db saatini normale alınca kaldırılacak
      dateTime = dateTime!.subtract(Duration(hours: 3));
      ///TODO fdü bu methodun filtresini genişletecek sonra değişecek
      newActivitySize = await activityService.getActivitySize(universityId: 1,dateTime: dateTime);
      return newActivitySize;
    }
    else{
      newActivitySize = 0;
    }

  }


  onTapNewActivity() async {
    refreshController.requestRefresh();
  }

  Future get getActivities async {
    var result = await activityService.activityGetAll(pageIndex: pageIndex);
    hasNextPage = result.hasNextPage;
    var list = data.get(HiveBoxKey.activities.name);
    if (list == null || pageIndex == 1) list = [];
    (list as List).addAll(result.items);
    await data.put(HiveBoxKey.activities.name, list);
    pageIndex++;
  }

  void addActivity(ActivityModel activity) async{
    var list = data.get(HiveBoxKey.activities.name);
    if (list == null) list = [];
    (list as List).insert(0, activity);
    await data.put(HiveBoxKey.activities.name, list);
    notifyListeners();
  }

  Future onRefresh() async {
    pageIndex = 1;
    newActivitySize = 0;
    refreshController.resetNoData();
    if (await checkInternet()) {
      await getActivities;
      await data.put(HiveBoxKey.activitiesUpdateDate.name, DateTime.now().toString());
      refreshController.refreshCompleted();
      Fluttertoast.showToast(msg: 'Etkinlikler Güncel');
    }
    else{
      refreshController.refreshFailed();
    }

  }
  Future onLoading() async {
    if(hasNextPage){
      await getActivities;
      refreshController.loadComplete();
    }
    else{
      refreshController.loadNoData();
    }
  }
}
