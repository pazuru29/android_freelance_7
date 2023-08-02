import 'package:android_freelance_7/controllers/app_navigator.dart';
import 'package:android_freelance_7/ui/components/app_bg_icon_button.dart';
import 'package:android_freelance_7/ui/components/app_icon_button.dart';
import 'package:android_freelance_7/ui/components/app_text.dart';
import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:android_freelance_7/utils/app_icons.dart';
import 'package:android_freelance_7/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SecondaryAppBar extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SecondaryAppBar({
    required this.title,
    this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
            ],
          ),
          const Gap(24),
          FittedBox(
            child: AppText(
              text: title,
              style: AppTextStyles.headerSemibold,
            ),
          ),
          if (subtitle != null) const Gap(16),
          if (subtitle != null)
            FittedBox(
              child: AppText(
                text: subtitle!,
                style: AppTextStyles.headerRegular,
                color: AppColors.textSecondary1,
              ),
            ),
        ],
      ),
    );
  }
}
