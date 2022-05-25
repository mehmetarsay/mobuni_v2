
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '/core/components/text/custom_text.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final IconData? iconData;
  final TextInputType? textInputType;
  final bool? isPassword;
  final TextEditingController? controller;
  final void Function()? onTap;
  final bool? readOnly;
  final Color? fillColor;
  final bool? insideHint;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final bool? isNumber;
  final int maxLines;
  final String? title;

  const CustomTextFormField({
    BuildContext? context,
    Key? key,
    this.hintText,
    this.iconData,
    this.textInputType,
    this.isPassword = false,
    @required this.controller,
    this.onTap,
    this.readOnly = false,
    this.fillColor,
    this.insideHint = true,
    this.focusNode,
    this.validator,
    this.isNumber = false,
    this.maxLines =1,
    this.title
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool passwordVisible;
  late FocusNode focus;
  bool isEmpty = true;

  @override
  void initState() {
    super.initState();
    passwordVisible = widget.isPassword! ? true : false;
    focus = widget.focusNode ?? FocusNode();
    if (widget.controller!.text.isNotEmpty) {
      isEmpty = false;
    }
    // KeyboardVisibilityController().onChange.listen((event) {
    // print(event);
    //   if (!event) {
    //     focus.unfocus();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(widget.title!=null)CustomText(widget.title,style: TextStyle(
              color: context.theme.secondaryHeaderColor,
              fontWeight: FontWeight.w700
          ),),
          SizedBox(height: 5,),
          TextFormField(
            autofocus: false,
            obscureText: passwordVisible,
            readOnly: widget.readOnly!,
            onChanged: (value) {
              setState(() {
                isEmpty = value.isEmpty;
              });
            },
            decoration: InputDecoration(
              fillColor: context.theme.primaryColorLight,

              errorStyle: TextStyle(fontSize: 16),
              // fillColor: widget.fillColor ??
              //     (isEmpty
              //         ? context.colors.primary.withAlpha(80)
              //         : context.colors.onSecondary),
              hintText: widget.insideHint! ? widget.hintText ?? '' : '',
              hintStyle: TextStyle(color: context.theme.secondaryHeaderColor),
              border: OutlineInputBorder(
                borderSide: BorderSide(),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                // borderSide: BorderSide(color: context.theme.primaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                borderSide: BorderSide(
                    color: context.theme.secondaryHeaderColor,
                    ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                // borderSide: BorderSide(color: context.theme.primaryColor, width: 3),
              ),
              filled: true,
              //fillColor: context.colors.background,
              // prefixIcon: Icon(
              //   widget.iconData ?? MdiIcons.nullIcon,
              //   size: 26,
              // ),
              suffixIcon: widget.isPassword!
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                      child: Icon(
                        passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility
                      ),
                    )
                  : null,
              isDense: true,
              // contentPadding: EdgeInsets.all(10),
            ),
            keyboardType: widget.textInputType ?? TextInputType.text,
            controller: widget.controller,
            // onEditingComplete: () => FocusScope.of(context).nextFocus(),
            textInputAction: TextInputAction.next,
            focusNode: focus,
            onTap: widget.onTap,
            maxLines: widget.maxLines,
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            //textCapitalization: TextCapitalization.sentences,
          ),
        ],
      ),
    );
  }
}
