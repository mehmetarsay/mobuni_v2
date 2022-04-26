import 'package:flutter/material.dart';

import '/core/base/widget/base_widget.dart';

class NonReactiveWidget<T> extends BaseWidget<T> {
  final Widget child;
  const NonReactiveWidget(this.child, {Key? key})
      : super(key: key, reactive: false);
  @override
  Widget build(BuildContext context, T viewModel) {
    return child;
  }
}