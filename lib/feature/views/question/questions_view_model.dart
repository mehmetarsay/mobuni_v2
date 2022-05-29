import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:mobuni_v2/core/constants/enum/hive_enum.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/core/utils/helpers.dart';
import 'package:mobuni_v2/feature/views/question/service/question_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as refresh;
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';

class QuestionsViewModel extends BaseViewModel {
  QuestionService questionService = locator<QuestionService>();
  var indicator = new GlobalKey<RefreshIndicatorState>();
  refresh.RefreshController refreshController =
  refresh.RefreshController(initialRefresh: true);

  int _newQuestionSize = 0;
  int get newQuestionSize => _newQuestionSize;
  set newQuestionSize(int value) {
    _newQuestionSize = value;
    notifyListeners();
  }

  Timer? timer;
  @override
  dispose() {
    if (timer != null) timer!.cancel();
    super.dispose();
  }

  late Box _data;
  Box get data => _data;
  set data(Box value) {
    _data = value;
    notifyListeners();
  }

  int pageIndex = 1;
  bool hasNextPage = false;


  init() async {
    setInitialised(false);
    data = await Hive.openBox(HiveBox.data.name);
    await data.put(HiveBoxKey.questions.name, []);
    setInitialised(true);
    timer = Timer.periodic(Duration(seconds: 100), (Timer t) {
      newQuestionSzieCalculate();
    });
    notifyListeners();
  }

  Future get getAllQuestions async {
    var result = await questionService.questionGetByUniversityId(
      universityId: GeneralManager.user.university!.id!,
      pageIndex: pageIndex,
    );
    hasNextPage = result.hasNextPage;
    var list = data.get(HiveBoxKey.questions.name);
    if (list == null || pageIndex == 1) list = [];
    (list as List).addAll(result.items);
    await data.put(HiveBoxKey.questions.name, list);
    pageIndex++;
  }

  Future newQuestionSzieCalculate() async {
    if(data.get(HiveBoxKey.questionsUpdateDate.name)!=null){
      DateTime? dateTime = DateTime.tryParse(data.get(HiveBoxKey.questionsUpdateDate.name));
      ///TODO fdü db saatini normale alınca kaldırılacak
      dateTime = dateTime!.subtract(Duration(hours: 3));
      newQuestionSize = await questionService.getQuestionSize(universityId: GeneralManager.user.university!.id!,dateTime: dateTime);
      return newQuestionSize;
    }
    else{
      newQuestionSize = 0;
    }

  }

  onTapNewQuestions() async {
   refreshController.requestRefresh();
  }

  Future onRefresh() async {
    pageIndex = 1;
    newQuestionSize = 0;
    refreshController.resetNoData();
    if (await checkInternet()) {
      await getAllQuestions;
      await data.put(HiveBoxKey.questionsUpdateDate.name, DateTime.now().toString());
      refreshController.refreshCompleted();
      Fluttertoast.showToast(msg: 'Sorular Güncel');
    }
    else{
      refreshController.refreshFailed();
    }

  }
  Future onLoading() async {
    if(hasNextPage){
      await getAllQuestions;
      refreshController.loadComplete();
    }
    else{
      refreshController.loadNoData();
    }
  }


}
