import 'package:android_freelance_7/ui/components/app_text.dart';
import 'package:android_freelance_7/ui/components/bottom_sheets/time_picker_bs.dart';
import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:android_freelance_7/utils/app_icons.dart';
import 'package:android_freelance_7/utils/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:measure_size/measure_size.dart';

class ExerciseCard extends StatefulWidget {
  final String title;
  final int time;
  final bool enabledDelete;
  final Color textColor;
  final VoidCallback onDeletePressed;
  final Function(int) onTimeChange;

  const ExerciseCard({
    required this.title,
    required this.time,
    required this.enabledDelete,
    required this.textColor,
    required this.onDeletePressed,
    required this.onTimeChange,
    super.key,
  });

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  double widthOfTimeContainer = 96;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 1,
          right: 0,
          child: Container(
            width: widthOfTimeContainer,
            height: 39,
            decoration: BoxDecoration(
              color: AppColors.accentSecondary1,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        Slidable(
          enabled: widget.enabledDelete,
          endActionPane: ActionPane(
            extentRatio: 0.16,
            motion: const ScrollMotion(),
            children: [
              GestureDetector(
                onTap: () {
                  widget.onDeletePressed();
                  debugPrint('DELETED');
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(AppIcons.icDelete2),
                    ],
                  ),
                ),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(AppIcons.icExercise),
                  const Gap(10),
                  AppText(
                    text: widget.title,
                    style: AppTextStyles.bodyRegular,
                    color: widget.textColor,
                  ),
                ],
              ),
              MeasureSize(
                onChange: (size) {
                  setState(() {
                    widthOfTimeContainer = size.width - 12;
                  });
                },
                child: GestureDetector(
                  onTap: () {
                    _showTimePickerDialog();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.layer1,
                    ),
                    child: Row(
                      children: [
                        AppText(
                          text:
                              '${(widget.time ~/ 60).toString().padLeft(2, '0')}:${(widget.time % 60).toInt().toString().padLeft(2, '0')}',
                          style: AppTextStyles.bodyRegular,
                        ),
                        const Gap(7),
                        SvgPicture.asset(AppIcons.icSelected)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showTimePickerDialog() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => TimePickerBs(
        initTime: widget.time,
        onApplyPressed: (value) {
          widget.onTimeChange(value);
        },
      ),
    );
  }
}
