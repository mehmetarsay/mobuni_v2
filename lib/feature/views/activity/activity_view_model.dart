import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/core/components/dropdown/custom_dropdown.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/constants/enum/hive_enum.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/core/manager/hive/hive_manager.dart';
import 'package:mobuni_v2/core/utils/helpers.dart';
import 'package:mobuni_v2/feature/models/activity/activity_model.dart';
import 'package:mobuni_v2/feature/models/activity_category/activity_category_model.dart';
import 'package:mobuni_v2/feature/models/university/university_model.dart';
import 'package:mobuni_v2/feature/views/activity/service/activity_service.dart';
import 'package:mobuni_v2/feature/views/auth/service/auth_service.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:stacked/stacked.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as refresh;

class ActivityViewModel extends BaseViewModel {
  ActivityService activityService = locator<ActivityService>();
  refresh.RefreshController refreshController = refresh.RefreshController(initialRefresh: true);

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
    if (!data.containsKey(HiveBoxKey.activities.name)) {
      await data.put(HiveBoxKey.activities.name, []);
    }
    setInitialised(true);
    timer = Timer.periodic(Duration(seconds: 100), (Timer t) {
      newActivitySzieCalculate();
    });
    filterLoad();
    notifyListeners();
  }

  filterLoad() async {
    await getCategory();
    universityList = await locator<AuthService>().getAllUniversity();
    UniversityModel allUniversity = UniversityModel(id: null, name: 'Hepsi');
    universityList.add(allUniversity);
  }

  getCategory() async {
    try {
      categories = GeneralManager.hiveM.hive.get(HiveBoxKey.categories.name) ?? [];
    } catch (e) {
      categories = [];
    }
    if (categories.isEmpty) {
      List<ActivityCategoryModel> categoryList = await locator<ActivityService>().getAllCategory();
      categories = categoryList;
      locator<HiveManager>().hive.delete(HiveBoxKey.categories.name);
      locator<HiveManager>().hive.put(HiveBoxKey.categories.name, categories);
      notifyListeners();
    }
    categories.forEach((element) {
      element.isSelected = false;
    });
  }

  Future newActivitySzieCalculate() async {
    if (data.get(HiveBoxKey.activitiesUpdateDate.name) != null) {
      DateTime? dateTime = DateTime.tryParse(data.get(HiveBoxKey.activitiesUpdateDate.name));

      ///TODO fdü db saatini normale alınca kaldırılacak
      dateTime = dateTime!.subtract(Duration(hours: 3));

      ///TODO fdü bu methodun filtresini genişletecek sonra değişecek
      newActivitySize = await activityService.getActivitySize(universityId: 1, dateTime: dateTime);
      return newActivitySize;
    } else {
      newActivitySize = 0;
    }
  }

  onTapNewActivity() async {
    refreshController.requestRefresh();
  }

  Future get getActivities async {
    var categoryList = [];
    for (var i in categories) {
      if (i.isSelected) categoryList.add(i.id);
    }
    var result = await activityService.activityGetAll(
      pageIndex: pageIndex,
      categories: categoryList,
      universityId: universityId,
    );
    if(result!=null){
      hasNextPage = result.hasNextPage;
      var list = data.get(HiveBoxKey.activities.name);
      if (list == null || pageIndex == 1) list = [];
      (list as List).addAll(result.items);
      await data.put(HiveBoxKey.activities.name, list);
      pageIndex++;
    }
    else{
      refreshController.refreshFailed();
      refreshController.loadFailed();
    }
  }

  void addActivity(ActivityModel activity) async {
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
    } else {
      refreshController.refreshFailed();
    }
  }

  Future onLoading() async {
    if (hasNextPage) {
      await getActivities;
      refreshController.loadComplete();
    } else {
      refreshController.loadNoData();
    }
  }

  ///Filter
  List<ActivityCategoryModel> categories = [];
  List universityList = [];
  int? universityId;

  Future filterBottomSheet(BuildContext context) async {
    return await showBarModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (BuildContext context) {
              bool b = false;
              return StatefulBuilder(
                  builder: (BuildContext context, setState) => Container(
                        height: context.height / 2.4,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        universityId = null;
                                        categories.forEach((element) {
                                          element.isSelected = false;
                                        });
                                        setState(() {});
                                      },
                                      child: Text(
                                        'Sıfırla',
                                        style: TextStyle(fontSize: 15),
                                      ))
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                children: [
                                  CustomText(
                                    'Kategoriler',
                                    style: TextStyle(color: context.theme.secondaryHeaderColor, fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GridView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 100, childAspectRatio: 3 / 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
                                itemCount: categories.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      categories[index].isSelected = !categories[index].isSelected;
                                      setState(() {});
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: CustomText(
                                        categories[index].name!,
                                        style: TextStyle(
                                          color: categories[index].isSelected ? context.theme.primaryColorLight : context.theme.primaryColorDark,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: categories[index].isSelected ? context.theme.primaryColorDark : context.theme.primaryColorLight,
                                          border: Border.all(
                                            color: categories[index].isSelected ? context.theme.primaryColorLight : context.theme.primaryColorDark,
                                          ),
                                          borderRadius: BorderRadius.circular(10)),
                                    ),
                                  );
                                }),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                children: [
                                  CustomText(
                                    'Üniversite',
                                    style: TextStyle(color: context.theme.secondaryHeaderColor, fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomDropdown(
                              labelText: 'University',
                              items: universityList,
                              isLoading: false,
                              initId: universityId,
                              voidCallback: (value) {
                                if (value != null)
                                  universityId = value as int;
                                else
                                  universityId = null;
                              },
                            ),
                          ],
                        ),
                      ));
            },
          );
        });
  }
}
