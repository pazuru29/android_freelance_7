import 'dart:async';

import 'package:android_freelance_7/controllers/app_navigator.dart';
import 'package:android_freelance_7/utils/constants.dart';
import 'package:android_freelance_7/utils/extansions/app_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkoutsController extends GetxController {
  BuildContext? currentContext;

  final RxInt _countOfTimers = 0.obs;

  int get countOfTimers => _countOfTimers.value;

  set countOfTimers(int value) => _countOfTimers.value = value;

  final RxInt _currentTimer = 0.obs;

  int get currentTimer => _currentTimer.value;

  set currentTimer(int value) => _currentTimer.value = value;

  final RxList<int> listOfTime = <int>[].obs;

  void addExercise() {
    listOfTime.add(10);
    countOfTimers = listOfTime.length;
  }

  void removeExercise(int index) {
    listOfTime.removeAt(index);
    countOfTimers = listOfTime.length;
  }

  void changeTime(int time, index) {
    listOfTime.removeAt(index);
    listOfTime.insert(index, time);
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  final RxInt _currentTimeOfExercise = 0.obs;

  int get currentTimeOfExercise => _currentTimeOfExercise.value;

  set currentTimeOfExercise(int value) => _currentTimeOfExercise.value = value;

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
      //TODO
      value.setInt(kWorkoutTimerState, 1);
    });
    debugPrint('TIMER STARTED');
    _timerState.value = 1;
    _timer = Timer.periodic(_interval, (timer) async {
      currentTime += 0.025;
      debugPrint('$currentTime');
      if (currentTime >= currentTimeOfExercise &&
          currentTimer == listOfTime.length) {
        finishTimer();
      } else if (currentTime >= currentTimeOfExercise) {
        await SharedPreferences.getInstance().then((value) {
          timer.cancel();
          currentTimeOfExercise = listOfTime[currentTimer];
          timerState = 2;
          currentTimer++;
          currentTime = 0;
          value.setInt(kWorkoutCurrentTimer, currentTimer);
          value.setInt(kWorkoutTimerState, 2);
        });
      }
    });
  }

  // Pause timer without save in db
  void pauseTimer() async {
    await SharedPreferences.getInstance().then((value) {
      value.setInt(kWorkoutTimerState, 2);
    });
    debugPrint('TIMER PAUSED');
    _timerState.value = 2;
    _timer?.cancel();
  }

  //Finish timer
  void finishTimer() async {
    await SharedPreferences.getInstance().then((value) {
      value.setInt(kWorkoutTimerState, 3);
      currentTime = 0;
      _timerState.value = 3;
      _timer?.cancel();
      if (currentContext != null) {
        AppNavigator.replaceToFinishedWorkoutScreen(currentContext!);
      }
    });
  }

  void saveData() async {
    await SharedPreferences.getInstance().then((value) {
      List<String> listForSave = [];
      for (final element in listOfTime) {
        listForSave.add(element.toString());
      }
      value.setStringList(kWorkoutListOfTime, listForSave);
      value.setInt(kWorkoutTimerState, 0);
      value.setInt(kWorkoutCurrentTimer, 1);
    });
  }

  final RxInt _allTime = 0.obs;

  int get allTime => _allTime.value;

  set allTime(int value) => _allTime.value = value;

  void getData() async {
    await SharedPreferences.getInstance().then((value) {
      List<String>? list = value.getStringList(kWorkoutListOfTime);
      if (list != null) {
        listOfTime.value = [];
        allTime = 0;
        for (final element in list) {
          listOfTime.add(int.parse(element));
        }
        countOfTimers = listOfTime.length;
        for (final item in listOfTime) {
          allTime += item;
        }
      } else {
        listOfTime.value = [10];
        countOfTimers = listOfTime.length;
        for (final item in listOfTime) {
          allTime += item;
        }
      }
      currentTimer = value.getInt(kWorkoutCurrentTimer) ?? 1;
      currentTimeOfExercise = listOfTime[currentTimer - 1];
      timerState = value.getInt(kWorkoutTimerState) ?? 0;
    });
  }

  void deleteData() async {
    await SharedPreferences.getInstance().then((value) {
      value.remove(kWorkoutTimerState);
      value.remove(kWorkoutListOfTime);
      value.remove(kWorkoutCurrentTimer);
      value.setBool(kWorkoutActive, false);
    });
  }

  void saveDataWhenOutFromApp() async {
    _timer?.cancel();
    await SharedPreferences.getInstance().then((value) {
      //Save data when user out from app
      value.setDouble(kWorkoutRemainingTime, currentTime);
      value.setString(
          kWorkoutDateTime, AppDate.dataBaseFormatter(DateTime.now()));
    });
  }

  void checkAfterOut() async {
    await SharedPreferences.getInstance().then((value) {
      //Get save data
      double? remainingTime = value.getDouble(kWorkoutRemainingTime);
      String? dateString = value.getString(kWorkoutDateTime);
      //Check on work timer
      if (timerState == 1 && dateString != null && remainingTime != null) {
        startTimer();
        currentTime = remainingTime +
            (DateTime.now()
                    .difference(AppDate.fromDataBaseFormatter(dateString))
                    .inMilliseconds /
                1000);
        //Delete data
        value.remove(kWorkoutRemainingTime);
        value.remove(kWorkoutDateTime);
      } else {
        currentTime = remainingTime ?? 0;
      }
    });
  }

  void nextExercise() async {
    pauseTimer();
    await SharedPreferences.getInstance().then((value) {
      currentTime = 0;
      currentTimeOfExercise = listOfTime[currentTimer];
      currentTimer++;
      value.setInt(kWorkoutCurrentTimer, currentTimer);
    });
  }

  void previousExercise() async {
    pauseTimer();
    await SharedPreferences.getInstance().then((value) {
      currentTime = 0;
      currentTimeOfExercise = listOfTime[currentTimer - 2];
      currentTimer--;
      value.setInt(kWorkoutCurrentTimer, currentTimer);
    });
  }
}
