import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/feature/views/activity/activity_add/activity_add_view.dart';
import 'package:mobuni_v2/feature/views/activity/activity_view_model.dart';
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
    return Scaffold(
      appBar: CustomAppBar(title: 'Etkinlikler'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async{
          return await context.navigationService.navigateToView(
            ActivityAddView()
          )!.then((value) async{
          });
        },
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
