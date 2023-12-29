
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/domain/home_navigation_subitem.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class HomeNavigationItem extends Equatable {
  const HomeNavigationItem._({
    required this.label,
    required this.icon,
    required this.matchingRoutePrefixes,
    required this.onNavigate,
    required this.subItems,
    this.enableLowerDivider = false,
  });

  factory HomeNavigationItem.simple({
    required WidgetBuilder label,
    required WidgetBuilder icon,
    required List<String> matchingRoutePrefixes,
    required void Function() onNavigate,
    bool enableLowerDivider = false,
  }) {
    return HomeNavigationItem._(
      label: label,
      icon: icon,
      matchingRoutePrefixes: matchingRoutePrefixes,
      onNavigate: onNavigate,
      subItems: const <HomeNavigationSubItem>[],
      enableLowerDivider: enableLowerDivider,
    );
  }

  factory HomeNavigationItem.shell({
    required WidgetBuilder label,
    required WidgetBuilder icon,
    required List<String> matchingRoutePrefixes,
    required List<HomeNavigationSubItem> subitems,
  }) {
    return HomeNavigationItem._(
      label: label,
      icon: icon,
      matchingRoutePrefixes: matchingRoutePrefixes,
      onNavigate: null,
      subItems: subitems,
    );
  }

  final WidgetBuilder label;
  final WidgetBuilder icon;
  final List<String> matchingRoutePrefixes;
  final void Function()? onNavigate;
  final List<HomeNavigationSubItem> subItems;
  final bool enableLowerDivider;

  @override
  List<Object?> get props => <Object?>[matchingRoutePrefixes];
}
