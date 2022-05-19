import 'package:flutter/material.dart';
import 'package:mobuni_v2/core/manager/general_manager.dart';
import 'package:mobuni_v2/feature/views/home/bottomnav_view_model.dart';
import 'package:mobuni_v2/feature/views/profile/profile_tab_view.dart';
import 'package:mobuni_v2/feature/views/question/questions_view.dart';
import 'package:mobuni_v2/feature/views/tab2/tab2_view.dart';
import 'package:stacked/stacked.dart';

class BottomNavView extends StatefulWidget {
  const BottomNavView({Key? key}) : super(key: key);

  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  final Map<int, Widget> _viewCache = Map<int, Widget>();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BottomNavViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
        //appBar: CustomAppBar(title: 'MobUni'),
        body: getViewForIndex(viewModel.currentTabIndex),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 6,
          currentIndex: viewModel.currentTabIndex,
          onTap: viewModel.setTabIndex,
          items: [
            BottomNavigationBarItem(
              label: 'Tab1',
              icon: Icon(Icons.ac_unit),
            ),
            BottomNavigationBarItem(
              label: 'Tab2',
              icon: Icon(Icons.access_alarm),
            ),
            BottomNavigationBarItem(
              label: 'Tab3',
              icon: Icon(Icons.access_alarms),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => BottomNavViewModel(),
    );
  }

  Widget getViewForIndex(int index) {
    if (!_viewCache.containsKey(index)) {
      switch (index) {
        case 0:
          _viewCache[index] = QuestionsView();
          break;
        case 1:
          _viewCache[index] = Tab2View();
          break;
        case 2:
          _viewCache[index] = ProfileTabView();
          break;
      }
    }

    return _viewCache[index]!;
  }
}
