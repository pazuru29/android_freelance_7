import 'package:android_freelance_7/ui/components/app_bar/secondary_app_bar.dart';
import 'package:android_freelance_7/ui/components/app_text.dart';
import 'package:android_freelance_7/ui/components/base_screen.dart';
import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:android_freelance_7/utils/app_strings.dart';
import 'package:android_freelance_7/utils/app_text_style.dart';
import 'package:android_freelance_7/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HistoryScreen extends BaseScreen {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends BaseScreenState<HistoryScreen> {
  @override
  Widget buildMain(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: SecondaryAppBar(
            title: AppStrings.history,
            subtitle: AppStrings.historySubtitle,
          ),
        ),
        const Gap(32),
        Container(
          color: const Color(0xFFE3EAF1),
          padding: const EdgeInsets.symmetric(
              horizontal: kHorizontalPadding, vertical: 6),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: AppStrings.type,
                style: AppTextStyles.captionMedium,
                color: AppColors.textSecondary1,
              ),
              AppText(
                text: AppStrings.time,
                style: AppTextStyles.captionMedium,
                color: AppColors.textSecondary1,
              ),
              AppText(
                text: AppStrings.homeAwayScore,
                style: AppTextStyles.captionMedium,
                color: AppColors.textSecondary1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
