import 'package:android_freelance_7/ui/components/app_text.dart';
import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:android_freelance_7/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class MainMenuCard extends StatefulWidget {
  final String assetName, title;
  final double? height, width;
  final EdgeInsets paddings;
  final bool isHorizontal;
  final VoidCallback onPressed;

  const MainMenuCard({
    required this.assetName,
    required this.title,
    required this.paddings,
    required this.onPressed,
    this.isHorizontal = false,
    this.height,
    this.width,
    super.key,
  });

  @override
  State<MainMenuCard> createState() => _MainMenuCardState();
}

class _MainMenuCardState extends State<MainMenuCard> {
  bool _isHighlighted = false;

  set isHighlighted(bool value) {
    setState(() {
      _isHighlighted = value;
    });
  }

  Color _getMainColor() {
    Color color = AppColors.textPrimary;
    if (_isHighlighted) {
      color = Colors.white;
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
        height: widget.height,
        width: widget.width,
        padding: widget.paddings,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _isHighlighted ? AppColors.accentPrimary1 : AppColors.layer1,
        ),
        child: _getBody(),
      ),
    );
  }

  Widget _getBody() {
    if (widget.isHorizontal) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            widget.assetName,
            color: _getMainColor(),
          ),
          const Gap(10),
          AppText(
            text: widget.title,
            style: _isHighlighted
                ? AppTextStyles.bold2
                : AppTextStyles.bodyRegular,
            color: _getMainColor(),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          SvgPicture.asset(
            widget.assetName,
            color: _getMainColor(),
          ),
          const Spacer(),
          FittedBox(
            child: AppText(
              text: widget.title,
              style: _isHighlighted
                  ? AppTextStyles.bold2
                  : AppTextStyles.bodyRegular,
              color: _getMainColor(),
              maxLines: null,
              align: TextAlign.center,
            ),
          ),
        ],
      );
    }
  }
}
