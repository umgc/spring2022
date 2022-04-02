import 'package:flutter/material.dart';
import 'package:memorez/Model/Setting.dart';

Color themeToColor(AppTheme theme) {
  switch (theme) {
    case AppTheme.PINK:
      {
        return Color(0xFFf774ab);
      }
    case AppTheme.BLUE:
      return Color(0xFF33ACE3);

    case AppTheme.RED:
      return Color(0xFFE00C25);

    case AppTheme.ORANGE:
      return Color(0xFFFF5C13);

    case AppTheme.GREEN:
      return Color(0xff1ca71b);

    case AppTheme.LIGHT:
      return Color(0xE8C4C3C3);

    case AppTheme.DARK:
      return Color(0xFF070101);

    case AppTheme.PURPLE:
      return Color(0x9F6308BF);

    case AppTheme.YELLOW:
      return Color(0xFFEFD018);
  }
}

Color backgroundMode(bool dark) {
  if (dark) return Color(0xFF282727);
  return Colors.white;
}

Color textMode(bool dark) {
  if (dark) return Colors.white;
  return Colors.black;
}

Color dividerColor(bool dark) {
  if (dark) return Color(0x56ffffff);
  return Colors.grey;
}

Color? accent2(AppTheme theme) {
  switch (theme) {
    case AppTheme.PINK:
      {
        //return Color(0xFFf774ab);
        return Color(0xFFA32A59);
      }
    case AppTheme.BLUE:
      return Color(0xFF673AB7);
    //return Colors.deepPurple;

    case AppTheme.RED:
      return Color(0xFF921546);

    case AppTheme.ORANGE:
      return Color(0xFFFF5C13);

    case AppTheme.GREEN:
      return Colors.green[900];

    case AppTheme.LIGHT:
      return Color(0xD76C6C6C);

    case AppTheme.DARK:
      return Color(0x9F070101);

    case AppTheme.PURPLE:
      //return Color(0x9F6308BF);
      return Colors.deepPurple;

    case AppTheme.YELLOW:
      //return Color(0xFFFFDE1C);
      return Colors.orange[900];
  }
}

Color? accent1(AppTheme theme) {
  switch (theme) {
    case AppTheme.PINK:
      {
        // return Color(0xFFf774ab);
        return Color(0xFFC74C74);
      }
    case AppTheme.BLUE:
      return Color(0xFF448AFF);
    // return Colors.blueAccent;

    case AppTheme.RED:
      return Color(0xFF9E435E);

    case AppTheme.ORANGE:
      return Color(0xFFFF5C13);

    case AppTheme.GREEN:
      //return Color(0xff1ca71b);
      return Colors.green[700];

    case AppTheme.LIGHT:
      return Color(0xE29E9E9E);

    case AppTheme.DARK:
      return Color(0x9F070101);

    case AppTheme.PURPLE:
      //  return Color(0x9F6308BF);
      return Colors.deepPurple[400];

    case AppTheme.YELLOW:
      //return Color(0xFFFFDE1C);
      //return Colo
      return Colors.orange[600];
  }
}

Color? accent3(AppTheme theme) {
  switch (theme) {
    case AppTheme.PINK:
      {
        //return Color(0xFFf774ab);
        return Color(0xFFDB7798);
      }
    case AppTheme.BLUE:
      return Color(0xFF40C4FF);
    //return Colors.lightBlueAccent;

    case AppTheme.RED:
      return Color(0xFFDB7798);

    case AppTheme.ORANGE:
      return Color(0xFFFF5C13);

    case AppTheme.GREEN:
      //return Color(0xff1ca71b);
      return Colors.green[500];

    case AppTheme.LIGHT:
      return Color(0xE2BDBBBB);

    case AppTheme.DARK:
      return Color(0x9F070101);

    case AppTheme.PURPLE:
      //return Color(0x9F6308BF);
      return Colors.deepPurple[200];

    case AppTheme.YELLOW:
      //return Color(0xFFFFDE1C);
      return Colors.orange[300];
  }
}
