import 'package:android_freelance_7/controllers/app_navigator.dart';
import 'package:android_freelance_7/ui/components/app_bg_icon_button.dart';
import 'package:android_freelance_7/ui/components/app_button.dart';
import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:android_freelance_7/utils/app_icons.dart';
import 'package:android_freelance_7/utils/app_strings.dart';
import 'package:flutter/material.dart';

class GameAppBar extends StatelessWidget {
  final VoidCallback onFinishPressed;

  const GameAppBar({
    required this.onFinishPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppBgIconButton(
            assetName: AppIcons.icArrowBack,
            activeBgColor: AppColors.layer1,
            pressedBgColor: AppColors.layer2,
            inactiveBgColor: AppColors.layer1,
            activeChildColor: AppColors.textPrimary,
            pressedChildColor: AppColors.textSecondary1,
            inactiveChildColor: AppColors.textSecondary2,
            borderRadius: BorderRadius.circular(10),
            onPressed: () {
              AppNavigator.goBack(context);
            },
          ),
          AppButton.outlined(
            title: AppStrings.btnFinish,
            onPressed: onFinishPressed,
          ),
        ],
      ),
    );
  }
}
