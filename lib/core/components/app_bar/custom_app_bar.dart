import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/components/button/custom_back_button.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.actions = const [],
    this.titleWidget,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);
  final String? title;
  final Widget? titleWidget;
  final List<Widget> actions;

  @override
  final Size preferredSize;

  @override
  _AuthAppBarState createState() => _AuthAppBarState();
}

class _AuthAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: widget.titleWidget != null
          ? widget.titleWidget
          : widget.title != null
              ? CustomText(
                  widget.title,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: context.colors.primary,
                )
              : null,
      leading: Navigator.canPop(context)
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomBackButton(),
            )
          : null,
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: [...widget.actions],
    );
  }
}
