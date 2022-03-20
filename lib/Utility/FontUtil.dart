import 'package:memorez/Model/Setting.dart';

double fontSizeToPixelMap(FontSize fontSize, bool smaller) {
  double multiplier = smaller ? .8 : 1;
  switch (fontSize) {
    case FontSize.SMALL:
      {
        return 16.0 * multiplier;
      }
    case FontSize.MEDIUM:
      {
        return 20.0 * multiplier;
      }
    case FontSize.LARGE:
      {
        return 24.0 * multiplier;
      }
    default:
      {
        return fontSizeToPixelMap(FontSize.MEDIUM, smaller);
      }
  }
}
