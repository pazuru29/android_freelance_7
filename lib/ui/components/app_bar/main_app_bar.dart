import 'package:android_freelance_7/controllers/app_navigator.dart';
import 'package:android_freelance_7/ui/components/app_icon_button.dart';
import 'package:android_freelance_7/ui/components/app_text.dart';
import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:android_freelance_7/utils/app_icons.dart';
import 'package:android_freelance_7/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MainAppBar extends StatelessWidget {
  final String title, subtitle;

  const MainAppBar({
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 58),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: AppText(
                    text: title,
                    style: AppTextStyles.headerSemibold,
                  ),
                ),
                const Gap(16),
                FittedBox(
                  child: AppText(
                    text: subtitle,
                    style: AppTextStyles.headerRegular,
                    color: AppColors.textSecondary1,
                  ),
                ),
              ],
            ),
          ),
          const Gap(2),
          AppIconButton(
            assetName: AppIcons.icSettings,
            onPressed: () {
              AppNavigator.goToSettingsScreen(context);
            },
          ),
        ],
      ),
    );
  }
}
