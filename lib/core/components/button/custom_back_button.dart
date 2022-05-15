import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';

class CustomBackButton extends StatelessWidget {
const CustomBackButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: () => context.navigationService.back(),
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.primary.withOpacity(0.25),
          borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
        ),
        child: Icon(Icons.arrow_back_ios, color: Color(0xff40668B)),
      ),
    );
  }
}