
import 'package:flutter/material.dart';
import 'package:mobuni_v2/feature/views/home/home_view_model.dart';
import 'package:mobuni_v2/feature/views/tab1/tab1_view.dart';
import 'package:mobuni_v2/feature/views/tab2/tab2_view.dart';
import 'package:mobuni_v2/feature/views/tab3/tab3_view.dart';
import 'package:stacked/stacked.dart';


class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: getViewForIndex(model.currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: model.currentIndex,
          onTap: model.setIndex,
          items: [
            BottomNavigationBarItem(
              label: 'Tab1',
              icon: Icon(Icons.art_track),
            ),
            BottomNavigationBarItem(
              label: 'Tab2',
              icon: Icon(Icons.list),
            ),
            BottomNavigationBarItem(
              label: 'Tab3',
              icon: Icon(Icons.list),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return Tab1View();
      case 1:
        return Tab2View();
      default:
        return Tab3View();
    }
  }

}