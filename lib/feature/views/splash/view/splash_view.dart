import 'package:flutter/material.dart';
import 'package:mobuni_v2/feature/views/splash/view/splash_view_model.dart';
import 'package:stacked/stacked.dart';
import '/core/components/text/custom_text.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      onModelReady: (model)=>model.init(),
      builder: (context, model, child) => Scaffold(
        body: Scaffold(
          body: Center(
            child: Text('Mobuni'),
          ),
        ),
      ),
      viewModelBuilder: () => SplashViewModel(),
    );
  }
}
