import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, this.onPressed, this.child, this.text})
      : super(key: key);
  final void Function()? onPressed;
  final Widget? child;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton(
        onPressed: onPressed ?? () {},
        child: child ??
            CustomText(
              text ?? 'Buton',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
            ),
        style: ElevatedButton.styleFrom(
          primary: Color(0xff204F83),
          minimumSize: Size(double.maxFinite, 45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
      ),
    );
  }
}
