import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/constants/app/constants.dart';

class CustomTitle extends StatelessWidget {
  final String? title;
  final double? size;

  const CustomTitle({
    Key? key,
    this.title,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomText(
      title ?? 'Title',
      color: Color(0xff204F83),
      fontSize: size ?? 24,
      fontWeight: FontWeight.bold,
      shadows: Constants.titleShadows,
    );
  }
}