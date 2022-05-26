import 'package:mobuni_v2/app/app.locator.dart';
import 'package:mobuni_v2/feature/models/activity/activity_model.dart';
import 'package:mobuni_v2/feature/views/activity/service/activity_service.dart';
import 'package:stacked/stacked.dart';

class ActivityViewModel extends BaseViewModel {
  ActivityService activityService = locator<ActivityService>();
  List<ActivityModel>? activities = [];
  init() {
    getActivities();
  }

  Future getActivities() async {
    setBusy(true);
    setInitialised(false);
    activities = await activityService.activityGetAll();
    setBusy(false);
    
  }
  void addActivity(ActivityModel activity){
    activities!.insert(0, activity);
    notifyListeners();
  }
}
