import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/components/button/custom_back_button.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _AuthAppBarState createState() => _AuthAppBarState();
}

class _AuthAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: Navigator.canPop(context) ?  CustomBackButton() : null,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: []);
  }
}
