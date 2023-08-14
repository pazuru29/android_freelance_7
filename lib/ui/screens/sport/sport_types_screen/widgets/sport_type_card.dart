import 'package:android_freelance_7/ui/components/app_text.dart';
import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:android_freelance_7/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class SportTypeCard extends StatefulWidget {
  final String assetName, title;
  final VoidCallback onPressed;

  const SportTypeCard({
    required this.assetName,
    required this.title,
    required this.onPressed,
    super.key,
  });

  @override
  State<SportTypeCard> createState() => _SportTypeCardState();
}

class _SportTypeCardState extends State<SportTypeCard> {
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
        padding: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _isHighlighted ? AppColors.accentPrimary1 : AppColors.layer1,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Image.asset(widget.assetName),
              ),
              AppText(
                text: widget.title,
                style: AppTextStyles.bold2,
                color: _getMainColor(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
