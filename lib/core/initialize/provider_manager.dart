import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '/core/initialize/theme/theme_notifier.dart';

class ProviderManager {
  static ProviderManager? _instance;

  static ProviderManager? get instance {
    _instance ??= ProviderManager._init();
    return _instance;
  }

  ProviderManager._init();

  List<SingleChildWidget> singleItems = [];
  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(create: (_) => ThemeNotifier()),
  ];
}
