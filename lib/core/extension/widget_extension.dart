import 'package:flutter/material.dart';

import '/core/base/widget/non_reactive_widget.dart';

extension NonReactive on Widget {
  Widget nonReactive<T>() => NonReactiveWidget<T>(this);
}
