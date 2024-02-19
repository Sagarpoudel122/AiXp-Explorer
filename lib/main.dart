import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:e2_explorer/src/routes/routes.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/themes/app_theme.dart';
import 'package:e2_explorer/src/utils/theme_utils.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// check theme
  await ThemeUtils.initialize();
  runApp(const MyApp());

  doWhenWindowReady(() {
    // const initialSize = Size(1400, 800);
    const initialSize = Size(500, 700);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = 'E2 Client';
    appWindow.show();
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    ThemeUtils.themeValueNotifier.addListener(_listenToThemeChanges);
    super.initState();
  }

  void _listenToThemeChanges() {
    ThemeUtils.loadThemeColors();
    setState(() {});
    rebuildAllChildren(context);
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el
        ..markNeedsBuild()
        ..visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  void dispose() {
    ThemeUtils.themeValueNotifier.removeListener(_listenToThemeChanges);
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppColors.initialize();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'MQTT Connection Demo',
      theme: appTheme,
      routerConfig: AppRoutes.routes,
    );
  }
}
