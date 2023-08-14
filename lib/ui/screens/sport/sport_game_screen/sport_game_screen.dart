import 'package:android_freelance_7/controllers/app_navigator.dart';
import 'package:android_freelance_7/controllers/sport_controllers/sport_game_controller.dart';
import 'package:android_freelance_7/ui/components/app_bar/game_app_bar.dart';
import 'package:android_freelance_7/ui/components/app_bg_icon_button.dart';
import 'package:android_freelance_7/ui/components/app_icon_button.dart';
import 'package:android_freelance_7/ui/components/app_text.dart';
import 'package:android_freelance_7/ui/components/app_text_button.dart';
import 'package:android_freelance_7/ui/components/base_screen.dart';
import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:android_freelance_7/utils/app_icons.dart';
import 'package:android_freelance_7/utils/app_text_style.dart';
import 'package:android_freelance_7/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SportGameScreen extends BaseScreen {
  const SportGameScreen({super.key});

  @override
  State<SportGameScreen> createState() => _SportGameScreenState();
}

class _SportGameScreenState extends BaseScreenState<SportGameScreen> {
  final SportGameController _sportGameController =
      Get.put(SportGameController());

  @override
  void initState() {
    _sportGameController.currentContext = context;
    _sportGameController.getData();
    super.initState();
  }

  @override
  void dispose() {
    _sportGameController.currentContext = null;
    super.dispose();
  }

