import 'dart:io';

import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:mobuni_v2/app/app.dart';
import 'package:mobuni_v2/core/constants/enum/activity_or_question_enum.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/models/activity/activity_model.dart';
import 'package:mobuni_v2/feature/models/comment/comment_model.dart';
import 'package:mobuni_v2/feature/models/questions/question_model.dart';
import 'package:mobuni_v2/feature/views/activity/widgets/activity_single_view.dart';
import 'package:mobuni_v2/feature/views/comments/comment_view_model.dart';
import 'package:mobuni_v2/feature/views/comments/widget/comment_write_widget.dart';
import 'package:mobuni_v2/feature/views/question/widgets/question_single/question_single_view.dart';
import 'package:mobuni_v2/feature/views/splash/view/splash_view_model.dart';
import 'package:mobuni_v2/feature/views/comments/widget/comment_widget.dart';
import 'package:stacked/stacked.dart';

class CommentView extends StatelessWidget {
  const CommentView({Key? key, this.questionModel, this.activityModel}) : super(key: key);
  final QuestionModel? questionModel;
  final ActivityModel? activityModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommentViewModel>.reactive(
        viewModelBuilder: () => CommentViewModel(),
        onModelReady: (model) => model.init(context, question: questionModel, activity: activityModel),
        builder: (context, vm, child) {
          return ConditionalWillPopScope(
            onWillPop: () async {
              if (vm.generalType == GeneralType.QuestionType) {
                context.navigationService.back(result: vm.question);
              } else {
                context.navigationService.back(result: vm.activity);
              }
              return false;
            },
            shouldAddCallback: true,
            child: view(vm, context),
          );
        });
  }

  SafeArea view(CommentViewModel vm, BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(),
          body: vm.initialised
              ? CommentBoxRfct(
                  userImage: GeneralManager.user.image == '' ? null : GeneralManager.user.image,
                  labelText: 'Cevap yaz...',
                  withBorder: false,
                  errorText: 'Boş cevap gönderilemez',
                  child: Padding(
                    padding: vm.generalType == GeneralType.QuestionType ? EdgeInsets.all(8.0) : EdgeInsets.zero,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: vm.generalType == GeneralType.QuestionType
                          ? Column(
                              children: [
                                QuestionSingleView(
                                  questionModel: questionModel!,
                                ),
                                Divider(),
                                getCommentWidget(vm),
                              ],
                            )
                          : Column(
                              children: [
                                ActivitySingleView(
                                  activity: vm.activity!,
                                  onTapJoin: (val) {
                                    vm.activity = val;
                                    vm.notifyListeners();
                                  },
                                ),
                                Divider(),
                                getCommentWidget(vm),
                              ],
                            ),
                    ),
                  ),
                  header: Container(),
                  focusNode: vm.focusNode,
                  sendButtonMethod: vm.sendComment,
                  formKey: vm.formKey,
                  commentController: vm.commentController,
                  backgroundColor: context.theme.primaryColorLight,
                  textColor: context.theme.primaryColorDark,
                  sendWidget: vm.commentSend
                      ? Icon(Icons.send_sharp, size: 30, color: context.theme.primaryColorDark)
                      : Container(
                          height: 20,
                          width: 20,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                )
              : Container()),
    );
  }

  FutureBuilder<List<CommentModel>> getCommentWidget(CommentViewModel vm) {
    return FutureBuilder<List<CommentModel>>(
      future: vm.getComment(),
      builder: (context, AsyncSnapshot<List<CommentModel>> comments) {
        if (comments.hasData) {
          if (comments.data!.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    vm.focusNode.requestFocus();
                  },
                  child: Column(
                    children: [Text('İlk cevabı sen yaz...'), Icon(Icons.arrow_circle_down_rounded)],
                  ),
                )
              ],
            );
          }
          return ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 20, top: 15),
            itemCount: comments.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return CommentWidget(
                commentModel: comments.data!.elementAt(index),
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          );
        } else {
          return Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          );
        }
      },
    );
  }
}
