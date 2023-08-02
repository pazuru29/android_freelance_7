import 'dart:async';

import 'package:android_freelance_7/controllers/app_navigator.dart';
import 'package:android_freelance_7/utils/app_strings.dart';
import 'package:android_freelance_7/utils/constants.dart';
import 'package:android_freelance_7/utils/extansions/app_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SimpleScoreBarController extends GetxController {
  BuildContext? currentContext;

  final RxInt _numberOfPlayers = 0.obs;

  RxString nameTeam1 = AppStrings.team1.obs;
  RxString nameTeam2 = AppStrings.team2.obs;
  RxString nameTeam3 = AppStrings.team3.obs;
  RxString nameTeam4 = AppStrings.team4.obs;

  final RxInt _scoreTeam1 = 0.obs;

  int get scoreTeam1 => _scoreTeam1.value;

  set scoreTeam1(int value) => _scoreTeam1.value = value;

  final RxInt _scoreTeam2 = 0.obs;

  int get scoreTeam2 => _scoreTeam2.value;

  set scoreTeam2(int value) => _scoreTeam2.value = value;

  final RxInt _scoreTeam3 = 0.obs;

  int get scoreTeam3 => _scoreTeam3.value;

  set scoreTeam3(int value) => _scoreTeam3.value = value;

  final RxInt _scoreTeam4 = 0.obs;

  int get scoreTeam4 => _scoreTeam4.value;

  set scoreTeam4(int value) => _scoreTeam4.value = value;

  int get numberOfPlayers => _numberOfPlayers.value;

  set numberOfPlayers(int value) => _numberOfPlayers.value = value;

  final RxInt _timeOfMatch = 0.obs;

  int get timeOfMatch => _timeOfMatch.value;

  set timeOfMatch(int value) => _timeOfMatch.value = value;

  void getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //Get init settings
    numberOfPlayers = prefs.getInt(kSimpleScoreBarNumberOfPlayers) ?? 2;
    timeOfMatch = prefs.getInt(kSimpleScoreBarTime) ?? 0;
    timerState = prefs.getInt(kSimpleScoreBarTimerState) ?? 0;
    //Get name of team
    nameTeam1.value =
        prefs.getString(kSimpleScoreBarNameTeam1) ?? AppStrings.team1;
    nameTeam2.value =
        prefs.getString(kSimpleScoreBarNameTeam2) ?? AppStrings.team2;
    nameTeam3.value =
        prefs.getString(kSimpleScoreBarNameTeam3) ?? AppStrings.team3;
    nameTeam4.value =
        prefs.getString(kSimpleScoreBarNameTeam4) ?? AppStrings.team4;
    //Get score of team
    scoreTeam1 = prefs.getInt(kSimpleScoreBarScoreTeam1) ?? 0;
    scoreTeam2 = prefs.getInt(kSimpleScoreBarScoreTeam2) ?? 0;
    scoreTeam3 = prefs.getInt(kSimpleScoreBarScoreTeam3) ?? 0;
    scoreTeam4 = prefs.getInt(kSimpleScoreBarScoreTeam4) ?? 0;
  }

  // Timer interval of timer
  final _interval = const Duration(milliseconds: 25);

  // Timer time
  final RxDouble _currentTime = 0.0.obs;

  double get currentTime => _currentTime.value;

  set currentTime(double currentTime) => _currentTime.value = currentTime;

  // Timer
  Timer? _timer;

  final RxInt _timerState = 0.obs;

  int get timerState => _timerState.value;

  set timerState(int value) => _timerState.value = value;

  //Start timer
  void startTimer() async {
    await SharedPreferences.getInstance().then((value) {
      value.setInt(kSimpleScoreBarTimerState, 1);
    });
    debugPrint('TIMER STARTED');
    _timerState.value = 1;
    _timer = Timer.periodic(_interval, (timer) {
      _currentTime.value += 0.025;
      debugPrint('${_currentTime.value}');
      if (_currentTime.value >= timeOfMatch) {
        finishTimer();
      }
    });
  }

  void incrementScore(int numberOfTeam) async {
    await SharedPreferences.getInstance().then((value) {
      switch (numberOfTeam) {
        case 1:
          scoreTeam1++;
          value.setInt(kSimpleScoreBarScoreTeam1, scoreTeam1);
        case 2:
          scoreTeam2++;
          value.setInt(kSimpleScoreBarScoreTeam2, scoreTeam2);
        case 3:
          scoreTeam3++;
          value.setInt(kSimpleScoreBarScoreTeam3, scoreTeam3);
        default:
          scoreTeam4++;
          value.setInt(kSimpleScoreBarScoreTeam4, scoreTeam4);
      }
    });
  }

  void decrementScore(int numberOfTeam) async {
    await SharedPreferences.getInstance().then((value) {
      switch (numberOfTeam) {
        case 1:
          scoreTeam1--;
          value.setInt(kSimpleScoreBarScoreTeam1, scoreTeam1);
        case 2:
          scoreTeam2--;
          value.setInt(kSimpleScoreBarScoreTeam2, scoreTeam2);
        case 3:
          scoreTeam3--;
          value.setInt(kSimpleScoreBarScoreTeam3, scoreTeam3);
        default:
          scoreTeam4--;
          value.setInt(kSimpleScoreBarScoreTeam4, scoreTeam4);
      }
    });
  }

  // Pause timer without save in db
  void pauseTimer() async {
    await SharedPreferences.getInstance().then((value) {
      value.setInt(kSimpleScoreBarTimerState, 2);
    });
    debugPrint('TIMER PAUSED');
    _timerState.value = 2;
    _timer?.cancel();
  }

  //Finish timer
  void finishTimer() async {
    await SharedPreferences.getInstance().then((value) {
      value.setInt(kSimpleScoreBarTimerState, 3);
      currentTime = 0;
      _timerState.value = 3;
      _timer?.cancel();
      if (currentContext != null) {
        AppNavigator.replaceToFinishedSimpleScoreBarScreen(currentContext!);
      }
    });
  }

  void deleteSaveData(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Future> responses = [
      prefs.setBool(kSimpleScoreBarActive, false),
      prefs.remove(kSimpleScoreBarNumberOfPlayers),
      prefs.remove(kSimpleScoreBarTime),
      prefs.remove(kSimpleScoreBarTimerState),
      prefs.remove(kSimpleScoreBarNameTeam1),
      prefs.remove(kSimpleScoreBarNameTeam2),
      prefs.remove(kSimpleScoreBarNameTeam3),
      prefs.remove(kSimpleScoreBarNameTeam4),
      prefs.remove(kSimpleScoreBarScoreTeam1),
      prefs.remove(kSimpleScoreBarScoreTeam2),
      prefs.remove(kSimpleScoreBarScoreTeam3),
      prefs.remove(kSimpleScoreBarScoreTeam4),
    ];
    await Future.wait(responses).whenComplete(
      () {
        AppNavigator.goBack(context);
      },
    );
  }

  void saveDataWhenOutFromApp() async {
    _timer?.cancel();
    await SharedPreferences.getInstance().then((value) {
      //Save data when user out from app
      value.setDouble(kSimpleScoreBarRemainingTime, currentTime);
      value.setString(
          kSimpleScoreBarDateTime, AppDate.dataBaseFormatter(DateTime.now()));
    });
  }

  void checkAfterOut() async {
    await SharedPreferences.getInstance().then((value) {
      //Get save data
      double? remainingTime = value.getDouble(kSimpleScoreBarRemainingTime);
      String? dateString = value.getString(kSimpleScoreBarDateTime);
      //Check on work timer
      if (timerState == 1 && dateString != null && remainingTime != null) {
        startTimer();
        currentTime = remainingTime +
            (DateTime.now()
                    .difference(AppDate.fromDataBaseFormatter(dateString))
                    .inMilliseconds /
                1000);
        //Delete data
        value.remove(kSimpleScoreBarRemainingTime);
        value.remove(kSimpleScoreBarDateTime);
      } else {
        currentTime = remainingTime ?? 0;
      }
    });
  }

  @override
  void onInit() {
    checkAfterOut();
    super.onInit();
  }
}
