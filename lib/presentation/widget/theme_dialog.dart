import 'package:arrivo/domain/configure/theme.dart';
import 'package:arrivo/presentation/widget/theme_button.dart';
import 'package:flutter/material.dart';

class ThemeDialog extends StatelessWidget {
  final String? title, message, positiveLabel, negativeLabel;
  final Function()? positiveAction, negativeAction;
  final bool? barrierDismissible;
  final double? paddingSize;
  final Widget? contentWidget;

  ThemeDialog({
    this.title,
    this.message,
    this.contentWidget,
    this.positiveLabel,
    this.positiveAction,
    this.negativeLabel,
    this.negativeAction,
    this.barrierDismissible,
    this.paddingSize,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(barrierDismissible ?? true);
      },
      child: _dialogWidget(context),
    );
  }

  Widget _dialogWidget(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: paddingSize != null ? EdgeInsets.all(paddingSize!) : EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
            ),
          ],
        ),
        child: contentWidget ??
            Wrap(
              runSpacing: 24,
              children: [
                Visibility(
                  visible: title != null,
                  child: Center(
                    child: Text(
                      title ?? 'Title',
                      style: ThemeService.boldTextStyle(fontSize: 15),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    message ?? '',
                    style: ThemeService.regularTextStyle(fontSize: 13),
                  ),
                ),
                Container(
                  child: negativeAction != null
                      ? Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 8),
                                child: ThemeButton(
                                  onPressed: negativeAction,
                                  text: negativeLabel ?? 'Cancel',
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 8),
                                child: ThemeButton(onPressed: positiveAction, text: positiveLabel ?? 'Ok'),
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: ThemeButton(
                              onPressed: positiveAction ??
                                  () {
                                    Navigator.of(context).pop();
                                  },
                              text: positiveLabel ?? 'ok')),
                )
              ],
            ),
      ),
    );
  }

  static Future<dynamic> show({
    required BuildContext context,
    String? title,
    String? message,
    Widget? contentWidget,
    String? positiveLabel,
    Function()? positiveAction,
    String? negativeLabel,
    Function()? negativeAction,
    bool? barrierDismissible = false,
    double? paddingSize,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return ThemeDialog(
            title: title,
            message: message,
            contentWidget: contentWidget,
            positiveLabel: positiveLabel,
            positiveAction: positiveAction,
            negativeLabel: negativeLabel,
            negativeAction: negativeAction,
            barrierDismissible: barrierDismissible,
            paddingSize: paddingSize,
          );
        });
  }
}
