import 'package:android_freelance_7/data/database/models/history_model.dart';
import 'package:android_freelance_7/ui/components/app_text.dart';
import 'package:android_freelance_7/utils/app_strings.dart';
import 'package:android_freelance_7/utils/app_text_style.dart';
import 'package:android_freelance_7/utils/constants.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final HistoryModel historyModel;

  const HistoryCard({
    required this.historyModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kHorizontalPadding, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                AppText(
                  text: _getTitle(historyModel.sportType),
                  style: AppTextStyles.bodyRegular,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text:
                      '${(historyModel.timeOfMatch ~/ 60).toString().padLeft(2, '0')}:${(historyModel.timeOfMatch % 60).toInt().toString().padLeft(2, '0')}',
                  style: AppTextStyles.bodyRegular,
                ),
              ],
            ),
          ),
          if (historyModel.sportType != 7)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppText(
                    text:
                        '${historyModel.scoreTeam1} - ${historyModel.scoreTeam2}',
                    style: AppTextStyles.bodyRegular,
                  ),
                ],
              ),
            ),
          if (historyModel.sportType == 7)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppText(
                    text:
                        '${historyModel.scoreTeam1 > historyModel.scoreTeam2 ? 'Matt' : ''} ${historyModel.scoreTeam1}',
                    style: historyModel.scoreTeam1 > historyModel.scoreTeam2
                        ? AppTextStyles.bold2
                        : AppTextStyles.bodyRegular,
                  ),
                  const AppText(
                    text: ' - ',
                    style: AppTextStyles.bodyRegular,
                  ),
                  AppText(
                    text:
                        '${historyModel.scoreTeam2} ${historyModel.scoreTeam1 > historyModel.scoreTeam2 ? '' : 'Matt'}',
                    style: historyModel.scoreTeam1 > historyModel.scoreTeam2
                        ? AppTextStyles.bodyRegular
                        : AppTextStyles.bold2,
                  ),
                ],
              ),
            ),
        ],
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
}
