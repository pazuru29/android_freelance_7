import 'package:android_freelance_7/controllers/app_navigator.dart';
import 'package:android_freelance_7/controllers/simple_score_bar_controller.dart';
import 'package:android_freelance_7/ui/components/app_bar/game_app_bar.dart';
import 'package:android_freelance_7/ui/components/app_bg_icon_button.dart';
import 'package:android_freelance_7/ui/components/app_icon_button.dart';
import 'package:android_freelance_7/ui/components/app_text.dart';
import 'package:android_freelance_7/ui/components/base_screen.dart';
import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:android_freelance_7/utils/app_icons.dart';
import 'package:android_freelance_7/utils/app_text_style.dart';
import 'package:android_freelance_7/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SimpleScoreBarScreen extends BaseScreen {
  const SimpleScoreBarScreen({super.key});

  @override
  State<SimpleScoreBarScreen> createState() => _SimpleScoreBarScreenState();
}

class _SimpleScoreBarScreenState extends BaseScreenState<SimpleScoreBarScreen> {
  late final SimpleScoreBarController _simpleScoreBarController;

  @override
  void initState() {
    _simpleScoreBarController = Get.find();
    _simpleScoreBarController.currentContext = context;
    _simpleScoreBarController.getData();
    super.initState();
  }

  @override
  void dispose() {
    _simpleScoreBarController.currentContext = null;
    super.dispose();
  }

