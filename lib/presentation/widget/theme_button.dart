import 'package:arrivo/domain/configure/colors.dart';
import 'package:arrivo/domain/configure/dimens.dart';
import 'package:arrivo/domain/configure/theme.dart';
import 'package:flutter/material.dart';

enum ButtonType { roundCircle, text }

enum RoundButtonWidthType { shortWidth, longWidth }

class ThemeButton extends StatelessWidget {
  final String? text;
  final Widget? contentWidget;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final Color? color;
  final Color? borderColor;
  final bool enable;
  final Function()? onPressed;

  final double? height;
  final double? width;
  final ButtonType? buttonType;
  final RoundButtonWidthType? roundButtonWidthType;

  const ThemeButton({
    this.text,
    this.contentWidget,
    this.textStyle,
    this.padding,
    this.color,
    this.enable = true,
    this.borderColor,
    this.onPressed,
    this.height,
    this.width,
    this.buttonType = ButtonType.roundCircle,
    this.roundButtonWidthType = RoundButtonWidthType.longWidth,
  });

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case ButtonType.roundCircle:
        return _buildRoundCircleButton();
      case ButtonType.text:
        return _buildTextButton();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildRoundCircleButton() => InkWell(
      onTap: enable ? tap : null,
      child: Container(
        alignment: Alignment.center,
        width: width ?? (roundButtonWidthType == RoundButtonWidthType.longWidth ? DimenConfig.getSize(220) : DimenConfig.getSize(150)),
        height: height ?? DimenConfig.getSize(35),
        decoration: BoxDecoration(
            color: enable ?  color ?? ColorConfig.blueDark2 : ColorConfig.grey,
            borderRadius: BorderRadius.circular(
              10,
            ),
            border: Border.all(
              color: borderColor ?? (color ?? (enable ? ColorConfig.blueDark2 : Colors.transparent)),
            )),
        child: contentWidget ??
            Text(
              text ?? '',
              style: textStyle ?? ThemeService.regularTextStyle(color: Colors.white),
            ),
      ));

  Widget _buildTextButton() => TextButton(
      onPressed: tap,
      child: Text(
        text ?? '',
      ));

  Future<void> tap() async {
    onPressed!();
  }
}
