import 'package:android_freelance_7/controllers/simple_score_bar_controller.dart';
import 'package:android_freelance_7/ui/components/app_button.dart';
import 'package:android_freelance_7/ui/components/app_text.dart';
import 'package:android_freelance_7/ui/components/base_screen.dart';
import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:android_freelance_7/utils/app_strings.dart';
import 'package:android_freelance_7/utils/app_text_style.dart';
import 'package:android_freelance_7/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FinishedSimpleScoreBarScreen extends BaseScreen {
  const FinishedSimpleScoreBarScreen({super.key});

  @override
  State<FinishedSimpleScoreBarScreen> createState() =>
      _FinishedSimpleScoreBarScreenState();
}

class _FinishedSimpleScoreBarScreenState
    extends BaseScreenState<FinishedSimpleScoreBarScreen> {
  final SimpleScoreBarController _simpleScoreBarController = Get.find();

  @override
  Widget buildMain(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(96),
          const FittedBox(
            child: AppText(
              text: 'Finished competition',
              style: AppTextStyles.headerSemibold,
            ),
          ),
          const Gap(24),
          _textContainer(AppStrings.time,
              '${(_simpleScoreBarController.timeOfMatch ~/ 60).toString().padLeft(2, '0')}:${(_simpleScoreBarController.timeOfMatch % 60).toInt().toString().padLeft(2, '0')}'),
          const Gap(16),
          const AppText(
            text: 'Score',
            style: AppTextStyles.captionRegular,
            color: AppColors.textSecondary1,
          ),
          const Gap(14),
          _textContainer(_simpleScoreBarController.nameTeam1.value,
              _simpleScoreBarController.scoreTeam1.toString()),
          const Gap(12),
          _textContainer(_simpleScoreBarController.nameTeam2.value,
              _simpleScoreBarController.scoreTeam2.toString()),
          if (_simpleScoreBarController.numberOfPlayers > 2) const Gap(12),
          if (_simpleScoreBarController.numberOfPlayers > 2)
            _textContainer(_simpleScoreBarController.nameTeam3.value,
                _simpleScoreBarController.scoreTeam3.toString()),
          if (_simpleScoreBarController.numberOfPlayers > 3) const Gap(12),
          if (_simpleScoreBarController.numberOfPlayers > 3)
            _textContainer(_simpleScoreBarController.nameTeam4.value,
                _simpleScoreBarController.scoreTeam4.toString()),
          const Spacer(),
          AppButton(
            title: AppStrings.btnFinish,
            onPressed: () {
              _simpleScoreBarController.deleteSaveData(context);
            },
          ),
          const Gap(16),
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
