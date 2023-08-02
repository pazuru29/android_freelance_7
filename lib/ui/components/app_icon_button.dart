import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIconButton extends StatefulWidget {
  final String assetName;
  final VoidCallback onPressed;

  const AppIconButton({
    required this.assetName,
    required this.onPressed,
    super.key,
  });

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  bool _isHighlighted = false;

  set isHighlighted(bool value) {
    setState(() {
      _isHighlighted = value;
    });
  }

  Color _getMainColor() {
    Color color = AppColors.textPrimary;
    if (_isHighlighted) {
      color = AppColors.textPrimary.withOpacity(0.5);
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
        color: Colors.transparent,
        child: Center(
          child: SvgPicture.asset(
            widget.assetName,
            color: _getMainColor(),
          ),
        ),
      ),
    );
  }
}
