import 'dart:html';

class DimenConfig {

  static double horizontal_margin = 24;
  static double vertical_margin = 24;

  static double radius = 16;

  static double getSize(double size) => size;

  static double getTextSize(double size) => size;

  static double getScreenWidth({int? percent}) {
    if (window.screen != null && window.screen!.width != null) {
      if (percent == null) {
        return window.screen!.width!.toDouble();
      } else {
        return (percent / 100) * window.screen!.width!.toDouble();
      }
    }
    return 0.0;
  }

  static double getScreenHeight({int? percent}) {
    if (window.screen != null && window.screen!.height != null) {
      if (percent == null) {
        return window.screen!.height!.toDouble();
      } else {
        return (percent / 100) * window.screen!.height!.toDouble();
      }
    }
    return 0.0;
  }
}
