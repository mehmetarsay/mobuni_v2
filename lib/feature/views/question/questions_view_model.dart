import 'dart:async';

import 'package:flutter/material.dart';
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
  dispose(){
    if(timer!=null)
      timer!.cancel();
  }
  init()async{

    timer = Timer.periodic(Duration(seconds: 30), (Timer t) {
      newQuestionSzieCalculate();
    });
    await newQuestionSzieCalculate().then((value)async {
      if(value!=0){
        await getQuestions();
      }
    });
    notifyListeners();
  }
  Future newQuestionSzieCalculate()async{
    var questionSize = await questionService.getQuestionSize(universityId: 1);
    newQuestionSize = questionSize - questionService.questions!.length;
    return newQuestionSize;
  }
  onTapNewQuestions()async{
   scrollController.animateTo(-20,
        duration: const Duration(milliseconds: 50), curve: Curves.linear).then((value) {
      indicator.currentState!.show();
    });
    onRefresh();
    notifyListeners();
  }

 Future onRefresh()async{
   var res = await getQuestions();
   newQuestionSize = 0;
   notifyListeners();
   return res;
  }

  Future getQuestions()async{
    newQuestionSize = 0;
    return await questionService.questionGetByUniversityId(universityId: 1);
  }
}