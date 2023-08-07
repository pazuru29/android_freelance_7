import 'package:android_freelance_7/controllers/create_simple_score_bar_controller.dart';
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

class EditSimpleScoreBarScreen extends BaseScreen {
  const EditSimpleScoreBarScreen({super.key});

  @override
  State<EditSimpleScoreBarScreen> createState() =>
      _EditSimpleScoreBarScreenState();
}

class _EditSimpleScoreBarScreenState
    extends BaseScreenState<EditSimpleScoreBarScreen> {
  late final CreateSimpleScoreBarController _createSimpleScoreBarController;

  @override
  void initState() {
    _createSimpleScoreBarController = Get.put(CreateSimpleScoreBarController());
    _createSimpleScoreBarController.getEditData();
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
                      _createSimpleScoreBarController.saveEditData(context);
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
            controller: _createSimpleScoreBarController.name1Controller.value,
            focusNode: _createSimpleScoreBarController.name1Focus.value,
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
            controller: _createSimpleScoreBarController.name2Controller.value,
            focusNode: _createSimpleScoreBarController.name2Focus.value,
            hintText: AppStrings.hintTeam2,
            onChanged: (text) {
              _checkOnActiveButton();
            },
          ),
        ),
        if (_createSimpleScoreBarController.numberOfPlayers > 2) const Gap(12),
        if (_createSimpleScoreBarController.numberOfPlayers > 2)
          Container(
            decoration: BoxDecoration(
              color: AppColors.layer1,
              borderRadius: BorderRadius.circular(100),
            ),
            child: AppTextField(
              controller: _createSimpleScoreBarController.name3Controller.value,
              focusNode: _createSimpleScoreBarController.name3Focus.value,
              hintText: AppStrings.hintTeam3,
              onChanged: (text) {
                _checkOnActiveButton();
              },
            ),
          ),
        if (_createSimpleScoreBarController.numberOfPlayers > 3) const Gap(12),
        if (_createSimpleScoreBarController.numberOfPlayers > 3)
          Container(
            decoration: BoxDecoration(
              color: AppColors.layer1,
              borderRadius: BorderRadius.circular(100),
            ),
            child: AppTextField(
              controller: _createSimpleScoreBarController.name4Controller.value,
              focusNode: _createSimpleScoreBarController.name4Focus.value,
              hintText: AppStrings.hintTeam4,
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
          onTap: _createSimpleScoreBarController.timerState == 0
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
                    color: _createSimpleScoreBarController.timerState == 0
                        ? AppColors.textPrimary
                        : AppColors.textSecondary1,
                  ),
                  Row(
                    children: [
                      AppText(
                        text:
                            '${(_createSimpleScoreBarController.timeOfMatch ~/ 60).toString().padLeft(2, '0')}:${(_createSimpleScoreBarController.timeOfMatch % 60).toInt().toString().padLeft(2, '0')}',
                        style: AppTextStyles.bodyRegular,
                        color: _createSimpleScoreBarController.timerState == 0
                            ? AppColors.textPrimary
                            : AppColors.textSecondary1,
                      ),
                      const Gap(8),
                      SvgPicture.asset(
                        AppIcons.icSelected,
                        color: _createSimpleScoreBarController.timerState == 0
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
        initTime: _createSimpleScoreBarController.timeOfMatch,
        onApplyPressed: (value) {
          _createSimpleScoreBarController.timeOfMatch = value;
          _checkOnActiveButton();
        },
      ),
    );
  }

  void _checkOnActiveButton() async {
    await SharedPreferences.getInstance().then((value) {
      int tmpTime = value.getInt(kSimpleScoreBarTime) ?? 0;
      String tmpTeam1 =
          value.getString(kSimpleScoreBarNameTeam1) ?? AppStrings.team1;
      String tmpTeam2 =
          value.getString(kSimpleScoreBarNameTeam2) ?? AppStrings.team2;
      String tmpTeam3 =
          value.getString(kSimpleScoreBarNameTeam3) ?? AppStrings.team3;
      String tmpTeam4 =
          value.getString(kSimpleScoreBarNameTeam4) ?? AppStrings.team4;
      setState(() {
        isButtonActive = _createSimpleScoreBarController.timeOfMatch > 0 &&
            (tmpTime != _createSimpleScoreBarController.timeOfMatch ||
                _createSimpleScoreBarController.name1Controller.value.text !=
                    tmpTeam1 ||
                _createSimpleScoreBarController.name2Controller.value.text !=
                    tmpTeam2 ||
                _createSimpleScoreBarController.name3Controller.value.text !=
                    tmpTeam3 ||
                _createSimpleScoreBarController.name4Controller.value.text !=
                    tmpTeam4);
      });
    });
  }
}
