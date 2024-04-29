import 'package:flutter/material.dart';

Future<dynamic> showAppDialog({
  required BuildContext context,
  required Widget content,
}) async {
  return await showDialog(context: context, builder: (_) => content);
}

String timeAgoString(int seconds) {
  final duration = Duration(seconds: seconds);
  if (duration.inDays > 0) {
    return '${duration.inDays} days ago';
  }
  if (duration.inHours > 0) {
    return '${duration.inHours} hours ago';
  }
  if (duration.inMinutes > 0) {
    return '${duration.inMinutes} minutes ago';
  }
  return '$seconds sec ago';
}
