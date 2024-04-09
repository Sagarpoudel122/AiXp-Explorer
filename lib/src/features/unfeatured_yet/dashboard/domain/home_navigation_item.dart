import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/domain/home_navigation_subitem.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@immutable
class HomeNavigationItem extends Equatable {
  const HomeNavigationItem._({
    required this.label,
    required this.matchingRoutePrefixes,
    required this.onNavigate,
    required this.subItems,
    this.enableLowerDivider = false,
    this.iconData,
    this.svgIconPath,
  }) : assert(
          iconData != null || svgIconPath != null,
          'Both iconData and svgIconPath cannot be null!',
        );

  factory HomeNavigationItem.simple({
    required WidgetBuilder label,
    required List<String> matchingRoutePrefixes,
    required void Function() onNavigate,
    IconData? iconData,
    String? svgIconPath,
    bool enableLowerDivider = false,
  }) {
    return HomeNavigationItem._(
      label: label,
      iconData: iconData,
      matchingRoutePrefixes: matchingRoutePrefixes,
      onNavigate: onNavigate,
      subItems: const <HomeNavigationSubItem>[],
      enableLowerDivider: enableLowerDivider,
      svgIconPath: svgIconPath,
    );
  }

  factory HomeNavigationItem.shell({
    required WidgetBuilder label,
    required List<String> matchingRoutePrefixes,
    required List<HomeNavigationSubItem> subitems,
    IconData? iconData,
    String? svgIconPath,
    bool enableLowerDivider = false,
  }) {
    return HomeNavigationItem._(
      label: label,
      iconData: iconData,
      matchingRoutePrefixes: matchingRoutePrefixes,
      onNavigate: null,
      subItems: subitems,
      svgIconPath: svgIconPath,
      enableLowerDivider: enableLowerDivider,
    );
  }

  final WidgetBuilder label;
  final IconData? iconData;
  final String? svgIconPath;

  // final WidgetBuilder icon;
  final List<String> matchingRoutePrefixes;
  final void Function()? onNavigate;
  final List<HomeNavigationSubItem> subItems;
  final bool enableLowerDivider;

  @override
  List<Object?> get props => <Object?>[matchingRoutePrefixes];
}
