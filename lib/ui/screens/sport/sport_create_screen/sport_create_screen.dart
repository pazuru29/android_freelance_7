import 'package:android_freelance_7/controllers/sport_controllers/sport_create_controller.dart';
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

class SportCreateScreen extends BaseScreen {
  const SportCreateScreen({super.key});

  @override
  State<SportCreateScreen> createState() => _SportCreateScreenState();
}

class _SportCreateScreenState extends BaseScreenState<SportCreateScreen> {
  final SportCreateController _sportCreateController = Get.find();

  @override
  void initState() {
    _sportCreateController.getData();
    super.initState();
  }

  @override
  Widget buildMain(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          children: [
            SecondaryAppBar(
              title: _getTitle(_sportCreateController.sportType),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        if (_sportCreateController.sportType != 4 &&
                            _sportCreateController.sportType != 6)
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
              onPressed: _sportCreateController.timeOfMatch > 0 ||
                      _sportCreateController.sportType == 4 ||
                      _sportCreateController.sportType == 6
                  ? () {
                      _sportCreateController.saveData(context);
                    }
                  : null,
            ),
            const Gap(16),
          ],
        ),
      ),
    );
  }

  String _getTitle(int sportType) {
    switch (sportType) {
      case 1:
        return AppStrings.soccer;
      case 2:
        return AppStrings.basketball;
      case 3:
        return AppStrings.football;
      case 4:
        return AppStrings.volleyball;
      case 5:
        return AppStrings.hockey;
      case 6:
        return AppStrings.tennis;
      case 7:
        return AppStrings.chess;
      default:
        return AppStrings.handball;
    }
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
                            '${(_sportCreateController.timeOfMatch ~/ 60).toString().padLeft(2, '0')}:${(_sportCreateController.timeOfMatch % 60).toInt().toString().padLeft(2, '0')}',
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
            controller: _sportCreateController.name2Controller.value,
            focusNode: _sportCreateController.name2Focus.value,
            hintText: AppStrings.hintTeam2,
            onChanged: (text) {},
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
        },
      ),
    );
  }
}
