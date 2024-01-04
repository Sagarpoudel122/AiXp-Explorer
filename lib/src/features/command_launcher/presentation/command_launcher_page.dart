import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CommandLauncherPage extends StatelessWidget {
  const CommandLauncherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Command Launcher',
            style: TextStyles.h4(),
          ),
          
        ],
      ),
    );
  }
}
