import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';

class SelectTime extends StatelessWidget {
   SelectTime({Key? key,this.initialValue,this.onChange,this.title,this.selectableDayPredicate}) : super(key: key);
  String? initialValue;
  dynamic onChange;
  dynamic selectableDayPredicate;
  String? title;

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(top: 12),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(title!=null)CustomText(title,style: TextStyle(
              color: context.theme.secondaryHeaderColor,
            fontWeight: FontWeight.w700
          ),),
          SizedBox(height: 5,),
          DateTimePicker(
            type: DateTimePickerType.dateTimeSeparate,
            dateMask: 'd MMM, yyyy',
            initialValue: initialValue,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            decoration:  InputDecoration(
              fillColor: context.theme.primaryColorLight,

              errorStyle: TextStyle(fontSize: 16),
              // fillColor: widget.fillColor ??
              //     (isEmpty
              //         ? context.colors.primary.withAlpha(80)
              //         : context.colors.onSecondary),
              hintText:  'sadasd',
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
              filled: false,
              // contentPadding: EdgeInsets.all(10),
            ),
            initialEntryMode: DatePickerEntryMode.calendar,
            selectableDayPredicate: selectableDayPredicate??(date){
              return true;
            },
            onChanged:onChange,
            validator: (val) {
              print(val);
              return null;
            },
            onSaved: (val) => onChange,
          ),
        ],
      ),
    );
  }
}
