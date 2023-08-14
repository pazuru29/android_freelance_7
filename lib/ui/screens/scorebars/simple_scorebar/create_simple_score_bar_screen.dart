import 'package:android_freelance_7/controllers/create_simple_score_bar_controller.dart';
import 'package:android_freelance_7/ui/components/app_bar/secondary_app_bar.dart';
import 'package:android_freelance_7/ui/components/app_button.dart';
import 'package:android_freelance_7/ui/components/app_text.dart';
import 'package:android_freelance_7/ui/components/app_text_field.dart';
import 'package:android_freelance_7/ui/components/base_screen.dart';
import 'package:android_freelance_7/ui/components/bottom_sheets/number_of_players_picker.dart';
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

class CreateSimpleScoreBarScreen extends BaseScreen {
  const CreateSimpleScoreBarScreen({super.key});

  @override
  State<CreateSimpleScoreBarScreen> createState() =>
      _CreateSimpleScoreBarScreenState();
}

class _CreateSimpleScoreBarScreenState
    extends BaseScreenState<CreateSimpleScoreBarScreen> {
  late final CreateSimpleScoreBarController _createSimpleScoreBarController;

  @override
  void initState() {
    _createSimpleScoreBarController = Get.put(CreateSimpleScoreBarController());
    _createSimpleScoreBarController.onInit();
    super.initState();
  }

  @override
  Widget buildMain(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SecondaryAppBar(
              title: AppStrings.newScoreboard,
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
                        const Gap(16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AppButton(
              title: AppStrings.btnContinue,
              onPressed: _createSimpleScoreBarController.timeOfMatch > 0
                  ? () {
                      _createSimpleScoreBarController.saveData(context);
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
            onChanged: (text) {},
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
            onChanged: (text) {},
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
              onChanged: (text) {},
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
              onChanged: (text) {},
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
          onTap: () {
            _showNumberOfPlayersPickerDialog();
          },
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
                  const AppText(
                      text: AppStrings.numberOfPlayers,
                      style: AppTextStyles.bodyRegular),
                  Row(
                    children: [
                      AppText(
                        text:
                            '${_createSimpleScoreBarController.numberOfPlayers}',
                        style: AppTextStyles.bodyRegular,
                      ),
                      const Gap(16),
                      SvgPicture.asset(
                        AppIcons.icSelected,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const Gap(12),
        GestureDetector(
          onTap: () {
            _showTimePickerDialog();
          },
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
                  const AppText(
                      text: AppStrings.time, style: AppTextStyles.bodyRegular),
                  Row(
                    children: [
                      AppText(
                        text:
                            '${(_createSimpleScoreBarController.timeOfMatch ~/ 60).toString().padLeft(2, '0')}:${(_createSimpleScoreBarController.timeOfMatch % 60).toInt().toString().padLeft(2, '0')}',
                        style: AppTextStyles.bodyRegular,
                      ),
                      const Gap(8),
                      SvgPicture.asset(
                        AppIcons.icSelected,
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
        },
      ),
    );
  }

  void _showNumberOfPlayersPickerDialog() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => NumberOfPlayersPicker(
        initValue: _createSimpleScoreBarController.numberOfPlayers,
        onApply: (value) {
          _createSimpleScoreBarController.numberOfPlayers = value;
        },
      ),
    );
  }
}
