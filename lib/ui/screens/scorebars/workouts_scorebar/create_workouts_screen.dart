import 'dart:math';

import 'package:android_freelance_7/controllers/app_navigator.dart';
import 'package:android_freelance_7/controllers/workouts_controller.dart';
import 'package:android_freelance_7/ui/components/app_bar/secondary_app_bar.dart';
import 'package:android_freelance_7/ui/components/app_button.dart';
import 'package:android_freelance_7/ui/components/base_screen.dart';
import 'package:android_freelance_7/ui/screens/scorebars/workouts_scorebar/widgets/exercise_card.dart';
import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:android_freelance_7/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateWorkoutsScreen extends BaseScreen {
  const CreateWorkoutsScreen({super.key});

  @override
  State<CreateWorkoutsScreen> createState() => _CreateWorkoutsScreenState();
}

class _CreateWorkoutsScreenState extends BaseScreenState<CreateWorkoutsScreen> {
  final WorkoutsController _workoutsController = Get.find();

  @override
  void initState() {
    _workoutsController.onInit();
    super.initState();
  }

  @override
  Widget buildMain(BuildContext context) {
    return Obx(
      () => SlidableAutoCloseBehavior(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            children: [
              const SecondaryAppBar(
                title: 'New timer',
                subtitle: 'Timer for workouts',
              ),
              const Gap(8),
              Expanded(
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _workoutsController.listOfTime.length + 1,
                  itemBuilder: (context, index) {
                    if (index == _workoutsController.listOfTime.length) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 16),
                        child: AppButton.outlined(
                          title: '+ Add new set',
                          onPressed: index == 8
                              ? null
                              : () {
                                  _workoutsController.addExercise();
                                },
                        ),
                      );
                    }
                    return Column(
                      children: [
                        if (index != 0)
                          Container(
                            height: 1,
                            color: AppColors.layer2,
                          ),
                        const Gap(12),
                        ExerciseCard(
                          key: UniqueKey(),
                          textColor: index == 0
                              ? AppColors.textPrimary
                              : AppColors.textSecondary1,
                          enabledDelete:
                              _workoutsController.listOfTime.length != 1,
                          title: 'Exercise ${index + 1}',
                          time: _workoutsController.listOfTime[index],
                          onDeletePressed: () {
                            _workoutsController.removeExercise(index);
                          },
                          onTimeChange: (time) {
                            _workoutsController.changeTime(time, index);
                          },
                        ),
                        const Gap(12),
                      ],
                    );
                  },
                ),
              ),
              AppButton(
                title: 'Start',
                onPressed: () async {
                  _workoutsController.saveData();
                  await SharedPreferences.getInstance().then((value) {
                    value.setBool(kWorkoutActive, true);
                    AppNavigator.replaceToWorkoutsScreen(context);
                  });
                },
              ),
              Gap(MediaQuery.of(context).padding.bottom + 16),
            ],
          ),
        ),
      ),
    );
  }
}
