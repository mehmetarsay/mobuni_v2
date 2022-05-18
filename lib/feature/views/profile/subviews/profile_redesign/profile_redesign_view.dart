import 'package:flutter/material.dart';
import 'package:mobuni_v2/feature/views/splash/view/splash_view_model.dart';
import 'package:stacked/stacked.dart';
import '/core/components/text/custom_text.dart';
import 'profile_redesign_view_model.dart';

class ProfileRedesignView extends StatelessWidget {
  const ProfileRedesignView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileRedesignViewModel>.reactive(
      viewModelBuilder: () => ProfileRedesignViewModel(),
      //onModelReady: (model)=>model.init(),
      builder: (context, model, child) => Scaffold(
        body: Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('Profile Redesign'),
          ),
        ),
      ),

    );
  }
}