  @override
  Widget buildMain(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          children: [
            GameAppBar(
              onFinishPressed: () {
                _simpleScoreBarController.finishTimer();
              },
            ),
            const Gap(36),
            if (_simpleScoreBarController.numberOfPlayers == 2)
              FittedBox(child: _twoTeamScoreBar()),
            if (_simpleScoreBarController.numberOfPlayers == 3)
              FittedBox(child: _threeTeamScoreBar()),
            if (_simpleScoreBarController.numberOfPlayers == 4)
              FittedBox(child: _forthTeamScore()),
          ],
        ),
      ),
    );
  }

  Widget _twoTeamScoreBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _horizontalScoreWidget(
            AppColors.accentPrimary1,
            false,
            _simpleScoreBarController.nameTeam1.value,
            1,
            _simpleScoreBarController.scoreTeam1),
        Gap(MediaQuery.of(context).size.height / 10),
        _controllerWidget(),
        Gap(MediaQuery.of(context).size.height / 10),
        _horizontalScoreWidget(
            AppColors.accentPrimary1,
            true,
            _simpleScoreBarController.nameTeam2.value,
            2,
            _simpleScoreBarController.scoreTeam2),
      ],
    );
  }

  Widget _threeTeamScoreBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _horizontalScoreWidget(
            AppColors.accentPrimary1,
            false,
            _simpleScoreBarController.nameTeam1.value,
            1,
            _simpleScoreBarController.scoreTeam1),
        _controllerWidget(),
        const Gap(24),
        _horizontalScoreWidget(
            AppColors.accentPrimary1,
            false,
            _simpleScoreBarController.nameTeam2.value,
            2,
            _simpleScoreBarController.scoreTeam2),
        _horizontalScoreWidget(
            AppColors.tertiaryGreen,
            false,
            _simpleScoreBarController.nameTeam3.value,
            3,
            _simpleScoreBarController.scoreTeam3),
      ],
    );
  }

  Widget _forthTeamScore() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _verticalScoreWidget(
                  AppColors.accentPrimary1,
                  _simpleScoreBarController.nameTeam1.value,
                  1,
                  _simpleScoreBarController.scoreTeam1),
              const Gap(16),
              _verticalScoreWidget(
                  AppColors.accentSecondary1,
                  _simpleScoreBarController.nameTeam2.value,
                  2,
                  _simpleScoreBarController.scoreTeam2),
            ],
          ),
        ),
        const Gap(36),
        _controllerWidget(),
        const Gap(36),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _verticalScoreWidget(
                  AppColors.tertiaryGreen,
                  _simpleScoreBarController.nameTeam3.value,
                  3,
                  _simpleScoreBarController.scoreTeam3),
              const Gap(16),
              _verticalScoreWidget(
                  AppColors.tertiaryWhite,
                  _simpleScoreBarController.nameTeam4.value,
                  4,
                  _simpleScoreBarController.scoreTeam4),
            ],
          ),
        ),
      ],
    );
  }

  Widget _controllerWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 28),
      decoration: BoxDecoration(
        color: AppColors.layer1,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFDADEE7).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppIconButton(
            assetName: _simpleScoreBarController.timerState == 1
                ? AppIcons.icPause
                : AppIcons.icPlay,
            onPressed: () {
              if (_simpleScoreBarController.timerState == 1) {
                _simpleScoreBarController.pauseTimer();
              } else {
                _simpleScoreBarController.startTimer();
              }
            },
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 27),
            decoration: BoxDecoration(
              color: AppColors.layer2,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: FittedBox(
                child: AppText(
                  text:
                      '${((_simpleScoreBarController.timeOfMatch - _simpleScoreBarController.currentTime) ~/ 60).toString().padLeft(2, '0')}:${((_simpleScoreBarController.timeOfMatch - _simpleScoreBarController.currentTime) % 60).toInt().toString().padLeft(2, '0')}',
                  style: AppTextStyles.specialNumber,
                ),
              ),
            ),
          ),
          AppIconButton(
            assetName: AppIcons.icEdit,
            onPressed: () {
              AppNavigator.goToEditSimpleScoreBarScreen(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _verticalScoreWidget(
    Color bgColor,
    String nameTeam,
    int numberOfTeam,
    int score,
  ) {
    return Flexible(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Column(
              children: [
                AppBgIconButton(
                  assetName: AppIcons.icPlus,
                  activeBgColor: bgColor,
                  inactiveBgColor: AppColors.layer3,
                  pressedBgColor: _getPressedColor(bgColor),
                  activeChildColor: Colors.white,
                  inactiveChildColor: Colors.white,
                  pressedChildColor: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  onPressed: _simpleScoreBarController.timerState == 1
                      ? () {
                          _simpleScoreBarController
                              .incrementScore(numberOfTeam);
                        }
                      : null,
                ),
                SizedBox(
                  height: 120,
                  child: FittedBox(
                    child: AppText(
                      text: '$score',
                      style: AppTextStyles.number2,
                    ),
                  ),
                ),
                AppBgIconButton(
                  assetName: AppIcons.icMinus,
                  activeBgColor: bgColor,
                  inactiveBgColor: AppColors.layer3,
                  pressedBgColor: _getPressedColor(bgColor),
                  activeChildColor: Colors.white,
                  inactiveChildColor: Colors.white,
                  pressedChildColor: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  onPressed: _simpleScoreBarController.timerState == 1
                      ? () {
                          _simpleScoreBarController
                              .decrementScore(numberOfTeam);
                        }
                      : null,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: AppText(
                text: nameTeam,
                style: AppTextStyles.bodySemibold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _horizontalScoreWidget(Color bgColor, bool isSecond, String nameTeam,
      int numberOfTeam, int score) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        children: [
          if (!isSecond)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: AppText(
                text: nameTeam,
                style: AppTextStyles.bodySemibold,
              ),
            ),
          SizedBox(
            height: 160,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppBgIconButton(
                  assetName: AppIcons.icMinus,
                  activeBgColor: bgColor,
                  inactiveBgColor: AppColors.layer3,
                  pressedBgColor: _getPressedColor(bgColor),
                  activeChildColor: Colors.white,
                  inactiveChildColor: Colors.white,
                  pressedChildColor: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  onPressed: _simpleScoreBarController.timerState == 1
                      ? () {
                          _simpleScoreBarController
                              .decrementScore(numberOfTeam);
                        }
                      : null,
                ),
                Flexible(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 64),
                      child: FittedBox(
                        child: AppText(
                          text: '$score',
                          style: AppTextStyles.number1,
                        ),
                      ),
                    ),
                  ),
                ),
                AppBgIconButton(
                  assetName: AppIcons.icPlus,
                  activeBgColor: bgColor,
                  inactiveBgColor: AppColors.layer3,
                  pressedBgColor: _getPressedColor(bgColor),
                  activeChildColor: Colors.white,
                  inactiveChildColor: Colors.white,
                  pressedChildColor: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  onPressed: _simpleScoreBarController.timerState == 1
                      ? () {
                          _simpleScoreBarController
                              .incrementScore(numberOfTeam);
                        }
                      : null,
                ),
              ],
            ),
          ),
          if (isSecond)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: AppText(
                text: nameTeam,
                style: AppTextStyles.bodySemibold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }

  Color _getPressedColor(Color bgColor) {
    switch (bgColor) {
      case AppColors.accentPrimary1:
        return AppColors.accentPrimary2;
      case AppColors.accentSecondary1:
        return AppColors.accentSecondary2;
      case AppColors.tertiaryWhite:
        return AppColors.tertiaryWhite2;
      default:
        return AppColors.tertiaryGreen2;
    }
  }
}
