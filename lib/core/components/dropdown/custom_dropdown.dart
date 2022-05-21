import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    Key? key,
    required this.labelText,
    required this.items,
    this.isLoading = true,
    this.voidCallback,
    this.initId
  }) : super(key: key);

  final String labelText;
  final List items;
  final isLoading;
  final Function(Object? value)? voidCallback;
  final int ? initId;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  var index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: context.theme.primaryColorLight,
          border: Border.all(color: context.theme.secondaryHeaderColor),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: widget.isLoading
            ? Center(child: CircularProgressIndicator())
            : DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  isDense: true,
                  value: index ?? widget.initId,
                  hint: CustomText(
                    widget.labelText.toUpperCase(),
                    color: context.colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  items: widget.items.map(
                    (item) {
                      return DropdownMenuItem<int>(
                        child: CustomText(
                          item.dropdownText,
                          fontWeight: FontWeight.bold,
                        ),
                        value: item.dropdownValue,
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    print(val);
                    if (widget.voidCallback != null) {
                      widget.voidCallback!.call(val);
                    }
                    setState(() {
                      index = val;
                    });
                  },
                  icon: Icon(Icons.keyboard_arrow_up_sharp, size: 26),
                ),
              ),
      ),
    );
  }
}
