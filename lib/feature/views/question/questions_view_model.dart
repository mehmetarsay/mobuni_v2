import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:mobuni_v2/feature/models/questions/question_model.dart';
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

  List<QuestionModel>? questions;

  init() async {
    setInitialised(false);
    newQuestionCalculate();
    await getData();
    setInitialised(true);
    notifyListeners();
  }

  newQuestionCalculate() async {
    ///TODO buraya güncel data sayısı gönderilecek
    newQuestionSize = 3;
  }

  onTapNewQuestions() async {
    newQuestionSize = 0;
    await getData();
    scrollController.animateTo(-50, duration: const Duration(seconds: 1), curve: Curves.linear).then((value) {
      indicator.currentState!.show();
    });
    notifyListeners();
  }

  Future getData() async {
    questions = await questionService.questionGetByUniversityId(universityId: 1);
    notifyListeners();
  }
}
