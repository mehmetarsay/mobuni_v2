import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobuni_v2/app/app.router.dart';
import 'package:mobuni_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:mobuni_v2/core/components/dropdown/custom_dropdown.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/constants/enum/hive_enum.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/views/comments/comment_view.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/views/question/questions_view_model.dart';
import 'package:mobuni_v2/feature/views/question/widgets/question_single/question_single_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';

class QuestionsView extends StatelessWidget {
  const QuestionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuestionsViewModel>.reactive(
      onModelReady: (vm) => vm.init(),
      viewModelBuilder: () => QuestionsViewModel(),
      builder: (context, vm, child) => vm.initialised
          ? Scaffold(
              appBar: CustomAppBar(
                title: 'Sorular',
                actions: [
                  IconButton(
                      icon: Icon(Icons.message),
                      onPressed: () {
                        GeneralManager.navigationS
                            .navigateTo(Routes.chatHomeView);
                      })
                ],
              ),
              floatingActionButton: FloatingActionButton(
                heroTag: 'question',
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () async {
                  return await context.navigationService
                      .navigateTo(
                    Routes.questionAddView,
                  )!
                      .then((value) async {
                    // await vm.getQuestions();
                  });
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              body: Stack(
                children: [
                  listQuestions(vm, context),
                  if (vm.newQuestionSize != 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: vm.onTapNewQuestions,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomText(
                                  '${vm.newQuestionSize} yeni soru',
                                  color: Colors.white,
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            )
          : Container(),
    );
  }

  Widget listQuestions(QuestionsViewModel viewModel, BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: viewModel.data.listenable(),
      builder: (context, box, childWidget) {
        return box.containsKey(HiveBoxKey.questions.name)
            ? SmartRefresher(
                controller: viewModel.refreshController,
                onRefresh: viewModel.onRefresh,
                onLoading: viewModel.onLoading,
                enablePullDown: true,
                enablePullUp: true,
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus? mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = Text("pull up load");
                    } else if (mode == LoadStatus.loading) {
                      body = CupertinoActivityIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = Text("Load Failed!Click retry!");
                    } else if (mode == LoadStatus.canLoading) {
                      body = Text("release to load more");
                    } else {
                      body = Text("No more Data");
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (!GeneralManager.user.isUniversityStudent!)
                        CustomDropdown(
                          initId: viewModel.universityId,
                          labelText: 'University',
                          items: viewModel.universityList,
                          isLoading: viewModel.isLoading,
                          voidCallback: (value) {
                            viewModel.universityId = value as int;
                            viewModel.refreshController.requestRefresh();
                          },
                        ),
                      SizedBox(height: 10),
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(left: 12, right: 12),
                        itemCount: box.get(HiveBoxKey.questions.name).length,
                        itemBuilder: (context, index) {
                          return QuestionSingleView(
                            questionModel:
                                box.get(HiveBoxKey.questions.name)[index],
                            onTap: () async {
                              return await context.navigationService
                                  .navigateToView(
                                CommentView(
                                  questionModel:
                                      box.get(HiveBoxKey.questions.name)[index],
                                ),
                              )!
                                  .then((value) async {
                                // await viewModel.getQuestions();
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            : SizedBox();
      },
    );
  }
}
