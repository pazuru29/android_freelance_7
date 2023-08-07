import 'package:android_freelance_7/controllers/create_simple_score_bar_controller.dart';
import 'package:android_freelance_7/controllers/sport_controllers/sport_create_controller.dart';
import 'package:android_freelance_7/controllers/sport_controllers/sport_game_controller.dart';
import 'package:android_freelance_7/ui/components/app_bar/secondary_app_bar.dart';
import 'package:android_freelance_7/ui/components/app_button.dart';
import 'package:android_freelance_7/ui/components/app_text.dart';
import 'package:android_freelance_7/ui/components/app_text_field.dart';
import 'package:android_freelance_7/ui/components/base_screen.dart';
import 'package:android_freelance_7/ui/components/bottom_sheets/time_picker_bs.dart';
import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:android_freelance_7/utils/app_icons.dart';
import 'package:android_freelance_7/utils/app_strings.dart';
import 'package:android_freelance_7/utils/app_text_style.dart';
import 'package:android_freelance_7/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditSportScreen extends BaseScreen {
  const EditSportScreen({super.key});

  @override
  State<EditSportScreen> createState() => _EditSimpleScoreBarScreenState();
}

class _EditSimpleScoreBarScreenState extends BaseScreenState<EditSportScreen> {
  late final SportCreateController _sportCreateController;

  @override
  void initState() {
    _sportCreateController = Get.put(SportCreateController());
    _sportCreateController.getEditData();
    super.initState();
  }

  bool isButtonActive = false;

  @override
  Widget buildMain(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SecondaryAppBar(
              title: AppStrings.editScoreboard,
            ),
            Expanded(
              child: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const Gap(16),
                        _getPickerWidget(),
                        _getTeamName(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AppButton(
              title: AppStrings.btnContinue,
              onPressed: isButtonActive
                  ? () {
                      _sportCreateController.saveEditData(context);
                    }
                  : null,
            ),
            Gap(MediaQuery.of(context).padding.bottom + 16),
          ],
        ),
      ),
    );
  }

  Widget _getTeamName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(20),
        const AppText(
          text: AppStrings.additionalInformation,
          style: AppTextStyles.captionRegular,
          color: AppColors.textSecondary1,
        ),
        const Gap(14),
        Container(
          decoration: BoxDecoration(
            color: AppColors.layer1,
            borderRadius: BorderRadius.circular(100),
          ),
          child: AppTextField(
            controller: _sportCreateController.name1Controller.value,
            focusNode: _sportCreateController.name1Focus.value,
            hintText: AppStrings.hintTeam1,
            onChanged: (text) {
              _checkOnActiveButton();
            },
          ),
        ),
        const Gap(12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.layer1,
            borderRadius: BorderRadius.circular(100),
          ),
          child: AppTextField(
            controller: _sportCreateController.name2Controller.value,
            focusNode: _sportCreateController.name2Focus.value,
            hintText: AppStrings.hintTeam2,
            onChanged: (text) {
              _checkOnActiveButton();
            },
          ),
        ),
      ],
    );
  }

  Widget _getPickerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          text: AppStrings.requiredInformation,
          style: AppTextStyles.captionRegular,
          color: AppColors.textSecondary1,
        ),
        const Gap(14),
        GestureDetector(
          onTap: _sportCreateController.timerState == 0
              ? () {
                  _showTimePickerDialog();
                }
              : null,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.layer1,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(23, 15, 14, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: AppStrings.time,
                    style: AppTextStyles.bodyRegular,
                    color: _sportCreateController.timerState == 0
                        ? AppColors.textPrimary
                        : AppColors.textSecondary1,
                  ),
                  Row(
                    children: [
                      AppText(
                        text:
                            '${(_sportCreateController.timeOfMatch ~/ 60).toString().padLeft(2, '0')}:${(_sportCreateController.timeOfMatch % 60).toInt().toString().padLeft(2, '0')}',
                        style: AppTextStyles.bodyRegular,
                        color: _sportCreateController.timerState == 0
                            ? AppColors.textPrimary
                            : AppColors.textSecondary1,
                      ),
                      const Gap(8),
                      SvgPicture.asset(
                        AppIcons.icSelected,
                        color: _sportCreateController.timerState == 0
                            ? AppColors.textPrimary
                            : AppColors.textSecondary1,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showTimePickerDialog() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => TimePickerBs(
        initTime: _sportCreateController.timeOfMatch,
        onApplyPressed: (value) {
          _sportCreateController.timeOfMatch = value;
          _checkOnActiveButton();
        },
      ),
    );
  }

  void _checkOnActiveButton() async {
    await SharedPreferences.getInstance().then((value) {
      int tmpTime = value.getInt(kSportMainTimerTime) ?? 0;
      int tmpSecondTime = value.getInt(kSportSecondTimerTime) ?? 0;
      String tmpTeam1 = value.getString(kSportNameTeam1) ?? AppStrings.team1;
      String tmpTeam2 = value.getString(kSportNameTeam2) ?? AppStrings.team2;
      setState(() {
        isButtonActive = _sportCreateController.timeOfMatch > 0 &&
            ((tmpTime + tmpSecondTime) != _sportCreateController.timeOfMatch ||
                _sportCreateController.name1Controller.value.text != tmpTeam1 ||
                _sportCreateController.name2Controller.value.text != tmpTeam2);
      });
    });
  }
}
