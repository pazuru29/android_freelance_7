import 'package:android_freelance_7/controllers/app_navigator.dart';
import 'package:android_freelance_7/controllers/workouts_controller.dart';
import 'package:android_freelance_7/ui/components/app_button.dart';
import 'package:android_freelance_7/ui/components/app_text.dart';
import 'package:android_freelance_7/ui/components/base_screen.dart';
import 'package:android_freelance_7/ui/screens/scorebars/workouts_scorebar/widgets/exercise_card.dart';
import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:android_freelance_7/utils/app_icons.dart';
import 'package:android_freelance_7/utils/app_strings.dart';
import 'package:android_freelance_7/utils/app_text_style.dart';
import 'package:android_freelance_7/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FinishedWorkoutScreen extends BaseScreen {
  const FinishedWorkoutScreen({super.key});

  @override
  State<FinishedWorkoutScreen> createState() => _FinishedWorkoutScreenState();
}

class _FinishedWorkoutScreenState
    extends BaseScreenState<FinishedWorkoutScreen> {
  final WorkoutsController _workoutsController = Get.find();

  @override
  Widget buildMain(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(96),
          const AppText(
            text: 'Finished workout',
            style: AppTextStyles.headerSemibold,
          ),
          const Gap(24),
          _textContainer(AppStrings.time,
              '${(_workoutsController.allTime ~/ 60).toString().padLeft(2, '0')}:${(_workoutsController.allTime % 60).toInt().toString().padLeft(2, '0')}'),
          const Gap(16),
          const AppText(
            text: 'Sets',
            style: AppTextStyles.captionRegular,
            color: AppColors.textSecondary1,
          ),
          const Gap(14),
          Expanded(
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: _workoutsController.listOfTime.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    if (index != 0)
                      Container(
                        height: 1,
                        color: AppColors.layer2,
                      ),
                    const Gap(12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(AppIcons.icExercise),
                            const Gap(10),
                            AppText(
                              text: 'Exercise ${index + 1}',
                              style: AppTextStyles.bodyRegular,
                            ),
                          ],
                        ),
                        AppText(
                          text:
                              '${(_workoutsController.listOfTime[index] ~/ 60).toString().padLeft(2, '0')}:${(_workoutsController.listOfTime[index] % 60).toInt().toString().padLeft(2, '0')}',
                          style: AppTextStyles.bodyRegular,
                        ),
                      ],
                    ),
                    const Gap(12),
                  ],
                );
              },
            ),
          ),
          AppButton(
            title: AppStrings.btnFinish,
            onPressed: () {
              _workoutsController.deleteData();
              AppNavigator.goBack(context);
            },
          ),
          Gap(MediaQuery.of(context).padding.bottom + 16),
        ],
      ),
    );
  }

  Widget _textContainer(String title, String subTitle) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 23),
      decoration: BoxDecoration(
        color: AppColors.layer1,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            text: title,
            style: AppTextStyles.bodyRegular,
          ),
          AppText(
            text: subTitle,
            style: AppTextStyles.bodyRegular,
          ),
        ],
      ),
    );
  }
}
