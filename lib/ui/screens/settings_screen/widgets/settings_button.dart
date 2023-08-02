import 'package:android_freelance_7/ui/components/app_text.dart';
import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:android_freelance_7/utils/app_icons.dart';
import 'package:android_freelance_7/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SettingsButton extends StatefulWidget {
  final String assetName, title;
  final VoidCallback onPressed;

  const SettingsButton({
    required this.assetName,
    required this.title,
    required this.onPressed,
    super.key,
  });

  @override
  State<SettingsButton> createState() => _SettingsButtonState();
}

class _SettingsButtonState extends State<SettingsButton> {
  bool _isHighlighted = false;

  set isHighlighted(bool value) {
    setState(() {
      _isHighlighted = value;
    });
  }

  Color _getChildColor() {
    Color color = AppColors.textPrimary;
    if (_isHighlighted) {
      color = AppColors.textPrimary.withOpacity(0.5);
    }

    return color;
  }

  Color _getBgArrowColor() {
    Color color = const Color(0xFFE3EAF1);
    if (_isHighlighted) {
      color = const Color(0xFFE3EAF1).withOpacity(0.5);
    }

    return color;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (details) {
        isHighlighted = true;
      },
      onTapUp: (details) {
        isHighlighted = false;
      },
      onTapCancel: () {
        isHighlighted = false;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 11),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.layer1,
                  ),
                  child: SvgPicture.asset(widget.assetName),
                ),
                const Gap(12),
                AppText(
                  text: widget.title,
                  style: AppTextStyles.bodyRegular,
                  color: _getChildColor(),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              height: 38,
              width: 38,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color:  _getBgArrowColor(),
              ),
              child: RotatedBox(
                quarterTurns: 90,
                child: SvgPicture.asset(
                  AppIcons.icArrowBack,
                  color: _getChildColor(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
