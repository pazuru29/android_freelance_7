import 'package:android_freelance_7/controllers/app_navigator.dart';
import 'package:android_freelance_7/ui/components/app_text.dart';
import 'package:android_freelance_7/ui/components/number_picker.dart';
import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:android_freelance_7/utils/app_strings.dart';
import 'package:android_freelance_7/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class NumberOfPlayersPicker extends StatefulWidget {
  final int initValue;
  final Function(int) onApply;

  const NumberOfPlayersPicker({
    required this.initValue,
    required this.onApply,
    super.key,
  });

  @override
  State<NumberOfPlayersPicker> createState() => _NumberOfPlayersPickerState();
}

class _NumberOfPlayersPickerState extends State<NumberOfPlayersPicker> {
  late int numberOfPlayer;

  @override
  void initState() {
    numberOfPlayer =
        widget.initValue > 4 || widget.initValue < 2 ? 2 : widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
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
                const AppText(text: 'Time', style: AppTextStyles.bodySemibold),
                GestureDetector(
                  onTap: () {
                    AppNavigator.goBack(context);
                    widget.onApply(numberOfPlayer);
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
                    itemCount: 3,
                    haptics: true,
                    infiniteLoop: true,
                    decoration: const BoxDecoration(
                      color: AppColors.layer2,
                    ),
                    minValue: 2,
                    maxValue: 4,
                    value: numberOfPlayer,
                    onChanged: (value) {
                      setState(() {
                        numberOfPlayer = value;
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
