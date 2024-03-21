import 'package:flutter/cupertino.dart';

import 'dimens.dart';

enum ScreenType {
  desktop,
  tablet,
  handset,
}

extension ScreenTypeHelper on ScreenType {
  bool get isDesktop => this == ScreenType.desktop;

  bool get isTablet => this == ScreenType.tablet;

  bool get isHandset => this == ScreenType.handset;

  T map<T>({
    required T Function(ScreenType) desktop,
    required T Function(ScreenType) tablet,
    required T Function(ScreenType) mobile,
  }) {
    if (isDesktop) {
      return desktop(this);
    }
    if (isTablet) {
      return tablet(this);
    }
    if (isHandset) {
      return mobile(this);
    }
    throw ArgumentError.value(this);
  }

  T? mapOrNull<T>({
    T Function(ScreenType)? desktop,
    T Function(ScreenType)? tablet,
    T Function(ScreenType)? mobile,
  }) {
    if (isDesktop && desktop != null) {
      return desktop(this);
    }
    if (isTablet && tablet != null) {
      return tablet(this);
    }
    if (isHandset && mobile != null) {
      return mobile(this);
    }
    return null;
  }

  T mapOrElse<T>({
    T Function(ScreenType)? desktop,
    T Function(ScreenType)? tablet,
    T Function(ScreenType)? mobile,
    required T Function(ScreenType) orElse,
  }) {
    if (isDesktop && desktop != null) {
      return desktop(this);
    }
    if (isTablet && tablet != null) {
      return tablet(this);
    }
    if (isHandset && mobile != null) {
      return mobile(this);
    }
    return orElse(this);
  }

  static ScreenType getScreenType(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final Size size = mediaQuery.size;
    // final devicePixelRatio = mediaQuery.devicePixelRatio;

    if (size.width >= Dimens.desktopWidth) {
      return ScreenType.desktop;
    } else if (size.width >= Dimens.tabletWidth) {
      return ScreenType.tablet;
    } else {
      return ScreenType.handset;
    }
  }
}

enum ScreenWidthInterval {
  widthUndefined,
  width600,
  width700,
  width800,
  width900,
  width1000,
  width1100,
  width1200,
  width1300,
  width1400,
  width1500,
  width1600,
  width1700,
  width1800,
  width1900,
}

extension ScreenWidthHelper on ScreenWidthInterval {
  static ScreenWidthInterval getScreenWidthInterval(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    //print('Screen width $width');

    if (width >= 1900) {
      return ScreenWidthInterval.width1900;
    } else if (width >= 1800) {
      return ScreenWidthInterval.width1800;
    } else if (width >= 1700) {
      return ScreenWidthInterval.width1700;
    } else if (width >= 1600) {
      return ScreenWidthInterval.width1600;
    } else if (width >= 1500) {
      return ScreenWidthInterval.width1500;
    } else if (width >= 1400) {
      return ScreenWidthInterval.width1400;
    } else if (width >= 1300) {
      return ScreenWidthInterval.width1300;
    } else if (width >= 1200) {
      return ScreenWidthInterval.width1200;
    } else if (width >= 1100) {
      return ScreenWidthInterval.width1100;
    } else if (width >= 1000) {
      return ScreenWidthInterval.width1000;
    } else if (width >= 900) {
      return ScreenWidthInterval.width900;
    } else if (width >= 800) {
      return ScreenWidthInterval.width800;
    } else if (width >= 700) {
      return ScreenWidthInterval.width700;
    } else if (width >= 600) {
      return ScreenWidthInterval.width600;
    }

    return ScreenWidthInterval.widthUndefined;
    // }
  }

  static int convertToInt(ScreenWidthInterval screenWidthInterval) {
    switch (screenWidthInterval) {
      case ScreenWidthInterval.width600:
        return 600;
      case ScreenWidthInterval.width700:
        return 700;
      case ScreenWidthInterval.width800:
        return 800;
      case ScreenWidthInterval.width900:
        return 900;
      case ScreenWidthInterval.width1000:
        return 1000;
      case ScreenWidthInterval.width1100:
        return 1100;
      case ScreenWidthInterval.width1200:
        return 1200;
      case ScreenWidthInterval.width1300:
        return 1300;
      case ScreenWidthInterval.width1400:
        return 1400;
      case ScreenWidthInterval.width1500:
        return 1500;
      case ScreenWidthInterval.width1600:
        return 1600;
      case ScreenWidthInterval.width1700:
        return 1700;
      case ScreenWidthInterval.width1800:
        return 1800;
      case ScreenWidthInterval.width1900:
        return 1900;
      case ScreenWidthInterval.widthUndefined:
        return -1;
    }
  }
}
