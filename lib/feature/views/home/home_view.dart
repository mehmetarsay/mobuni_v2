import 'package:flutter/material.dart';
import 'package:mobuni_v2/feature/views/activity/activity_view.dart';
import 'package:mobuni_v2/feature/views/chat/service/firebase_service.dart';
import 'package:mobuni_v2/feature/views/home/home_view_model.dart';
import 'package:mobuni_v2/feature/views/profile/profile_view.dart';
import 'package:mobuni_v2/feature/views/question/questions_view.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with WidgetsBindingObserver {
  final Map<int, Widget> _viewCache = Map<int, Widget>();
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state.toString());
    if (state == AppLifecycleState.resumed) {
      FirebaseService.instance!.updateUserState(true);
    } else {
      FirebaseService.instance!.updateUserState(false);
    }
  }

  @override
  void initState() {
    super.initState();

    FirebaseService.instance!.updateUserState(true);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
        //appBar: CustomAppBar(title: 'MobUni'),
        body: getViewForIndex(viewModel.currentTabIndex),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 6,
          currentIndex: viewModel.currentTabIndex,
          onTap: viewModel.setTabIndex,
          items: [
            BottomNavigationBarItem(
              label: 'Sorular',
              icon: Icon(Icons.question_answer),
            ),
            BottomNavigationBarItem(
              label: 'Etkinlikler',
              icon: Icon(Icons.event_note),
            ),
            BottomNavigationBarItem(
              label: 'Profil',
              icon: Icon(Icons.account_box),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  Widget getViewForIndex(int index) {
    if (!_viewCache.containsKey(index)) {
      switch (index) {
        case 0:
          _viewCache[index] = QuestionsView();
          break;
        case 1:
          _viewCache[index] = ActivityView();
          break;
        case 2:
          _viewCache[index] = ProfileView();
          break;
      }
    }

    return _viewCache[index]!;
  }
}
