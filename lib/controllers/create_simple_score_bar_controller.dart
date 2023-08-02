import 'package:android_freelance_7/controllers/app_navigator.dart';
import 'package:android_freelance_7/controllers/simple_score_bar_controller.dart';
import 'package:android_freelance_7/utils/app_strings.dart';
import 'package:android_freelance_7/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateSimpleScoreBarController extends GetxController {
  final RxInt _numberOfPlayers = 0.obs;

  int get numberOfPlayers => _numberOfPlayers.value;

  set numberOfPlayers(int value) => _numberOfPlayers.value = value;

  final RxInt _timeOfMatch = 0.obs;

  int get timeOfMatch => _timeOfMatch.value;

  set timeOfMatch(int value) => _timeOfMatch.value = value;

  final RxInt _timerState = 0.obs;

  int get timerState => _timerState.value;

  set timerState(int value) => _timerState.value = value;

  final Rx<TextEditingController> name1Controller = TextEditingController().obs;
  final Rx<TextEditingController> name2Controller = TextEditingController().obs;
  final Rx<TextEditingController> name3Controller = TextEditingController().obs;
  final Rx<TextEditingController> name4Controller = TextEditingController().obs;

  final Rx<FocusNode> name1Focus = FocusNode().obs;
  final Rx<FocusNode> name2Focus = FocusNode().obs;
  final Rx<FocusNode> name3Focus = FocusNode().obs;
  final Rx<FocusNode> name4Focus = FocusNode().obs;

  @override
  void onInit() {
    _numberOfPlayers.value = 2;
    _timeOfMatch.value = 600;
    name1Controller.value.text = '';
    name2Controller.value.text = '';
    name3Controller.value.text = '';
    name4Controller.value.text = '';
    super.onInit();
  }

  void saveData(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String tmpName1 = name1Controller.value.text.isNotEmpty
        ? name1Controller.value.text
        : AppStrings.team1;
    String tmpName2 = name2Controller.value.text.isNotEmpty
        ? name2Controller.value.text
        : AppStrings.team2;
    String tmpName3 = name3Controller.value.text.isNotEmpty
        ? name3Controller.value.text
        : AppStrings.team3;
    String tmpName4 = name4Controller.value.text.isNotEmpty
        ? name4Controller.value.text
        : AppStrings.team4;
    List<Future> responses = [
      prefs.setBool(kSimpleScoreBarActive, true),
      prefs.setInt(kSimpleScoreBarNumberOfPlayers, numberOfPlayers),
      prefs.setInt(kSimpleScoreBarTime, timeOfMatch),
      prefs.setInt(kSimpleScoreBarTimerState, 0),
      prefs.setString(kSimpleScoreBarNameTeam1, tmpName1),
      prefs.setString(kSimpleScoreBarNameTeam2, tmpName2),
      prefs.setString(kSimpleScoreBarNameTeam3, tmpName3),
      prefs.setString(kSimpleScoreBarNameTeam4, tmpName4),
    ];
    await Future.wait(responses).whenComplete(
      () => AppNavigator.replaceToSimpleScoreBarScreen(context),
    );
  }

  void getEditData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    numberOfPlayers = prefs.getInt(kSimpleScoreBarNumberOfPlayers) ?? 2;
    timeOfMatch = prefs.getInt(kSimpleScoreBarTime) ?? 0;
    timerState = prefs.getInt(kSimpleScoreBarTimerState) ?? 0;
    name1Controller.value.text =
        prefs.getString(kSimpleScoreBarNameTeam1) ?? AppStrings.team1;
    name2Controller.value.text =
        prefs.getString(kSimpleScoreBarNameTeam2) ?? AppStrings.team2;
    name3Controller.value.text =
        prefs.getString(kSimpleScoreBarNameTeam3) ?? AppStrings.team3;
    name4Controller.value.text =
        prefs.getString(kSimpleScoreBarNameTeam4) ?? AppStrings.team4;
  }

  void saveEditData(BuildContext context) async {
    final SimpleScoreBarController simpleScoreBarController = Get.find();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String tmpName1 = name1Controller.value.text.isNotEmpty
        ? name1Controller.value.text
        : AppStrings.team1;
    String tmpName2 = name2Controller.value.text.isNotEmpty
        ? name2Controller.value.text
        : AppStrings.team2;
    String tmpName3 = name3Controller.value.text.isNotEmpty
        ? name3Controller.value.text
        : AppStrings.team3;
    String tmpName4 = name4Controller.value.text.isNotEmpty
        ? name4Controller.value.text
        : AppStrings.team4;
    List<Future> responses = [
      prefs.setBool(kSimpleScoreBarActive, true),
      prefs.setInt(kSimpleScoreBarNumberOfPlayers, numberOfPlayers),
      prefs.setInt(kSimpleScoreBarTime, timeOfMatch),
      prefs.setInt(kSimpleScoreBarTimerState, 0),
      prefs.setString(kSimpleScoreBarNameTeam1, tmpName1),
      prefs.setString(kSimpleScoreBarNameTeam2, tmpName2),
      prefs.setString(kSimpleScoreBarNameTeam3, tmpName3),
      prefs.setString(kSimpleScoreBarNameTeam4, tmpName4),
    ];
    await Future.wait(responses).whenComplete(
      () {
        simpleScoreBarController.getData();
        AppNavigator.goBack(context);
      },
    );
  }
}
