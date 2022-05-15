import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({Key? key, this.onPressed, this.child, this.text})
      : super(key: key);
  final void Function()? onPressed;
  final Widget? child;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () {},
      child: child ??
          CustomText(
            text ?? 'Text',
            fontWeight: FontWeight.bold,
            color: context.theme.primaryColorDark,
          ),
    );
  }
}
