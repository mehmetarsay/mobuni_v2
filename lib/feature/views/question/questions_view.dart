import 'package:flutter/material.dart';
import 'package:mobuni_v2/app/app.router.dart';
import 'package:mobuni_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/views/comments/comment_view.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/core/theme/theme_notifier.dart';
import 'package:mobuni_v2/feature/views/question/questions_view_model.dart';
import 'package:mobuni_v2/feature/views/question/widgets/question_single/question_single_view.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class QuestionsView extends StatelessWidget {
  const QuestionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuestionsViewModel>.reactive(
      onModelReady: (vm)=>vm.init(),
      viewModelBuilder: () => QuestionsViewModel(),
      builder: (context, vm, child) => Scaffold(
        body: Scaffold(
          appBar: CustomAppBar(
            actions: [
              Visibility(
                visible: true,
                child: IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () async {
                      GeneralManager.authS.deleteToken;
                      GeneralManager.navigationS
                          .pushNamedAndRemoveUntil(Routes.loginView);
                      await OneSignal.shared.setExternalUserId('');
                    }),
              ),
              IconButton(
                icon: Icon(
                  context.watch<ThemeNotifier>().darkTheme!
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
                onPressed: () => context.read<ThemeNotifier>().toggleTheme(),
              ),
              IconButton(
                  icon: Icon(Icons.message),
                  onPressed: () {
                    GeneralManager.navigationS.navigateTo(Routes.chatHomeView);
                  })
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () async{
              return await context.navigationService.navigateTo(
                Routes.questionAddView,
              )!.then((value) async{
                await vm.getQuestions();
              });
            },
            child: Icon(Icons.add,color: Colors.white,),
          ),
          body: RefreshIndicator(
            key: vm.indicator,
            onRefresh:vm.onRefresh,
            child: Stack(
              children: [
                ListView.separated(
                  key: PageStorageKey<String>('questionController'),
                  controller: vm.scrollController,
                  physics: BouncingScrollPhysics(),
                  itemCount: vm.questionService.questions!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return QuestionSingleView( questionModel: vm.questionService.questions!.elementAt(index),onTap: ()async{
                     return await context.navigationService.navigateToView(
                        CommentView(questionModel: vm.questionService.questions!.elementAt(index)),
                      )!.then((value) async{
                        await vm.getQuestions();
                      });
                    },);
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                ),
                if(vm.newQuestionSize!=0)Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: vm.onTapNewQuestions,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText('${vm.newQuestionSize} yeni soru',color: Colors.white,),
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}