import 'package:android_freelance_7/ui/components/app_text.dart';
import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:android_freelance_7/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final String title;
  final double? width;
  final double height;
  final BorderRadius? borderRadius;
  final bool needShadow;
  final VoidCallback? onPressed;
  bool isOutlined = false;

  AppButton({
    Key? key,
    required this.title,
    this.width,
    this.height = 48,
    this.needShadow = false,
    this.borderRadius,
    this.onPressed,
  }) : super(key: key);

  static AppButton outlined({
    required String title,
    double? width,
    double height = 48,
    VoidCallback? onPressed,
  }) {
    return AppButton(
      title: title,
      height: height,
      width: width,
      onPressed: onPressed,
    )..isOutlined = true;
  }

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isHighlighted = false;

  set isHighlighted(bool value) {
    setState(() {
      if (widget.onPressed != null) {
        _isHighlighted = value;
      }
    });
  }

  Color _getMainColor() {
    Color color = AppColors.accentPrimary1;
    if (widget.onPressed == null) {
      color = AppColors.layer3;
    } else if (_isHighlighted) {
      color = AppColors.accentPrimary2;
    }

    return color;
  }

  Widget _getMainWidget() {
    return Center(
      child: _getTexWidget(),
    );
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
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
        decoration: BoxDecoration(
          boxShadow: widget.needShadow
              ? [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 3.0,
                      spreadRadius: 0,
                      offset: const Offset(0.0, 1)),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8.0,
                    spreadRadius: 3,
                    offset: const Offset(0.0, 4),
                  ),
                ]
              : null,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(100),
          border: widget.isOutlined
              ? Border.all(color: _getMainColor(), width: 2)
              : null,
          color: widget.isOutlined ? Colors.transparent : _getMainColor(),
        ),
        child: Center(child: _getMainWidget()),
      ),
    );
  }

  AppText _getTexWidget() {
    return AppText(
      style: AppTextStyles.bold2,
      text: widget.title,
      color: widget.isOutlined ? _getMainColor() : _getTextColor(),
    );
  }

  Color _getTextColor() {
    Color color = Colors.white;
    if (widget.onPressed == null) {
      color = Colors.white.withOpacity(0.5);
    } else if (_isHighlighted) {
      color = Colors.white.withOpacity(0.7);
    }

    return color;
  }
}
