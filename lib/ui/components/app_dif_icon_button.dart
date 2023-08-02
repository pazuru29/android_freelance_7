import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppDifIconButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String icon, pressedIcon, inactiveIcon;

  const AppDifIconButton({
    Key? key,
    required this.icon,
    required this.pressedIcon,
    required this.inactiveIcon,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<AppDifIconButton> createState() => _AppDifIconButtonState();
}

class _AppDifIconButtonState extends State<AppDifIconButton> {
  bool _isHighlighted = false;

  set isHighlighted(bool value) {
    setState(() {
      _isHighlighted = value;
    });
  }

  String _getMainIcon() {
    String assetName = widget.icon;
    if (widget.onPressed == null) {
      assetName = widget.inactiveIcon;
    } else if (_isHighlighted) {
      assetName = widget.pressedIcon;
    }

    return assetName;
  }

  Widget _getMainWidget() {
    return SvgPicture.asset(
      _getMainIcon(),
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
      child: _getMainWidget(),
    );
  }
}
