import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/components/text/custom_text.dart';
import 'package:mobuni_v2/core/extension/context_extension.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    Key? key,
    required this.labelText,
    required this.items,
  }) : super(key: key);
  final String labelText;
  final List items;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: context.theme.primaryColorLight,
          border: Border.all(color: context.theme.secondaryHeaderColor),
          borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                )
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            isDense: true,
            // value: viewModel.selectedIndex ?? null,
            hint: CustomText(
              labelText.toUpperCase(),
              color: context.colors.primary,
              fontWeight: FontWeight.bold,
            ),
            items: items.map(
              (item) {
                return DropdownMenuItem<int>(
                  child: CustomText(item),
                  value: 0,
                );
              },
            ).toList(),
            onChanged: (val) {
              // viewModel.selectOrder(int.parse(val.toString()));
              // viewModel.sortPortfolios();
            },
            icon: Icon(
              Icons.keyboard_arrow_up_sharp,
              size: 26,
            ),
          ),
        ),
      ),
    );
  }
}
