import 'package:flutter/material.dart';

/// Used to define which navigation items are going to be displayed in our navigation menu
///
/// title -> the text displayed in the button (TBD if this remains the same)
///
/// pageWidget -> the Widget that is going to be render on the right side of the screen
class NavigationItem {
  const NavigationItem({
    required this.title,
    required this.pageWidget,
    this.icon,
    this.children,
  });

  final Widget pageWidget;
  final IconData? icon;
  final String title;
  final List<NavigationItem>? children;
}
