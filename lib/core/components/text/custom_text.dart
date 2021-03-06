import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class CustomText extends StatefulWidget {
  final String? data;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final bool lineThrough;
  final List<Shadow>? shadows;
  final TextStyle? style;

  const CustomText(
    this.data, {
    Key? key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.textOverflow = TextOverflow.visible,
    this.lineThrough = false,
    this.shadows,
        this.style
  }) : super(key: key);

  @override
  _CustomTextState createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.data ?? '',
      textAlign: widget.textAlign ?? TextAlign.start,
      style:widget.style==null? TextStyle(
          fontSize: widget.fontSize ?? 12,
          fontWeight: widget.fontWeight ?? FontWeight.normal,
          color: widget.color,
          // color: widget.color ?? context.colors.primary,
          decoration: widget.lineThrough
              ? TextDecoration.lineThrough
              : TextDecoration.none,
          decorationThickness: 2,
          shadows: widget.shadows):widget.style,
      overflow: widget.textOverflow,
    );
  }
}
