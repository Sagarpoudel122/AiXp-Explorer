import 'package:flutter/material.dart';

Future<dynamic> showAppDialog({
  required BuildContext context,
  required Widget content,
}) async {
  return await showDialog(context: context, builder: (_) => content);
}
