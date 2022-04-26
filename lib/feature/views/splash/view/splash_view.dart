import 'package:flutter/material.dart';
import '/core/components/text/custom_text.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomText('MobUni'),
      ),
    );
  }
}
