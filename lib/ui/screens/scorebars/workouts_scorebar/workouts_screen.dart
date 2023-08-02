import 'package:android_freelance_7/controllers/workouts_controller.dart';
import 'package:android_freelance_7/ui/components/app_bg_icon_button.dart';
import 'package:android_freelance_7/ui/components/app_dif_icon_button.dart';
import 'package:android_freelance_7/ui/components/app_text.dart';
import 'package:android_freelance_7/ui/components/base_screen.dart';
import 'package:android_freelance_7/ui/screens/scorebars/workouts_scorebar/widgets/workouts_app_bar.dart';
import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:android_freelance_7/utils/app_icons.dart';
import 'package:android_freelance_7/utils/app_text_style.dart';
import 'package:android_freelance_7/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class WorkoutsScreen extends BaseScreen {
  const WorkoutsScreen({super.key});

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends BaseScreenState<WorkoutsScreen> {
  final WorkoutsController _workoutsController = Get.find();

  @override
  void initState() {
    _workoutsController.currentContext = context;
    _workoutsController.getData();
    super.initState();
  }

  @override
  void dispose() {
    _workoutsController.currentContext = null;
    super.dispose();
  }

  @override
  Widget buildMain(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          children: [
            WorkoutsAppBar(
              onFinishPressed: () {
                _workoutsController.finishTimer();
              },
            ),
            Flexible(
              child: FittedBox(
                child: Column(
                  children: [
                    const Gap(68),
                    Stack(
                      children: [
                        Container(
                          width: 340,
                          height: 340,
                          decoration: BoxDecoration(
                            color: AppColors.layer1,
                            borderRadius: BorderRadius.circular(250),
                          ),
                        ),
                        SizedBox(
                          height: 340,
                          width: 340,
                          child: CircularProgressIndicator(
                            value: _workoutsController.currentTime /
                                _workoutsController.currentTimeOfExercise,
                            strokeWidth: 8,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.accentPrimary1),
                          ),
                        ),
                        SizedBox(
                          width: 340,
                          height: 320,
                          child: Center(
                            child: AppText(
                              text:
                                  '${((_workoutsController.currentTimeOfExercise - _workoutsController.currentTime) ~/ 60).toString().padLeft(2, '0')}:${((_workoutsController.currentTimeOfExercise - _workoutsController.currentTime) % 60).toInt().toString().padLeft(2, '0')}',
                              style: AppTextStyles.number2,
                            ),
                          ),
                        ),
                        Container(
                          width: 340,
                          height: 340,
                          padding: const EdgeInsets.only(top: 150),
                          child: Center(
                            child: AppText(
                              text:
                                  'Exercise ${_workoutsController.currentTimer}',
                              style: AppTextStyles.bold1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(78),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [..._getCountOfTimers()],
                      ),
                    ),
                    const Gap(60),
                    _controllerWidget(),
                    const Gap(16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _controllerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RotatedBox(
          quarterTurns: 90,
          child: AppBgIconButton(
            height: 100,
            width: 100,
            assetName: AppIcons.icNext,
            activeBgColor: Colors.transparent,
            inactiveBgColor: Colors.transparent,
            pressedBgColor: Colors.transparent,
            activeChildColor: AppColors.textSecondary1,
            inactiveChildColor: AppColors.layer2,
            pressedChildColor: AppColors.textSecondary2,
            borderRadius: BorderRadius.zero,
            onPressed: _workoutsController.listOfTime.length > 1 &&
                    _workoutsController.currentTimer > 1
                ? () {
                    _workoutsController.previousExercise();
                  }
                : null,
          ),
        ),
        AppDifIconButton(
          icon: _workoutsController.timerState == 1
              ? AppIcons.icPauseBg
              : AppIcons.icPlayBg,
          pressedIcon: _workoutsController.timerState == 1
              ? AppIcons.icPauseBgPressed
              : AppIcons.icPlayBgPressed,
          inactiveIcon: _workoutsController.timerState == 1
              ? AppIcons.icPauseBgInactive
              : AppIcons.icPlayBgInactive,
          onPressed: () {
            if (_workoutsController.timerState != 1) {
              _workoutsController.startTimer();
            } else {
              _workoutsController.pauseTimer();
            }
          },
        ),
        AppBgIconButton(
          height: 100,
          width: 100,
          assetName: AppIcons.icNext,
          activeBgColor: Colors.transparent,
          inactiveBgColor: Colors.transparent,
          pressedBgColor: Colors.transparent,
          activeChildColor: AppColors.textSecondary1,
          inactiveChildColor: AppColors.layer2,
          pressedChildColor: AppColors.textSecondary2,
          borderRadius: BorderRadius.zero,
          onPressed: _workoutsController.listOfTime.length > 1 &&
                  _workoutsController.currentTimer <
                      _workoutsController.listOfTime.length
              ? () {
                  _workoutsController.nextExercise();
                }
              : null,
        ),
      ],
    );
  }

  List<Widget> _getCountOfTimers() {
    List<Widget> listOfContainers = [const Gap(20)];
    for (var i = 0; i < _workoutsController.countOfTimers; i++) {
      listOfContainers.add(
        Container(
          margin: const EdgeInsets.only(right: 20),
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: _workoutsController.currentTimer < (i + 1)
                ? AppColors.layer1
                : AppColors.accentPrimary1,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      );
    }
    return listOfContainers;
  }
}
