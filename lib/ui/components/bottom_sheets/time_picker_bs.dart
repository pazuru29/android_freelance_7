import 'package:android_freelance_7/controllers/app_navigator.dart';
import 'package:android_freelance_7/ui/components/app_text.dart';
import 'package:android_freelance_7/ui/components/number_picker.dart';
import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:android_freelance_7/utils/app_strings.dart';
import 'package:android_freelance_7/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class TimePickerBs extends StatefulWidget {
  final int initTime;
  final Function(int) onApplyPressed;

  const TimePickerBs({
    required this.initTime,
    required this.onApplyPressed,
    super.key,
  });

  @override
  State<TimePickerBs> createState() => _TimePickerBsState();
}

class _TimePickerBsState extends State<TimePickerBs> {
  late int valueSecond;
  late int valueMinute;

  @override
  void initState() {
    var tmpMin = widget.initTime ~/ 60;
    var tmpSec = (widget.initTime % 60).toInt();
    valueMinute = tmpMin > 120 || tmpMin < 0 ? 0 : tmpMin;
    valueSecond = tmpSec > 59 || tmpSec < 0 ? 0 : tmpSec;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: const BoxDecoration(
        color: AppColors.layer1,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppText(
                    text: AppStrings.time, style: AppTextStyles.bodySemibold),
                GestureDetector(
                  onTap: () {
                    AppNavigator.goBack(context);
                    widget.onApplyPressed((valueMinute * 60) + valueSecond);
                  },
                  child: const AppText(
                    text: AppStrings.btnApply,
                    style: AppTextStyles.bold2,
                    color: AppColors.accentPrimary1,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  height: 44,
                  color: AppColors.layer2,
                ),
              ),
              Flexible(
                child: Center(
                  child: NumberPicker(
                    itemCount: 7,
                    zeroPad: true,
                    haptics: true,
                    infiniteLoop: true,
                    decoration: const BoxDecoration(
                      color: AppColors.layer2,
                    ),
                    minValue: 0,
                    maxValue: 120,
                    value: valueMinute,
                    onChanged: (value) {
                      setState(() {
                        valueMinute = value;
                      });
                    },
                  ),
                ),
              ),
              Container(
                height: 44,
                color: AppColors.layer2,
                child: const Center(
                    child:
                        AppText(text: ':', style: AppTextStyles.bodySemibold)),
              ),
              Flexible(
                child: Center(
                  child: NumberPicker(
                    itemCount: 7,
                    zeroPad: true,
                    haptics: true,
                    infiniteLoop: true,
                    decoration: const BoxDecoration(
                      color: AppColors.layer2,
                    ),
                    minValue: 00,
                    maxValue: 59,
                    value: valueSecond,
                    onChanged: (value) {
                      setState(() {
                        valueSecond = value;
                      });
                    },
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  height: 44,
                  color: AppColors.layer2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
