import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/models/questions/question_model.dart';
import 'package:mobuni_v2/feature/views/question/subviews/question_comments/question_comments_view_model.dart';
import 'package:mobuni_v2/feature/views/question/widgets/question_single/question_single_view.dart';
import 'package:mobuni_v2/feature/views/splash/view/splash_view_model.dart';
import 'package:mobuni_v2/feature/widgets/comment/comment_widget.dart';
import 'package:stacked/stacked.dart';
import '/core/components/text/custom_text.dart';

class QuestionCommentsView extends StatelessWidget {
  const QuestionCommentsView({Key? key, required this.questionModel}) : super(key: key);
  final QuestionModel questionModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuestionCommentsViewModel>.reactive(
       onModelReady: (model)=>model.init(),
      builder: (context, vm, child) => Scaffold(
        body: SafeArea(
          child: Scaffold(
              body: CommentBox(
                userImage: "https://pbs.twimg.com/profile_images/1486436054169268238/-jsp8MLq_400x400.jpg",
                labelText: 'Cevap yaz...',
                withBorder: false,
                errorText: 'Boş cevap gönderilemez',
                child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
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
                      Divider(),
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(left: 20,top: 15),
                          itemCount: vm.comments.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CommentWidget( commentModel: vm.comments.elementAt(index),);
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider(),
                        ),
                      ),
                    ],
                  ),
                ),
                header: Container(),
                focusNode: vm.focusNode,
                sendButtonMethod: () {
                  if (vm.formKey.currentState!.validate()) {
                    vm.commentController.clear();
                  } else {
                    print("Not validated");
                  }
                },
                formKey: vm.formKey,
                commentController: vm.commentController,
                backgroundColor: context.theme.primaryColorLight,
                textColor: context.theme.primaryColorDark,
                sendWidget: Icon(Icons.send_sharp, size: 30, color: context.theme.primaryColorDark),
              )),
        ),
      ),
      viewModelBuilder: () => QuestionCommentsViewModel(),
    );
  }
}
