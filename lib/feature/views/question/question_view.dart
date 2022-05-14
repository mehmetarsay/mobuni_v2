import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/initialize/theme/theme_notifier.dart';
import 'package:mobuni_v2/core/model/theme/theme_model.dart';
import 'package:mobuni_v2/feature/views/question/question_view_model.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class QuestionView extends StatelessWidget {
  const QuestionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuestionViewModel>.reactive(
      builder: (context, vm, child) => Scaffold(
        body: Scaffold(
          body: Center(
            child: Text('Sorular'),
          ),
        ),
      ),
      viewModelBuilder: () => QuestionViewModel(),
    );
  }
}
