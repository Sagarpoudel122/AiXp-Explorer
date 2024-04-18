import 'package:e2_explorer/src/features/common_widgets/buttons/app_button_secondary.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum CommandLauncherActionMenuType {
  instance,
  pipeline,
}

class CommandLauncherActionMenu extends StatelessWidget {
  const CommandLauncherActionMenu({super.key, required this.onSelected});

  final ValueChanged<CommandLauncherActionMenuType> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: null,
            enabled: false,
            padding: const EdgeInsets.all(12),
            child: AppButtonSecondary(
              text: 'Instance command',
              onPressed: () {
                onSelected(CommandLauncherActionMenuType.instance);
                Navigator.pop(context);
              },
              icon: SvgPicture.asset(
                'assets/icons/svg/log.svg',
                height: 14,
                width: 14,
              ),
            ),
          ),
          PopupMenuItem(
            padding: const EdgeInsets.all(12),
            onTap: null,
            enabled: false,
            child: AppButtonSecondary(
              text: 'Pipeline command',
              onPressed: () {
                onSelected(CommandLauncherActionMenuType.pipeline);
                Navigator.pop(context);
              },
              icon: SvgPicture.asset(
                'assets/icons/svg/log.svg',
                height: 14,
                width: 14,
              ),
            ),
          ),
        ];
      },
      icon: const Icon(Icons.more_vert),
      color: AppColors.scaffoldBackgroundColor,
      tooltip: 'Show Actions',
      padding: const EdgeInsets.all(12),
      // offset: const Offset(0, 40),
      elevation: 3,
      onSelected: null,
    );
  }
}
