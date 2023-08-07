import 'package:android_freelance_7/controllers/simple_score_bar_controller.dart';
import 'package:android_freelance_7/controllers/sport_controllers/sport_game_controller.dart';
import 'package:android_freelance_7/controllers/workouts_controller.dart';
import 'package:android_freelance_7/data/database/database_helper.dart';
import 'package:android_freelance_7/data/database/models/history_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryController extends GetxController {
  final RxList<HistoryModel> _listOfHistory = <HistoryModel>[].obs;

  List<HistoryModel> get listOfHistory => _listOfHistory;

  void getData() async {
    _listOfHistory.value = await DatabaseHelper.instance.getHistory();
  }

  void deleteData() async {
    final SportGameController sportGameController = Get.find();
    final SimpleScoreBarController simpleScoreBarController = Get.find();
    final WorkoutsController workoutsController = Get.find();
    sportGameController.pauseTimer();
    simpleScoreBarController.pauseTimer();
    workoutsController.pauseTimer();
    await SharedPreferences.getInstance().then((value) {
      List<Future> requests = [
        DatabaseHelper.instance.deleteHistory(),
        value.clear(),
      ];
      Future.wait(requests);
    });
  }
}
