import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:android_freelance_7/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final double? width;
  final double? height;
  final AppStyle style;
  final TextInputType textInputType;
  final int? maxLines;
  final TextAlign textAlign;
  final Function(String) onChanged;
  final int? lengthLimiting;
  final TextInputAction textInputAction;
  final Color textColor;
  final bool autoFocus;
  final String? hintText;
  final List<TextInputFormatter>? filteringTextInputFormatter;
  final bool needIcon;
  final VoidCallback? onTapOutside;

  const AppTextField({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    this.width,
    this.height = 50,
    this.style = AppTextStyles.bodyRegular,
    this.textInputType = TextInputType.text,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.lengthLimiting,
    this.textInputAction = TextInputAction.done,
    this.textColor = AppColors.textPrimary,
    this.autoFocus = false,
    this.hintText,
    this.filteringTextInputFormatter,
    this.needIcon = false,
    this.onTapOutside,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              textInputAction: textInputAction,
              autofocus: autoFocus,
              cursorColor: AppColors.textPrimary,
              cursorHeight: 18,
              style: TextStyle(
                fontSize: style.fontSize,
                fontWeight: style.fontWeight,
                color: AppColors.textPrimary,
              ),
              keyboardType: textInputType,
              maxLines: maxLines,
              textAlign: textAlign,
              onChanged: (text) {
                onChanged(text);
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(lengthLimiting),
                if (filteringTextInputFormatter != null)
                  ...filteringTextInputFormatter!,
              ],
              decoration: InputDecoration(
                hintText: hintText,
                hintMaxLines: 1,
                hintStyle: TextStyle(
                  fontSize: style.fontSize,
                  fontWeight: style.fontWeight,
                  color: AppColors.layer3,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              ),
              onTapOutside: (_) {
                focusNode.unfocus();
                if (onTapOutside != null) {
                  onTapOutside!();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
