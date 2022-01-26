import 'package:flutter/material.dart';
import 'package:untitled3/Model/Setting.dart';

Color themeToColor(AppTheme theme) {
  switch (theme) {
    case AppTheme.PINK:
      {
        return Color(0xFFf774ab);
      }
    case AppTheme.BLUE:
      return Color(0xFF33ACE3);
  }
}
