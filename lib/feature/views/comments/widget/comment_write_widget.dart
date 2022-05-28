import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobuni_v2/feature/widgets/user_photo.dart';

// ignore: must_be_immutable
class CommentBoxRfct extends StatelessWidget {
  Widget? child;
  dynamic formKey;
  dynamic sendButtonMethod;
  dynamic commentController;
  String? userImage;
  String? labelText;
  String? errorText;
  Widget? sendWidget;
  Color? backgroundColor;
  Color? textColor;
  bool withBorder;
  Widget? header;
  FocusNode? focusNode;
  CommentBoxRfct(
      {this.child,
        this.header,
        this.sendButtonMethod,
        this.formKey,
        this.commentController,
        this.sendWidget,
        this.userImage,
        this.labelText,
        this.focusNode,
        this.errorText,
        this.withBorder = true,
        this.backgroundColor,
        this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: child!),
        Divider(
          height: 1,
        ),
        header ?? SizedBox.shrink(),
        ListTile(
          tileColor: backgroundColor,
          leading: UserPhoto(url: userImage,currentUser: true,size: 40,),
          title: Form(
            key: formKey,
            child: TextFormField(
              maxLines: 4,
              minLines: 1,
              focusNode: focusNode,
              cursorColor: textColor,
              style: TextStyle(color: textColor),
              controller: commentController,
              decoration: InputDecoration(
                enabledBorder: !withBorder
                    ? InputBorder.none
                    : UnderlineInputBorder(
                  borderSide: BorderSide(color: textColor!),
                ),
                focusedBorder: !withBorder
                    ? InputBorder.none
                    : UnderlineInputBorder(
                  borderSide: BorderSide(color: textColor!),
                ),
                border: !withBorder
                    ? InputBorder.none
                    : UnderlineInputBorder(
                  borderSide: BorderSide(color: textColor!),
                ),
                labelText: labelText,
                focusColor: textColor,
                fillColor: textColor,
                labelStyle: TextStyle(color: textColor,fontSize: 13),
              ),
              validator: (value) => value!.isEmpty ? errorText : null,
            ),
          ),
          trailing: GestureDetector(
            onTap: sendButtonMethod,
            child: sendWidget,
          ),
        ),
      ],
    );
  }
}
