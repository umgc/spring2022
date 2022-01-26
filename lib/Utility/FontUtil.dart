import 'package:untitled3/Model/Setting.dart';

double fontSizeToPixelMap(FontSize fontSize, bool smaller) {
  double multiplier = smaller ? .8 : 1;
  switch (fontSize) {
    case FontSize.SMALL:
      {
        return 18.0 * multiplier;
      }
    case FontSize.MEDIUM:
      {
        return 22.0 * multiplier;
      }
    case FontSize.LARGE:
      {
        return 28.0 * multiplier;
      }
    default:
      {
        return fontSizeToPixelMap(FontSize.MEDIUM, smaller);
      }
  }
}
