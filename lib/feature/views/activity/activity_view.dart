import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobuni_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/constants/enum/hive_enum.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/views/activity/activity_add/activity_add_view.dart';
import 'package:mobuni_v2/feature/views/activity/activity_view_model.dart';
import 'package:mobuni_v2/feature/views/activity/widgets/activity_single_view.dart';
import 'package:mobuni_v2/feature/views/comments/comment_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';

class ActivityView extends StatelessWidget {
  const ActivityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ActivityViewModel>.reactive(
      onModelReady: (vm) => vm.init(),
      viewModelBuilder: () => ActivityViewModel(),
      builder: builder,
    );
  }

  Widget builder(BuildContext context, ActivityViewModel vm, Widget? child) {
    return vm.initialised ?Scaffold(
      appBar: CustomAppBar(title: 'Etkinlikler',actions: [
        IconButton(onPressed: (){
          vm.filterBottomSheet(context).then((value) {
            vm.refreshController.requestRefresh();
          });
        }, icon: Icon(Icons.filter_list_sharp)),
      ],),
      floatingActionButton: GeneralManager.user.isUniversityStudent!?FloatingActionButton(
        heroTag: 'activity',
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          return await context.navigationService
              .navigateToView(
            ActivityAddView(),
          )!
              .then((value) async {
            if (value != null) vm.addActivity(value);
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ):Container(),
      body: Stack(
        children: [
          listActivities(vm),
          if (vm.newActivitySize != 0)
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: vm.onTapNewActivity,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          '${vm.newActivitySize} yeni etkinlik',
                          color: Colors.white,
                        ),
                      ),
                      decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                  ),
                ],
              ),
            ),
        ],
      )
    ):Container();
  }

  Widget listActivities(ActivityViewModel viewModel) {
    return ValueListenableBuilder<Box>(
      valueListenable: viewModel.data.listenable(),
      builder: (context, box, childWidget) {
        return SmartRefresher(
          controller: viewModel.refreshController,
          onRefresh: viewModel.onRefresh,
          onLoading: viewModel.onLoading,
          enablePullDown: true,
          enablePullUp: true,
          footer: CustomFooter(
            builder: (BuildContext context,LoadStatus? mode){
              Widget body ;
              if(mode==LoadStatus.idle){
                body =  Text("");
              }
              else if(mode==LoadStatus.loading){
                body =  CupertinoActivityIndicator();
              }
              else if(mode == LoadStatus.failed){
                body = Text("");
              }
              else if(mode == LoadStatus.canLoading){
                body = Text("");
              }
              else{
                body = Text("");
              }
              return Container(
                height: 55.0,
                child: Center(child:body),
              );
            },
          ),
              child: ListView.builder(
                  // controller: viewModel.scrollController,
                  primary: false,
                  shrinkWrap: true,
                  itemCount: box.get(HiveBoxKey.activities.name).length,
                  itemBuilder: (context, index) {
                    return ActivitySingleView(
                      activity: box.get(HiveBoxKey.activities.name)[index],
                      onTapJoin: (val){
                        List list = box.get(HiveBoxKey.activities.name);
                        list[index] = val;
                        viewModel.data.put(HiveBoxKey.activities.name, list);
                        viewModel.notifyListeners();
                      },
                      onTap: (){
                        context.navigationService.navigateToView(
                          CommentView(activityModel: box.get(HiveBoxKey.activities.name)[index]),
                        )!.then((value) async{
                          List list = box.get(HiveBoxKey.activities.name);
                          list[index] = value;
                          viewModel.data.put(HiveBoxKey.activities.name, list);
                          viewModel.notifyListeners();
                        });
                      },
                    );
                  },
                ),
            );
      },
    );
  }

}
