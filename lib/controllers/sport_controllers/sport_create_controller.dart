import 'package:android_freelance_7/controllers/app_navigator.dart';
import 'package:android_freelance_7/controllers/sport_controllers/sport_game_controller.dart';
import 'package:android_freelance_7/utils/app_strings.dart';
import 'package:android_freelance_7/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SportCreateController extends GetxController {
  final RxInt _sportType = 0.obs;

  int get sportType => _sportType.value;

  set sportType(int value) => _sportType.value = value;

  final Rx<TextEditingController> name1Controller = TextEditingController().obs;
  final Rx<TextEditingController> name2Controller = TextEditingController().obs;

  final Rx<FocusNode> name1Focus = FocusNode().obs;
  final Rx<FocusNode> name2Focus = FocusNode().obs;

  final RxInt _timeOfMatch = 0.obs;

  int get timeOfMatch => _timeOfMatch.value;

  set timeOfMatch(int value) => _timeOfMatch.value = value;

  final RxInt _timerState = 0.obs;

  int get timerState => _timerState.value;

  set timerState(int value) => _timerState.value = value;

  void getData() async {
    await SharedPreferences.getInstance().then((value) {
      sportType = value.getInt(kSportType) ?? 1;
      timeOfMatch = _getStartingTime(sportType);
      name1Controller.value.text = '';
      name2Controller.value.text = '';
    });
  }

  void setData(int sportType) async {
    await SharedPreferences.getInstance().then((value) {
      value.setInt(kSportType, sportType);
    });
  }

  void saveData(BuildContext context) async {
    await SharedPreferences.getInstance().then((value) {
      value.setBool(kSportScoreBarActive, true);
      value.setString(
          kSportNameTeam1,
          name1Controller.value.text.isEmpty
              ? AppStrings.team1
              : name1Controller.value.text);
      value.setString(
          kSportNameTeam2,
          name2Controller.value.text.isEmpty
              ? AppStrings.team2
              : name2Controller.value.text);
      value.setInt(kSportMainTimerState, 0);
      value.setInt(kSportMainTimerTime, timeOfMatch);
      value.setInt(kSportScoreTeam1, 0);
      value.setInt(kSportScoreTeam2, 0);
      switch (sportType) {
        case 1:
        case 2:
          value.setInt(kSportFoulsTeam1, 0);
          value.setInt(kSportFoulsTeam2, 0);
        case 6:
          value.setInt(kSportGameCountTeam1, 0);
          value.setInt(kSportGameCountTeam2, 0);
          value.setInt(kSportSetsCountTeam1, 0);
          value.setInt(kSportSetsCountTeam2, 0);
        case 7:
          value.setInt(kSportSecondTimerState, 2);
          value.setInt(kSportMainTimerTime, (timeOfMatch / 2).ceil());
          value.setInt(kSportSecondTimerTime, (timeOfMatch / 2).ceil());
      }
      AppNavigator.replaceToSportGameScreen(context);
    });
  }

  void getEditData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int tmpMainTime = prefs.getInt(kSportMainTimerTime) ?? 0;
    int tmpSecondTime = prefs.getInt(kSportSecondTimerTime) ?? 0;
    sportType = prefs.getInt(kSportType) ?? 1;
    timeOfMatch = tmpMainTime + tmpSecondTime;
    timerState = prefs.getInt(kSportMainTimerState) ?? 0;
    name1Controller.value.text =
        prefs.getString(kSportNameTeam1) ?? AppStrings.team1;
    name2Controller.value.text =
        prefs.getString(kSportNameTeam2) ?? AppStrings.team2;
  }

  void saveEditData(BuildContext context) async {
    final SportGameController sportGameController = Get.find();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String tmpName1 = name1Controller.value.text.isNotEmpty
        ? name1Controller.value.text
        : AppStrings.team1;
    String tmpName2 = name2Controller.value.text.isNotEmpty
        ? name2Controller.value.text
        : AppStrings.team2;
    List<Future> responses = [
      prefs.setBool(kSportScoreBarActive, true),
      prefs.setString(kSportNameTeam1, tmpName1),
      prefs.setString(kSportNameTeam2, tmpName2),
      prefs.setInt(kSportMainTimerState, 0),
    ];
    if (sportType == 7) {
      responses
          .add(prefs.setInt(kSportSecondTimerTime, (timeOfMatch / 2).ceil()));
      responses
          .add(prefs.setInt(kSportMainTimerTime, (timeOfMatch / 2).ceil()));
    } else {
      responses.add(prefs.setInt(kSportMainTimerTime, timeOfMatch));
    }
    await Future.wait(responses).whenComplete(
      () {
        sportGameController.getData();
        AppNavigator.goBack(context);
      },
    );
  }

  int _getStartingTime(int sportType) {
    switch (sportType) {
      case 1:
        return 2700;
      case 2:
        return 600;
      case 3:
        return 900;
      case 4:
        return 0;
      case 5:
        return 1200;
      case 6:
        return 0;
      case 7:
        return 2400;
      default:
        return 1800;
    }
  }
}
