import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/components/button/custom_back_button.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
import 'package:mobuni_v2/core/initialize/theme/theme_notifier.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);
  final String? title;

  @override
  final Size preferredSize;

  @override
  _AuthAppBarState createState() => _AuthAppBarState();
}

class _AuthAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: widget.title != null
          ? CustomText(
              widget.title,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: context.colors.primary,
            )
          : null,
      leading: Navigator.canPop(context) ? Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: CustomBackButton(),
      ) : null,
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: Icon(
            context.watch<ThemeNotifier>().darkTheme!
                ? Icons.light_mode
                : Icons.dark_mode,
          ),
          onPressed: () => context.read<ThemeNotifier>().toggleTheme(),
        )
      ],
    );
  }
}
