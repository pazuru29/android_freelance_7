import 'package:android_freelance_7/controllers/sport_controllers/sport_game_controller.dart';
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

class SportFinishedScreen extends BaseScreen {
  const SportFinishedScreen({super.key});

  @override
  State<SportFinishedScreen> createState() => _SportFinishedScreenState();
}

class _SportFinishedScreenState extends BaseScreenState<SportFinishedScreen> {
  final SportGameController _sportGameController = Get.find();

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
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(24),
                  if (_sportGameController.sportType != 4 &&
                      _sportGameController.sportType != 6)
                    _timeWidget(),
                  if (_sportGameController.sportType == 7) _chessWidget(),
                  if (_sportGameController.sportType != 7)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _scoresWidget(),
                        if (_sportGameController.sportType == 1 ||
                            _sportGameController.sportType == 2)
                          _foulsWidget(),
                        if (_sportGameController.sportType == 6)
                          _gamesSetsWidget(),
                      ],
                    ),
                  const Gap(16),
                ],
              ),
            ),
          ),
          AppButton(
            title: AppStrings.btnFinish,
            onPressed: () {
              _sportGameController.deleteData(context);
            },
          ),
          const Gap(16),
        ],
      ),
    );
  }

  Widget _chessWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          text: 'Number of Steps',
          style: AppTextStyles.captionRegular,
          color: AppColors.textSecondary1,
        ),
        const Gap(14),
        _textContainer(_sportGameController.nameTeam1.value,
            _sportGameController.scoreTeam1.toString()),
        const Gap(12),
        _textContainer(_sportGameController.nameTeam2.value,
            _sportGameController.scoreTeam2.toString()),
        const Gap(16),
        const AppText(
          text: 'Winner',
          style: AppTextStyles.captionRegular,
          color: AppColors.textSecondary1,
        ),
        const Gap(14),
        _textContainer(
            _sportGameController.scoreTeam1 > _sportGameController.scoreTeam2
                ? _sportGameController.nameTeam1.value
                : _sportGameController.nameTeam2.value,
            'Matt'),
      ],
    );
  }

  Widget _gamesSetsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(16),
        const AppText(
          text: 'Games',
          style: AppTextStyles.captionRegular,
          color: AppColors.textSecondary1,
        ),
        const Gap(14),
        _textContainer(_sportGameController.nameTeam1.value,
            _sportGameController.gameTeam1.toString()),
        const Gap(12),
        _textContainer(_sportGameController.nameTeam2.value,
            _sportGameController.gameTeam2.toString()),
        const Gap(16),
        const AppText(
          text: 'Sets',
          style: AppTextStyles.captionRegular,
          color: AppColors.textSecondary1,
        ),
        const Gap(14),
        _textContainer(_sportGameController.nameTeam1.value,
            _sportGameController.setsTeam1.toString()),
        const Gap(12),
        _textContainer(_sportGameController.nameTeam2.value,
            _sportGameController.setsTeam2.toString()),
      ],
    );
  }

  Widget _timeWidget() {
    return Column(
      children: [
        _textContainer(AppStrings.time,
            '${((_sportGameController.mainTimeOfMatch + _sportGameController.secondTimeOfMatch) ~/ 60).toString().padLeft(2, '0')}:${((_sportGameController.mainTimeOfMatch + _sportGameController.secondTimeOfMatch) % 60).toInt().toString().padLeft(2, '0')}'),
        const Gap(16),
      ],
    );
  }

  Widget _scoresWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          text: 'Score',
          style: AppTextStyles.captionRegular,
          color: AppColors.textSecondary1,
        ),
        const Gap(14),
        _textContainer(_sportGameController.nameTeam1.value,
            _sportGameController.scoreTeam1.toString()),
        const Gap(12),
        _textContainer(_sportGameController.nameTeam2.value,
            _sportGameController.scoreTeam2.toString()),
      ],
    );
  }

  Widget _foulsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(16),
        const AppText(
          text: 'Fouls',
          style: AppTextStyles.captionRegular,
          color: AppColors.textSecondary1,
        ),
        const Gap(14),
        _textContainer(_sportGameController.nameTeam1.value,
            _sportGameController.foulsTeam1.toString()),
        const Gap(12),
        _textContainer(_sportGameController.nameTeam2.value,
            _sportGameController.foulsTeam2.toString()),
      ],
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
