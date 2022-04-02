import 'package:flutter/material.dart';
import 'package:memorez/Model/Setting.dart';

///Main Theme color
Color themeToColor(AppTheme theme) {
  switch (theme) {
    case AppTheme.PINK:
      {
        return Color(0xFFf774ab);
      }
    case AppTheme.BLUE:
      return Color(0xFF33ACE3);

    // case AppTheme.RED:
    //   return Color(0xFFE00C25);

    case AppTheme.ORANGE:
      return Color(0xFFFF5C13);

    case AppTheme.GREEN:
      return Color(0xff1ca71b);

    case AppTheme.GREY:
      return Color(0xE8C4C3C3);

    // case AppTheme.DARK:
    //   return Color(0xFF070101);

    case AppTheme.PURPLE:
      return Color(0x9F6308BF);

    case AppTheme.YELLOW:
      return Color(0xFFEFD018);
    default:
      return Color(0xFF33ACE3);
  }
}

///Dark or Light Mode background color
Color backgroundMode(bool dark) {
  if (dark) return Color(0xFF282727);
  return Colors.white;
}

///Font color depending on Dark or Light Mode
Color textMode(bool dark) {
  if (dark) return Colors.white;
  return Colors.black;
}

///Divider color depending on Dark or Light Mode
Color dividerColor(bool dark) {
  if (dark) return Color(0x56ffffff);
  return Colors.grey;
}

///Darker accent color
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

    // case AppTheme.RED:
    //   return Color(0xFF921546);

    case AppTheme.ORANGE:
      return Color(0xFF893105);

    case AppTheme.GREEN:
      return Colors.green[900];

    case AppTheme.GREY:
      return Color(0xD76C6C6C);

    // case AppTheme.DARK:
    //   return Color(0x9F070101);

    case AppTheme.PURPLE:
      //return Color(0x9F6308BF);
      return Colors.deepPurple;

    case AppTheme.YELLOW:
      //return Color(0xFFFFDE1C);
      return Colors.orange[900];

    default:
      return Color(0xFF673AB7);
  }
}

///Middle accent color
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
      return Color(0xFFC15227);

    case AppTheme.GREEN:
      //return Color(0xff1ca71b);
      return Colors.green[700];

    case AppTheme.GREY:
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

    default:
      return Color(0xFF448AFF);
  }
}

///Light accent color
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
      return Color(0xFFD0693F);

    case AppTheme.GREEN:
      //return Color(0xff1ca71b);
      return Colors.green[500];

    case AppTheme.GREY:
      return Color(0xE2BDBBBB);

    case AppTheme.DARK:
      return Color(0x9F070101);

    case AppTheme.PURPLE:
      //return Color(0x9F6308BF);
      return Colors.deepPurple[200];

    case AppTheme.YELLOW:
      //return Color(0xFFFFDE1C);
      return Colors.orange[300];

    default:
      return Color(0xFF40C4FF);
  }
}
