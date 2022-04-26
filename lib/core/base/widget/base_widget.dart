import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class BaseWidget<T> extends Widget {
  final bool reactive;

  const BaseWidget({Key? key, this.reactive = true}) : super(key: key);

  @protected
  Widget build(BuildContext context, T viewModel);

  @override
  _DataProviderElement<T> createElement() => _DataProviderElement<T>(this);
}

class _DataProviderElement<T> extends ComponentElement {
  _DataProviderElement(BaseWidget widget) : super(widget);

  @override
  BaseWidget get widget => super.widget as BaseWidget<dynamic>;

  @override
  Widget build() =>
      widget.build(this, Provider.of<T>(this, listen: widget.reactive));

  @override
  void update(BaseWidget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    rebuild();
  }
}
