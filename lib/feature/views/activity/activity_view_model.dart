import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/constants/enum/hive_enum.dart';
import 'package:mobuni_v2/core/utils/helpers.dart';
import 'package:mobuni_v2/feature/models/activity/activity_model.dart';
import 'package:mobuni_v2/feature/views/activity/service/activity_service.dart';
import 'package:stacked/stacked.dart';

class ActivityViewModel extends BaseViewModel {
  ActivityService activityService = locator<ActivityService>();

  ScrollController scrollController = ScrollController();
  int pageIndex = 1;
  bool hasNextPage = false;

  bool _isLoadMoreRunning = false;
  bool get isLoadMoreRunning => _isLoadMoreRunning;
  set isLoadMoreRunning(bool value) {
    _isLoadMoreRunning = value;
    notifyListeners();
  }

  late Box _data;
  Box get data => _data;
  set data(Box value) {
    _data = value;
    notifyListeners();
  }

  init() async {
    setInitialised(false);
    setBusy(true);
    data = await Hive.openBox(HiveBox.data.name);
    await fetchActivities();
    scrollController.addListener(_loadMore);
  }

  Future fetchActivities() async {
    
    if (data.containsKey(HiveBoxKey.activities.name)) {
      setBusy(false);
    }
    if (await checkInternet()) {
      await getActivities;
    }
    setBusy(false);
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

    void _loadMore() async {
    if (!_isLoadMoreRunning &&
        scrollController.position.extentAfter < 100 &&
        hasNextPage) {
      isLoadMoreRunning = true;
      await getActivities;
      isLoadMoreRunning = false;
    }
  }
}
