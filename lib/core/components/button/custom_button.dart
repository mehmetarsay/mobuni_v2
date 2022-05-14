import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, this.onPressed, this.child, this.text}) : super(key: key);
  final void Function()? onPressed;
  final Widget? child;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ?? () {},
      child: child ??
          CustomText(
            text ?? 'Buton',
            color: Colors.white,
          ),
    );
  }
}
