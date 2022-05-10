import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/initialize/theme/theme_notifier.dart';
import 'package:mobuni_v2/core/model/theme/theme_model.dart';
import 'package:provider/provider.dart';

class Tab1View extends StatelessWidget {
  const Tab1View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.read<ThemeNotifier>().toggleTheme();
      },
      child: Container(color: Theme.of(context).accentColor),
    );
  }
}
