import 'package:mobuni_v2/feature/services/question/question_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';

class QuestionsViewModel extends BaseViewModel {
  QuestionService questionService = locator<QuestionService>();

}