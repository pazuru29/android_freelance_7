import 'package:android_freelance_7/controllers/app_navigator.dart';
import 'package:android_freelance_7/controllers/simple_score_bar_controller.dart';
import 'package:android_freelance_7/controllers/sport_controllers/sport_game_controller.dart';
import 'package:android_freelance_7/controllers/workouts_controller.dart';
import 'package:android_freelance_7/main.dart';
import 'package:android_freelance_7/ui/components/app_bar/main_app_bar.dart';
import 'package:android_freelance_7/ui/components/base_screen.dart';
import 'package:android_freelance_7/ui/screens/home_screen/widgets/history_button.dart';
import 'package:android_freelance_7/ui/screens/home_screen/widgets/main_menu_card.dart';
import 'package:android_freelance_7/utils/app_icons.dart';
import 'package:android_freelance_7/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends BaseScreen {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseScreenState<HomeScreen>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final SimpleScoreBarController simpleScoreBarController = Get.find();
    final WorkoutsController workoutsController = Get.find();
    final SportGameController sportGameController = Get.find();

    if (state == AppLifecycleState.paused) {
      await SharedPreferences.getInstance().then((value) {
        //Simple
        bool? isSimpleActive = value.getBool(kSimpleScoreBarActive);
        if (isSimpleActive == true) {
          simpleScoreBarController.saveDataWhenOutFromApp();
          debugPrint('SAVE SIMPLE DATA');
        }
        //Workout
        bool? isWorkoutActive = value.getBool(kWorkoutActive);
        if (isWorkoutActive == true) {
          workoutsController.saveDataWhenOutFromApp();
          debugPrint('SAVE WORKOUT DATA');
        }
        //Sport
        bool? isSportActive = value.getBool(kSportScoreBarActive);
        if (isSportActive == true) {
          sportGameController.saveDataWhenOutFromApp();
          debugPrint('SAVE SPORT DATA');
        }
      });
      debugPrint('PAUSED');
    }

    if (state == AppLifecycleState.resumed) {
      await SharedPreferences.getInstance().then((value) {
        //Simple
        bool? isSimpleActive = value.getBool(kSimpleScoreBarActive);
        if (isSimpleActive == true) {
          simpleScoreBarController.checkAfterOut();
          debugPrint('CHECK SIMPLE DATA');
        }
        //Workout
        bool? isWorkoutActive = value.getBool(kWorkoutActive);
        if (isWorkoutActive == true) {
          workoutsController.checkAfterOut();
          debugPrint('CHECK WORKOUT DATA');
        }
        //Sport
        bool? isSportActive = value.getBool(kSportScoreBarActive);
        if (isSportActive == true) {
          sportGameController.checkAfterOut();
          debugPrint('CHECK SPORT DATA');
        }
      });
      debugPrint('RESUMED');
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    initControllers();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget buildMain(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MainAppBar(
              title: 'Scoreboard',
              subtitle: 'Hello! Select category to continue',
            ),
            const Gap(25),
            Row(
              children: [
                Flexible(
                  flex: 3,
                  child: MainMenuCard(
                    height: 185,
                    width: MediaQuery.of(context).size.width,
                    paddings: const EdgeInsets.fromLTRB(29, 36, 29, 28),
                    assetName: AppIcons.icFootball,
                    title: 'Sport Scoreboard',
                    onPressed: () async {
                      await SharedPreferences.getInstance().then((value) {
                        bool? isActive = value.getBool(kSportScoreBarActive);
                        final SportGameController sportGameController =
                            Get.find();
                        if (isActive == true &&
                            sportGameController.timerState == 3) {
                          AppNavigator.goToSportFinishedScreen(context);
                        } else if (isActive == true) {
                          AppNavigator.goToSportGameScreen(context);
                        } else {
                          AppNavigator.goToSportTypesScreen(context);
                        }
                      });
                    },
                  ),
                ),
                const Gap(12),
                Flexible(
                  flex: 2,
                  child: MainMenuCard(
                    height: 185,
                    width: MediaQuery.of(context).size.width,
                    paddings: const EdgeInsets.fromLTRB(22, 36, 22, 22),
                    assetName: AppIcons.icChoppingBoard,
                    title: 'Simple\nScoreboard',
                    onPressed: () async {
                      await SharedPreferences.getInstance().then((value) {
                        final SimpleScoreBarController
                            simpleScoreBarController = Get.find();
                        bool? isActive = value.getBool(kSimpleScoreBarActive);
                        if (isActive == true &&
                            simpleScoreBarController.timerState == 3) {
                          AppNavigator.goToFinishedSimpleScoreBarScreen(
                              context);
                        } else if (isActive == true) {
                          AppNavigator.goToSimpleScoreBarScreen(context);
                        } else {
                          AppNavigator.goToCreateSimpleScoreBarScreen(context);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            const Gap(12),
            MainMenuCard(
              paddings: const EdgeInsets.symmetric(vertical: 14),
              isHorizontal: true,
              assetName: AppIcons.icStopwatch,
              title: 'Timer for Workouts',
              onPressed: () async {
                await SharedPreferences.getInstance().then((value) {
                  bool? isActive = value.getBool(kWorkoutActive);
                  final WorkoutsController workoutsController = Get.find();
                  if (isActive == true && workoutsController.timerState == 3) {
                    AppNavigator.goToFinishedWorkoutScreen(context);
                  } else if (isActive == true) {
                    AppNavigator.goToWorkoutsScreen(context);
                  } else {
                    AppNavigator.goToCreateWorkoutsScreen(context);
                  }
                });
              },
            ),
            const Spacer(),
            HistoryButton(
              onPressed: () {
                AppNavigator.goToHistoryScreen(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