  @override
  Widget buildMain(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Gap(MediaQuery.of(context).padding.top),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: GameAppBar(
              onFinishPressed: () {
                _sportGameController.finishTimer();
              },
            ),
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: _body(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: Column(
                children: [
                  const Gap(8),
                  if (_sportGameController.sportType == 7)
                    Expanded(
                      child: _chessTimerWidget(
                        '${((_sportGameController.mainTimeOfMatch - _sportGameController.currentTime) ~/ 60).toString().padLeft(2, '0')}:${((_sportGameController.mainTimeOfMatch - _sportGameController.currentTime) % 60).toInt().toString().padLeft(2, '0')}',
                        AppColors.accentPrimary1,
                        _sportGameController.timerState == 1,
                        1,
                      ),
                    ),
                  if (_sportGameController.sportType != 7)
                    Expanded(
                      child: FittedBox(
                        child: _horizontalScoreWidget(
                            AppColors.accentPrimary1,
                            false,
                            _sportGameController.nameTeam1.value,
                            1,
                            _sportGameController.scoreTeam1),
                      ),
                    ),
                  if (_sportGameController.sportType == 2 ||
                      _sportGameController.sportType == 3)
                    _addMoreScoreWidget(AppColors.accentPrimary1,
                        _sportGameController.sportType == 3, 1),
                  const Gap(16),
                  _controllerWidget(),
                  const Gap(16),
                  if (_sportGameController.sportType == 2 ||
                      _sportGameController.sportType == 3)
                    _addMoreScoreWidget(AppColors.accentSecondary1,
                        _sportGameController.sportType == 3, 2),
                  if (_sportGameController.sportType == 7)
                    Expanded(
                      child: _chessTimerWidget(
                        '${((_sportGameController.secondTimeOfMatch - _sportGameController.secondCurrentTime) ~/ 60).toString().padLeft(2, '0')}:${((_sportGameController.secondTimeOfMatch - _sportGameController.secondCurrentTime) % 60).toInt().toString().padLeft(2, '0')}',
                        AppColors.accentSecondary1,
                        _sportGameController.secondTimerState == 1,
                        2,
                      ),
                    ),
                  if (_sportGameController.sportType != 7)
                    Expanded(
                      child: FittedBox(
                        child: _horizontalScoreWidget(
                            AppColors.accentSecondary1,
                            true,
                            _sportGameController.nameTeam2.value,
                            2,
                            _sportGameController.scoreTeam2),
                      ),
                    ),
                  const Gap(8),
                ],
              ),
            ),
          ),
        ),
        if (_sportGameController.sportType != 1 &&
            _sportGameController.sportType != 2)
          Gap(MediaQuery.of(context).padding.bottom + 48),
        if (_sportGameController.sportType == 1 ||
            _sportGameController.sportType == 2)
          _foulsWidget(),
      ],
    );
  }

  Widget _addMoreScoreWidget(
      Color textColor, bool isFootball, int numberOfTeam) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        _moreScore('+1', textColor, numberOfTeam, 1),
        const Spacer(),
        _moreScore('+2', textColor, numberOfTeam, 2),
        const Spacer(),
        _moreScore('+3', textColor, numberOfTeam, 3),
        if (isFootball) const Spacer(),
        if (isFootball) _moreScore('+6', textColor, numberOfTeam, 6),
        const Spacer(),
      ],
    );
  }

  Widget _moreScore(String text, Color textColor, int numberOfTeam, count) {
    return AppTextButton(
      text: text,
      activeBgColor: AppColors.layer1,
      inactiveBgColor: AppColors.layer1,
      pressedBgColor: AppColors.layer2,
      activeChildColor: textColor,
      inactiveChildColor: AppColors.layer3,
      pressedChildColor: _getPressedColor(textColor),
      borderRadius: BorderRadius.circular(100),
      onPressed: _sportGameController.timerState == 1
          ? () {
              _sportGameController.incrementScore(count, numberOfTeam);
            }
          : null,
    );
  }

  Widget _controllerWidget() {
    if (_sportGameController.sportType == 7) {
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
          children: [
            AppIconButton(
              assetName: _sportGameController.timerState == 1 ||
                      _sportGameController.secondTimerState == 1
                  ? AppIcons.icPause
                  : AppIcons.icPlay,
              onPressed: () {
                if (_sportGameController.timerState == 1 ||
                    _sportGameController.secondTimerState == 1) {
                  _sportGameController.pauseTimer();
                } else {
                  _sportGameController.startTimer();
                }
              },
            ),
            const Gap(34),
            Flexible(
              child: Container(
                height: 60,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 27),
                decoration: BoxDecoration(
                  color: AppColors.layer2,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: AppText(
                        text:
                            '${_sportGameController.scoreTeam1} - ${_sportGameController.scoreTeam2}',
                        style: AppTextStyles.specialNumber,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    if (_sportGameController.sportType == 6) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppText(
                  text: 'Games',
                  style: AppTextStyles.bold2,
                ),
                Row(
                  children: [
                    AppText(
                      text: '${_sportGameController.gameTeam1}',
                      style: AppTextStyles.bodyRegular,
                    ),
                    const Gap(40),
                    AppText(
                      text: '${_sportGameController.gameTeam2}',
                      style: AppTextStyles.bodyRegular,
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 1,
              color: AppColors.layer2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppText(
                  text: 'Sets',
                  style: AppTextStyles.bold2,
                ),
                Row(
                  children: [
                    AppText(
                      text: '${_sportGameController.setsTeam1}',
                      style: AppTextStyles.bodyRegular,
                    ),
                    const Gap(40),
                    AppText(
                      text: '${_sportGameController.setsTeam2}',
                      style: AppTextStyles.bodyRegular,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }
    if (_sportGameController.sportType == 4) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 32),
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
            Expanded(
              child: FittedBox(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.layer2,
                  ),
                  child: const AppText(
                    text: '1',
                    style: AppTextStyles.headerSemibold,
                  ),
                ),
              ),
            ),
            const Gap(16),
            const AppText(
              text: 'vs.',
              style: AppTextStyles.headerSemibold,
            ),
            const Gap(16),
            Expanded(
              child: FittedBox(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.layer2,
                  ),
                  child: const AppText(
                    text: '2',
                    style: AppTextStyles.headerSemibold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
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
            assetName: _sportGameController.timerState == 1
                ? AppIcons.icPause
                : AppIcons.icPlay,
            onPressed: () {
              if (_sportGameController.timerState == 1) {
                _sportGameController.pauseTimer();
              } else {
                _sportGameController.startTimer();
              }
            },
          ),
          const Gap(8),
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
                      '${((_sportGameController.mainTimeOfMatch - _sportGameController.currentTime) ~/ 60).toString().padLeft(2, '0')}:${((_sportGameController.mainTimeOfMatch - _sportGameController.currentTime) % 60).toInt().toString().padLeft(2, '0')}',
                  style: AppTextStyles.specialNumber,
                ),
              ),
            ),
          ),
          const Gap(8),
          AppIconButton(
            assetName: AppIcons.icEdit,
            onPressed: () {
              AppNavigator.goToEditSportScreen(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _foulsWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 55),
      color: AppColors.layer1,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  AppIconButton(
                    assetName: AppIcons.icCard,
                    color: AppColors.accentPrimary1,
                    pressedColor: AppColors.accentPrimary2,
                    onPressed: _sportGameController.timerState == 1
                        ? () {
                            _sportGameController.incrementFouls(1);
                          }
                        : null,
                  ),
                  const Gap(10),
                  SizedBox(
                    width: 36,
                    child: Center(
                      child: FittedBox(
                        child: AppText(
                          text: '${_sportGameController.foulsTeam1}',
                          style: AppTextStyles.bodySemibold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  AppIconButton(
                    assetName: AppIcons.icCard,
                    color: AppColors.accentSecondary1,
                    pressedColor: AppColors.accentSecondary2,
                    onPressed: _sportGameController.timerState == 1
                        ? () {
                            _sportGameController.incrementFouls(2);
                          }
                        : null,
                  ),
                  const Gap(10),
                  SizedBox(
                    width: 36,
                    child: Center(
                      child: FittedBox(
                        child: AppText(
                          text: '${_sportGameController.foulsTeam2}',
                          style: AppTextStyles.bodySemibold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Gap(MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _chessTimerWidget(
      String time, Color bgColor, bool isPressedActive, int numberOfTeam) {
    return Column(
      children: [
        SizedBox(
          height: 110,
          child: FittedBox(
            child: AppText(
              text: time,
              style: AppTextStyles.number1,
            ),
          ),
        ),
        const Gap(22),
        AppBgIconButton(
          assetName: AppIcons.icPlus,
          activeBgColor: bgColor,
          inactiveBgColor: AppColors.layer3,
          pressedBgColor: _getPressedColor(bgColor),
          activeChildColor: Colors.white,
          inactiveChildColor: Colors.white,
          pressedChildColor: Colors.white,
          borderRadius: BorderRadius.circular(100),
          onPressed: isPressedActive
              ? () {
                  _sportGameController.incrementChessScore(numberOfTeam);
                }
              : null,
        ),
      ],
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
                  onPressed: (_sportGameController.timerState == 1 ||
                              _sportGameController.sportType == 4 ||
                              _sportGameController.sportType == 6) &&
                          ((numberOfTeam == 1 &&
                                  _sportGameController.scoreTeam1 > 0) ||
                              (numberOfTeam == 2 &&
                                  _sportGameController.scoreTeam2 > 0))
                      ? () {
                          if (_sportGameController.sportType == 6) {
                            _sportGameController
                                .decrementTennisScore(numberOfTeam);
                          } else {
                            _sportGameController.decrementScore(
                                1, numberOfTeam);
                          }
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
                  onPressed: _sportGameController.timerState == 1 ||
                          _sportGameController.sportType == 4 ||
                          _sportGameController.sportType == 6
                      ? () {
                          if (_sportGameController.sportType == 6) {
                            _sportGameController
                                .incrementTennisScore(numberOfTeam);
                          } else {
                            _sportGameController.incrementScore(
                                1, numberOfTeam);
                          }
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
      default:
        return AppColors.accentSecondary2;
    }
  }

  @override
  bool needSafeArea() {
    return false;
  }
}
