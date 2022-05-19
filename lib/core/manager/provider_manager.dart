import 'package:mobuni_v2/core/theme/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:stacked/stacked_annotations.dart';

@LazySingleton()
class ProviderManager {
  List<SingleChildWidget> singleItems = [];
  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(create: (_) => ThemeNotifier()),
  ];
}
