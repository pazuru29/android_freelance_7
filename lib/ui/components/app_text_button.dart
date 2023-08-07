import 'package:android_freelance_7/ui/components/app_text.dart';
import 'package:android_freelance_7/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppTextButton extends StatefulWidget {
  final String text;
  final Color activeBgColor;
  final Color inactiveBgColor;
  final Color pressedBgColor;
  final Color activeChildColor;
  final Color inactiveChildColor;
  final Color pressedChildColor;
  final double height, width;
  final BorderRadius borderRadius;
  final VoidCallback? onPressed;

  const AppTextButton({
    required this.text,
    required this.activeBgColor,
    required this.inactiveBgColor,
    required this.pressedBgColor,
    required this.activeChildColor,
    required this.inactiveChildColor,
    required this.pressedChildColor,
    required this.borderRadius,
    required this.onPressed,
    this.height = 44,
    this.width = 44,
    super.key,
  });

  @override
  State<AppTextButton> createState() => _AppTextButtonState();
}

class _AppTextButtonState extends State<AppTextButton> {
  bool _isHighlighted = false;

  set isHighlighted(bool value) {
    setState(() {
      _isHighlighted = value;
    });
  }

  Color _getChildColor() {
    Color color = widget.activeChildColor;
    if (widget.onPressed == null) {
      color = widget.inactiveChildColor;
    } else if (_isHighlighted) {
      color = widget.pressedChildColor;
    }

    return color;
  }

  Color _getBgColor() {
    Color color = widget.activeBgColor;
    if (widget.onPressed == null) {
      color = widget.inactiveBgColor;
    } else if (_isHighlighted) {
      color = widget.pressedBgColor;
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
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          color: _getBgColor(),
        ),
        child: FittedBox(
          child: Center(
            child: AppText(
              text: widget.text,
              style: AppTextStyles.bold2,
              color: _getChildColor(),
            ),
          ),
        ),
      ),
    );
  }
}
