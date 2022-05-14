import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({Key? key, this.onPressed, this.child})
      : super(key: key);
  final void Function()? onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () {},
      child: child ?? Text('Text'),
    );
  }
}
