import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobuni_v2/core/constants/enum/hive_enum.dart';
import 'package:mobuni_v2/core/utils/helpers.dart';
import 'package:mobuni_v2/feature/views/question/service/question_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';

class QuestionsViewModel extends BaseViewModel {
  QuestionService questionService = locator<QuestionService>();
  var indicator = new GlobalKey<RefreshIndicatorState>();
  ScrollController scrollController = ScrollController();

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

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isLoadMoreRunning = false;
  bool get isLoadMoreRunning => _isLoadMoreRunning;
  set isLoadMoreRunning(bool value) {
    _isLoadMoreRunning = value;
    notifyListeners();
  }

  init() async {
    isLoading = true;
    data = await Hive.openBox(HiveBox.data.name);
    await fetchQuestions();
    scrollController.addListener(_loadMore);
    timer = Timer.periodic(Duration(seconds: 30), (Timer t) {
      newQuestionSzieCalculate();
    });
    await newQuestionSzieCalculate().then((value) async {
      if (value != 0) {
        await getQuestions();
      }
    });
    notifyListeners();
  }

  Future fetchQuestions() async {
    if (data.containsKey(HiveBoxKey.questions.name)) {
      isLoading = false;
    }
    if (await checkInternet()) {
      await getAllQuestions;
    }
    isLoading = false;
  }

  void _loadMore() async {
    if (!_isLoadMoreRunning &&
        scrollController.position.extentAfter < 100 &&
        hasNextPage) {
      isLoadMoreRunning = true;
      await getAllQuestions;
      isLoadMoreRunning = false;
    }
  }

  Future get getAllQuestions async {
    var result = await questionService.questionGetByUniversityId(
      universityId: 1,
      pageIndex: pageIndex,
    );
    hasNextPage = result.hasNextPage;
    var list = data.get(HiveBoxKey.questions.name);
    if (list == null) list = [];
    (list as List).addAll(result.items);
    await data.put(HiveBoxKey.questions.name, list);
    pageIndex++;
  }

  Future newQuestionSzieCalculate() async {
    var questionSize = await questionService.getQuestionSize(universityId: 1);
    newQuestionSize = questionSize - questionService.questions!.length;
    return newQuestionSize;
  }

  onTapNewQuestions() async {
    scrollController
        .animateTo(-20,
            duration: const Duration(milliseconds: 50), curve: Curves.linear)
        .then((value) {
      indicator.currentState!.show();
    });
    onRefresh();
    notifyListeners();
  }

  Future onRefresh() async {
    var res = await getQuestions();
    newQuestionSize = 0;
    notifyListeners();
    return res;
  }

  Future getQuestions() async {
    // newQuestionSize = 0;
    // return await questionService.questionGetByUniversityId(universityId: 1);
  }
}
