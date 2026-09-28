import 'package:flutter/material.dart';

/// Holds the two global toggles: theme (dark/light) and language (en/ar).
class AppController extends ChangeNotifier {
  bool dark = true;
  bool ar = false;

  void toggleTheme() {
    dark = !dark;
    notifyListeners();
  }

  void toggleLocale() {
    ar = !ar;
    notifyListeners();
  }
}

class AppScope extends InheritedNotifier<AppController> {
  const AppScope({super.key, required AppController controller, required super.child}) : super(notifier: controller);

  static AppController of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<AppScope>()!.notifier!;

  static AppController read(BuildContext context) => context.getInheritedWidgetOfExactType<AppScope>()!.notifier!;
}

/// A bilingual string.
class T {
  const T(this.en, this.ar);
  const T.same(String v) : en = v, ar = v;
  final String en;
  final String ar;
}

extension LocaleX on BuildContext {
  bool get isAr => AppScope.of(this).ar;
  String tr(T t) => isAr ? t.ar : t.en;
  String pick(String en, String ar) => isAr ? ar : en;
}

enum ScreenSize { mobile, tablet, desktop }

extension ResponsiveX on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  ScreenSize get screen {
    final w = width;
    if (w < 700) return ScreenSize.mobile;
    if (w < 1100) return ScreenSize.tablet;
    return ScreenSize.desktop;
  }

  bool get isMobile => screen == ScreenSize.mobile;
  bool get isDesktop => screen == ScreenSize.desktop;
}
