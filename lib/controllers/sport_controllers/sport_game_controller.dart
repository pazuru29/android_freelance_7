import 'dart:async';

import 'package:android_freelance_7/controllers/app_navigator.dart';
import 'package:android_freelance_7/data/database/database_helper.dart';
import 'package:android_freelance_7/data/database/models/history_model.dart';
import 'package:android_freelance_7/utils/app_strings.dart';
import 'package:android_freelance_7/utils/constants.dart';
import 'package:android_freelance_7/utils/extansions/app_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SportGameController extends GetxController {
  BuildContext? currentContext;

  //Current player timer -- 1 || 2
  final RxInt _currentPlayerTimer = 1.obs;

  int get currentPlayerTimer => _currentPlayerTimer.value;

  set currentPlayerTimer(int value) => _currentPlayerTimer.value = value;

  //Sport type
  final RxInt _sportType = 0.obs;

  int get sportType => _sportType.value;

  set sportType(int value) => _sportType.value = value;

  //Name of team
  RxString nameTeam1 = AppStrings.team1.obs;
  RxString nameTeam2 = AppStrings.team2.obs;

  //Score of team
  final RxInt _scoreTeam1 = 0.obs;

  int get scoreTeam1 => _scoreTeam1.value;

  set scoreTeam1(int value) => _scoreTeam1.value = value;

  final RxInt _scoreTeam2 = 0.obs;

  int get scoreTeam2 => _scoreTeam2.value;

  set scoreTeam2(int value) => _scoreTeam2.value = value;

  //Fouls of team
  final RxInt _foulsTeam1 = 0.obs;

  int get foulsTeam1 => _foulsTeam1.value;

  set foulsTeam1(int value) => _foulsTeam1.value = value;

  final RxInt _foulsTeam2 = 0.obs;

  int get foulsTeam2 => _foulsTeam2.value;

  set foulsTeam2(int value) => _foulsTeam2.value = value;

  //Game of team
  final RxInt _gameTeam1 = 0.obs;

  int get gameTeam1 => _gameTeam1.value;

  set gameTeam1(int value) => _gameTeam1.value = value;

  final RxInt _gameTeam2 = 0.obs;

  int get gameTeam2 => _gameTeam2.value;

  set gameTeam2(int value) => _gameTeam2.value = value;

  //Sets of team
  final RxInt _setsTeam1 = 0.obs;

  int get setsTeam1 => _setsTeam1.value;

  set setsTeam1(int value) => _setsTeam1.value = value;

  final RxInt _setsTeam2 = 0.obs;

  int get setsTeam2 => _setsTeam2.value;

  set setsTeam2(int value) => _setsTeam2.value = value;

  //Main time
  final RxInt _mainTimeOfMatch = 0.obs;

  int get mainTimeOfMatch => _mainTimeOfMatch.value;

  set mainTimeOfMatch(int value) => _mainTimeOfMatch.value = value;

  //Second time
  final RxInt _secondTimeOfMatch = 0.obs;

  int get secondTimeOfMatch => _secondTimeOfMatch.value;

  set secondTimeOfMatch(int value) => _secondTimeOfMatch.value = value;

  // Timer interval of timer
  final _interval = const Duration(milliseconds: 25);

  // Timer time
  final RxDouble _currentTime = 0.0.obs;

  double get currentTime => _currentTime.value;

  set currentTime(double currentTime) => _currentTime.value = currentTime;

  //Second timer time
  final RxDouble _secondCurrentTime = 0.0.obs;

  double get secondCurrentTime => _secondCurrentTime.value;

  set secondCurrentTime(double currentTime) =>
      _secondCurrentTime.value = currentTime;

  // Timer
  Timer? _timer;

  //Timer type
  final RxInt _timerState = 0.obs;

  int get timerState => _timerState.value;

  set timerState(int value) => _timerState.value = value;

  //Second timer type
  final RxInt _secondTimerState = 0.obs;

  int get secondTimerState => _secondTimerState.value;

  set secondTimerState(int value) => _secondTimerState.value = value;

  //Start timer
  void startTimer() async {
    //TODO
    if (sportType == 7) {
      await SharedPreferences.getInstance().then((value) {
        if (currentPlayerTimer == 1) {
          timerState = 1;
          secondTimerState = 2;
          value.setInt(kSportMainTimerState, 1);
          value.setInt(kSportSecondTimerState, 2);
        } else {
          timerState = 2;
          secondTimerState = 1;
          value.setInt(kSportMainTimerState, 2);
          value.setInt(kSportSecondTimerState, 1);
        }
      });
      debugPrint('TIMER STARTED');
      _timer = Timer.periodic(_interval, (timer) {
        if (currentPlayerTimer == 1) {
          _currentTime.value += 0.025;
          debugPrint('${_currentTime.value}');
          if (_currentTime.value >= mainTimeOfMatch) {
            finishTimer();
          }
        } else {
          _secondCurrentTime.value += 0.025;
          debugPrint('${_secondCurrentTime.value}');
          if (_secondCurrentTime.value >= secondTimeOfMatch) {
            finishTimer();
          }
        }
      });
    } else {
      await SharedPreferences.getInstance().then((value) {
        value.setInt(kSportMainTimerState, 1);
      });
      debugPrint('TIMER STARTED');
      _timerState.value = 1;
      _timer = Timer.periodic(_interval, (timer) {
        _currentTime.value += 0.025;
        debugPrint('${_currentTime.value}');
        if (_currentTime.value >= mainTimeOfMatch) {
          finishTimer();
        }
      });
    }
  }

  // Pause timer without save in db
  void pauseTimer() async {
    await SharedPreferences.getInstance().then((value) {
      value.setInt(kSportMainTimerState, 2);
      value.setInt(kSportSecondTimerState, 2);
    });
    debugPrint('TIMER PAUSED');
    _timerState.value = 2;
    _secondTimerState.value = 2;
    _timer?.cancel();
  }

  //Finish timer
  void finishTimer() async {
    await SharedPreferences.getInstance().then((value) {
      value.setInt(kSportMainTimerState, 3);
      value.setInt(kSportSecondTimerState, 3);
      currentTime = 0;
      _timerState.value = 3;
      _secondTimerState.value = 3;
      _timer?.cancel();
      if (currentContext != null) {
        AppNavigator.replaceToSportFinishedScreen(currentContext!);
      }
    });
  }

  //Get init data
  void getData() async {
    await SharedPreferences.getInstance().then((value) {
      sportType = value.getInt(kSportType) ?? 1;
      nameTeam1.value = value.getString(kSportNameTeam1) ?? AppStrings.team1;
      nameTeam2.value = value.getString(kSportNameTeam2) ?? AppStrings.team2;
      timerState = sportType == 4 || sportType == 6
          ? 2
          : value.getInt(kSportMainTimerState) ?? 0;
      mainTimeOfMatch = value.getInt(kSportMainTimerTime) ?? 0;
      scoreTeam1 = value.getInt(kSportScoreTeam1) ?? 0;
      scoreTeam2 = value.getInt(kSportScoreTeam2) ?? 0;
      foulsTeam1 = value.getInt(kSportFoulsTeam1) ?? 0;
      foulsTeam2 = value.getInt(kSportFoulsTeam2) ?? 0;
      gameTeam1 = value.getInt(kSportGameCountTeam1) ?? 0;
      gameTeam2 = value.getInt(kSportGameCountTeam2) ?? 0;
      setsTeam1 = value.getInt(kSportSetsCountTeam1) ?? 0;
      setsTeam2 = value.getInt(kSportSetsCountTeam2) ?? 0;
      secondTimerState = value.getInt(kSportSecondTimerState) ?? 2;
      mainTimeOfMatch = value.getInt(kSportMainTimerTime) ?? 0;
      secondTimeOfMatch = value.getInt(kSportSecondTimerTime) ?? 0;
      if (sportType == 7) {
        getCurrentPlayerTimer(value, timerState);
      }
    });
  }

  void getCurrentPlayerTimer(
      SharedPreferences value, int mainTimerState) async {
    currentPlayerTimer = mainTimerState == 0 || mainTimerState == 1 ? 1 : 2;
  }

  void deleteData(BuildContext context) async {
    currentTime = 0;
    secondCurrentTime = 0;
    await DatabaseHelper.instance.addHistory(
      HistoryModel(
        sportType: sportType,
        timeOfMatch: mainTimeOfMatch + secondTimeOfMatch,
        scoreTeam1: scoreTeam1,
        scoreTeam2: scoreTeam2,
      ),
    );
    await SharedPreferences.getInstance().then((value) async {
      value.setBool(kSportScoreBarActive, false);
      value.remove(kSportType);
      value.remove(kSportMainTimerState);
      value.remove(kSportMainTimerTime);
      value.remove(kSportMainRemainingTime);
      value.remove(kSportDateTime);
      value.remove(kSportNameTeam1);
      value.remove(kSportNameTeam2);
      value.remove(kSportScoreTeam1);
      value.remove(kSportScoreTeam2);
      value.remove(kSportSecondTimerState);
      value.remove(kSportSecondTimerTime);
      value.remove(kSportSecondRemainingTime);
      value.remove(kSportFoulsTeam1);
      value.remove(kSportFoulsTeam2);
      value.remove(kSportGameCountTeam1);
      value.remove(kSportGameCountTeam2);
      value.remove(kSportSetsCountTeam1);
      value.remove(kSportSetsCountTeam2);

      AppNavigator.goBack(context);
    });
  }

  void incrementScore(int count, int numberOfTeam) async {
    await SharedPreferences.getInstance().then((value) {
      if (numberOfTeam == 1) {
        scoreTeam1 += count;
        value.setInt(kSportScoreTeam1, scoreTeam1);
      } else {
        scoreTeam2 += count;
        value.setInt(kSportScoreTeam2, scoreTeam2);
      }
    });
  }

  void decrementScore(int count, int numberOfTeam) async {
    await SharedPreferences.getInstance().then((value) {
      if (numberOfTeam == 1) {
        scoreTeam1 -= count;
        value.setInt(kSportScoreTeam1, scoreTeam1);
      } else {
        scoreTeam2 -= count;
        value.setInt(kSportScoreTeam2, scoreTeam2);
      }
    });
  }

  void incrementFouls(int numberOfTeam) async {
    await SharedPreferences.getInstance().then((value) {
      if (numberOfTeam == 1) {
        foulsTeam1++;
        value.setInt(kSportFoulsTeam1, foulsTeam1);
      } else {
        foulsTeam2++;
        value.setInt(kSportFoulsTeam2, foulsTeam2);
      }
    });
  }

  void incrementChessScore(int numberOfTeam) async {
    await SharedPreferences.getInstance().then((value) {
      if (numberOfTeam == 1) {
        timerState = 2;
        secondTimerState = 1;
        currentPlayerTimer = 2;
        scoreTeam1++;
        value.setInt(kSportScoreTeam1, scoreTeam1);
        value.setInt(kSportMainTimerState, 1);
        value.setInt(kSportSecondTimerState, 2);
      } else {
        secondTimerState = 2;
        timerState = 1;
        currentPlayerTimer = 1;
        scoreTeam2++;
        value.setInt(kSportScoreTeam2, scoreTeam2);
        value.setInt(kSportMainTimerState, 2);
        value.setInt(kSportSecondTimerState, 1);
      }
    });
  }

  void incrementTennisScore(int numberOfTeam) async {
    await SharedPreferences.getInstance().then((value) {
      if (numberOfTeam == 1) {
        scoreTeam1++;
        value.setInt(kSportScoreTeam1, scoreTeam1);
        if (scoreTeam1 % 40 == 0) {
          gameTeam1++;
          value.setInt(kSportGameCountTeam1, gameTeam1);
          if (gameTeam1 % 5 == 0) {
            setsTeam1++;
            value.setInt(kSportSetsCountTeam1, setsTeam1);
            if (setsTeam1 == 2) {
              finishTimer();
            }
          }
        }
      } else {
        scoreTeam2++;
        value.setInt(kSportScoreTeam2, scoreTeam2);
        if (scoreTeam2 % 40 == 0) {
          gameTeam2++;
          value.setInt(kSportGameCountTeam2, gameTeam2);
          if (gameTeam2 % 5 == 0) {
            setsTeam2++;
            value.setInt(kSportSetsCountTeam2, setsTeam2);
            if (setsTeam2 == 2) {
              finishTimer();
            }
          }
        }
      }
    });
  }

  void decrementTennisScore(int numberOfTeam) async {
    await SharedPreferences.getInstance().then((value) {
      if (numberOfTeam == 1) {
        scoreTeam1--;
        value.setInt(kSportScoreTeam1, scoreTeam1);
        if ((scoreTeam1 + 1) % 40 == 0) {
          gameTeam1--;
          value.setInt(kSportGameCountTeam1, gameTeam1);
          if ((gameTeam1 + 1) % 5 == 0) {
            setsTeam1--;
            value.setInt(kSportSetsCountTeam1, setsTeam1);
          }
        }
      } else {
        scoreTeam2++;
        value.setInt(kSportScoreTeam2, scoreTeam2);
        if (scoreTeam2 % 40 == 0) {
          gameTeam2--;
          value.setInt(kSportGameCountTeam2, gameTeam2);
          if (gameTeam2 % 5 == 0) {
            setsTeam2--;
            value.setInt(kSportSetsCountTeam2, setsTeam2);
          }
        }
      }
    });
  }

  void saveDataWhenOutFromApp() async {
    _timer?.cancel();
    await SharedPreferences.getInstance().then((value) {
      //Save data when user out from app
      value.setString(
          kSportDateTime, AppDate.dataBaseFormatter(DateTime.now()));
      value.setDouble(kSportMainRemainingTime, currentTime);
      value.setDouble(kSportSecondRemainingTime, secondCurrentTime);
    });
  }

  void checkAfterOut() async {
    await SharedPreferences.getInstance().then((value) {
      //Get save data
      double? remainingTime = value.getDouble(kSportMainRemainingTime);
      double? secondRemainingTime = value.getDouble(kSportSecondRemainingTime);
      String? dateString = value.getString(kSportDateTime);
      //Check on work timer
      if (dateString != null &&
          remainingTime != null &&
          secondRemainingTime != null) {
        if (timerState == 1 || secondTimerState == 1) {
          startTimer();
          if (timerState == 1) {
            currentTime = remainingTime +
                (DateTime.now()
                        .difference(AppDate.fromDataBaseFormatter(dateString))
                        .inMilliseconds /
                    1000);
            secondCurrentTime = secondRemainingTime;
          } else if (secondTimerState == 1) {
            currentTime = remainingTime;
            secondCurrentTime = secondRemainingTime +
                (DateTime.now()
                        .difference(AppDate.fromDataBaseFormatter(dateString))
                        .inMilliseconds /
                    1000);
          }
          //Delete data
          value.remove(kSportMainRemainingTime);
          value.remove(kSportSecondRemainingTime);
          value.remove(kSportDateTime);
        }
      } else {
        currentTime = remainingTime ?? 0;
        secondCurrentTime = secondRemainingTime ?? 0;
      }
    });
  }

  @override
  void onInit() {
    getData();
    checkAfterOut();
    super.onInit();
  }
}
