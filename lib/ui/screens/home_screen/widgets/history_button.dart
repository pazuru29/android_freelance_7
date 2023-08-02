import 'package:android_freelance_7/ui/components/app_text.dart';
import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:android_freelance_7/utils/app_icons.dart';
import 'package:android_freelance_7/utils/app_strings.dart';
import 'package:android_freelance_7/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class HistoryButton extends StatefulWidget {
  final VoidCallback onPressed;

  const HistoryButton({
    required this.onPressed,
    super.key,
  });

  @override
  State<HistoryButton> createState() => _HistoryButtonState();
}

class _HistoryButtonState extends State<HistoryButton> {
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

  Color _getMainColor() {
    Color color = AppColors.layer2;
    if (_isHighlighted) {
      color = AppColors.layer2.withOpacity(0.5);
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
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          border: Border.all(
            color: _getMainColor(),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppIcons.icHistory,
              color: _getChildColor(),
            ),
            const Gap(14),
            AppText(
              text: AppStrings.history,
              style: AppTextStyles.bodyRegular,
              color: _getChildColor(),
            ),
          ],
        ),
      ),
    );
  }
}
