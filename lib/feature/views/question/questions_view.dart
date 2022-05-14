import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/initialize/theme/theme_notifier.dart';
import 'package:mobuni_v2/core/model/theme/theme_model.dart';
import 'package:mobuni_v2/feature/views/question/questions_view_model.dart';
import 'package:mobuni_v2/feature/views/question/widgets/question_single/question_single_view.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class QuestionsView extends StatelessWidget {
  const QuestionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuestionsViewModel>.reactive(
      builder: (context, vm, child) => Scaffold(
        body: Scaffold(
          body: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: vm.questionService.questions!.length,
            itemBuilder: (BuildContext context, int index) {
              return QuestionSingleView( questionModel: vm.questionService.questions!.elementAt(index),);
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          ),
        ),
      ),
      viewModelBuilder: () => QuestionsViewModel(),
    );
  }
}
