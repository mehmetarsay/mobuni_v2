import 'package:flutter/material.dart';
import 'package:mobuni_v2/app/app.router.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/feature/views/question/questions_view_model.dart';
import 'package:mobuni_v2/feature/views/question/widgets/question_single/question_single_view.dart';
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
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              NavigationService().navigateTo(Routes.questionAddView);
            },
            child: Icon(Icons.add,color: Colors.white,),
          ),
          body: RefreshIndicator(
            key: vm.indicator,
            onRefresh: () async{
              return Future.delayed(Duration(seconds: 2));
            },
            child: Stack(
              children: [
                ListView.separated(
                  key: PageStorageKey<String>('questionController'),
                  controller: vm.questionService.scrollController,
                  padding: const EdgeInsets.all(8),
                  itemCount: vm.questionService.questions!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return QuestionSingleView( questionModel: vm.questionService.questions!.elementAt(index),onTapNavigate: true,);
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