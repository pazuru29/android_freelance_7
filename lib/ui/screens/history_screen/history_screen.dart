import 'package:android_freelance_7/controllers/history_controller.dart';
import 'package:android_freelance_7/ui/components/app_bar/secondary_app_bar.dart';
import 'package:android_freelance_7/ui/components/app_text.dart';
import 'package:android_freelance_7/ui/components/base_screen.dart';
import 'package:android_freelance_7/ui/screens/history_screen/widgets/history_card.dart';
import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:android_freelance_7/utils/app_strings.dart';
import 'package:android_freelance_7/utils/app_text_style.dart';
import 'package:android_freelance_7/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HistoryScreen extends BaseScreen {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends BaseScreenState<HistoryScreen> {
  late final HistoryController _historyController;

  @override
  void initState() {
    _historyController = Get.put(HistoryController());
    _historyController.getData();
    super.initState();
  }

  @override
  Widget buildMain(BuildContext context) {
    return Obx(
      () => Column(
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
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: FittedBox(
                          child: AppText(
                            text: AppStrings.type,
                            style: AppTextStyles.captionMedium,
                            color: AppColors.textSecondary1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: FittedBox(
                          child: AppText(
                            text: AppStrings.time,
                            style: AppTextStyles.captionMedium,
                            color: AppColors.textSecondary1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: FittedBox(
                          child: AppText(
                            text: AppStrings.homeAwayScore,
                            style: AppTextStyles.captionMedium,
                            color: AppColors.textSecondary1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_historyController.listOfHistory.isNotEmpty)
            Expanded(
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: _historyController.listOfHistory.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    if (index == 0) const Gap(20),
                    if (index != 0)
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: kHorizontalPadding),
                        height: 1,
                        color: AppColors.layer2,
                      ),
                    HistoryCard(
                      historyModel: _historyController.listOfHistory[index],
                    ),
                    if (index == _historyController.listOfHistory.length - 1)
                      Gap(MediaQuery.of(context).padding.bottom + 16),
                  ],
                ),
              ),
            ),
          if (_historyController.listOfHistory.isEmpty)
            const Expanded(
              child: Center(
                child: AppText(
                  text: 'The matches have not been\nplayed yet',
                  style: AppTextStyles.bodyRegular,
                  color: AppColors.textSecondary1,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
