import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/core/base/viewmodel/base_viewmodel.dart';

class BaseView<T extends CustomBaseViewModel> extends StatefulWidget {
  const BaseView(
      {Key? key,
      required this.builder,
      required this.viewModelBuilder,
      this.onModelReady})
      : super(key: key);

  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Function(T model)? onModelReady;
  final T Function() viewModelBuilder;

  @override
  State<BaseView<T>> createState() => _BaseViewState();
}

class _BaseViewState<T extends CustomBaseViewModel> extends State<BaseView<T>> {
  T? _viewModel;

  @override
  void initState() {
    super.initState();
    _createViewModel();
  }

  void _createViewModel() {
    _viewModel ??= widget.viewModelBuilder();
    if (widget.onModelReady != null) {
      widget.onModelReady!(_viewModel!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => _viewModel!,
      child: Consumer<T>(builder: viewBuilder),
    );
  }

  Widget viewBuilder(BuildContext context, T model, Widget? child) {
    return Stack(
      children: [
        widget.builder(context, model, child),
        // visibleProgress(model),
      ],
    );
  }

  Visibility visibleProgress(model) {
    return Visibility(
        visible: model.isBusy,
        child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey.withOpacity(0.4),
            child: const Center(child: CircularProgressIndicator())));
  }
}
