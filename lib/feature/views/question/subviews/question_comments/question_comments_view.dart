
import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/models/questions/question_model.dart';
import 'package:mobuni_v2/feature/views/question/subviews/question_comments/question_comments_view_model.dart';
import 'package:mobuni_v2/feature/views/question/widgets/question_single/question_single_view.dart';
import 'package:mobuni_v2/feature/views/splash/view/splash_view_model.dart';
import 'package:stacked/stacked.dart';
import '/core/components/text/custom_text.dart';

class QuestionCommentsView extends StatelessWidget {
  const QuestionCommentsView({Key? key, required this.questionModel}) : super(key: key);
  final QuestionModel questionModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuestionCommentsViewModel>.reactive(
      // onModelReady: (model)=>model.init(),
      builder: (context, vm, child) => Scaffold(
        body: SafeArea(
          child: Scaffold(
              body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              context.navigationService.back();
                            },
                            icon: Icon(Icons.arrow_back_ios)),
                      ],
                    ),
                    QuestionSingleView(
                      questionModel: questionModel,
                    ),
                    Divider()
                  ],
                ),
            // CommentBox(
            //   userImage:
            //   "https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400",
            //   labelText: 'Write a comment...',
            //   withBorder: false,
            //   errorText: 'Comment cannot be blank',
            //   sendButtonMethod: () {
            //     if (vm.formKey.currentState!.validate()) {
            //       vm.commentController.clear();
            //       FocusScope.of(context).unfocus();
            //     } else {
            //       print("Not validated");
            //     }
            //   },
            //   formKey: vm.formKey,
            //   commentController: vm.commentController,
            //   backgroundColor: Colors.black,
            //   textColor: Colors.white,
            //   sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
            // ),
              ],
            ),
          )),
        ),
      ),
      viewModelBuilder: () => QuestionCommentsViewModel(),
    );
  }
}
