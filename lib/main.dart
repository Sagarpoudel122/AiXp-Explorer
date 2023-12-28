import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:e2_explorer/src/design/colors.dart';
import 'package:e2_explorer/src/design/layouts/desktop_app_layout.dart';
import 'package:e2_explorer/src/routes/routes.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HFColors.loadDarkTheme();
  HFColors.loadLightTheme();
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MQTT Connection Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'MQTT Connection Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WindowBorder(
        width: 1,
        color: ColorStyles.dark700,
        child: Container(
          color: ColorStyles.dark900,
          // color: const Color.fromRGBO(45, 45, 45, 1.0),
          child: Center(
            child: DesktopAppLayout(
              child: MaterialApp.router(
                routerConfig: AppRoutes.routes,
              ),
            ),
            // child: LandingScreen(),
          ),
        ),
      ),
    );
  }
}
